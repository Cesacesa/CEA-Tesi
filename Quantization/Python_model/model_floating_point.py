import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
import brevitas.nn as qnn
from brevitas.quant import Int8WeightPerTensorFloat, Int8ActPerTensorFloat, Int32Bias
import onnx
from onnx import helper
import numpy as np
import os
import matplotlib.pyplot as plt



def dump_tensor_to_txt(tensor, path, label):
    """Salva un tensor numpy su file mantenendo la struttura matriciale con massima precisione"""
    with open(path, 'w') as f:
        f.write(f"{label} (shape: {tensor.shape}):\n")
        
        if tensor.ndim == 4:  # Batch x Channel x H x W
            for b in range(tensor.shape[0]):
                f.write(f"\n=== Batch {b} ===\n")
                for c in range(tensor.shape[1]):
                    f.write(f"-- Channel {c} --\n")
                    for row in tensor[b, c]:
                        f.write(" ".join([repr(val) for val in row]) + "\n")
                    f.write("\n")
        elif tensor.ndim == 2:  # Batch x Features
            for b in range(tensor.shape[0]):
                f.write(" ".join([repr(val) for val in tensor[b]]) + "\n")
        elif tensor.ndim == 1:
            f.write(" ".join([repr(val) for val in tensor]) + "\n")
        else:
            np.savetxt(f, tensor.flatten(), fmt='%r')



class SimpleCNNQuantFP(nn.Module):
    def __init__(self, num_classes=10):
        super(SimpleCNNQuantFP, self).__init__()
        
        self.quant_inp = qnn.QuantIdentity(
            act_quant=Int8ActPerTensorFloat,
            return_quant_tensor=True
        )

        self.conv1 = qnn.QuantConv2d(
            in_channels=3,
            out_channels=8,
            kernel_size=3,
            padding=0,
            bias=False,
            weight_quant=Int8WeightPerTensorFloat,
            act_quant=Int8ActPerTensorFloat,
            return_quant_tensor=True
        )

        self.relu = qnn.QuantReLU(
            act_quant=Int8ActPerTensorFloat,
            return_quant_tensor=True
        )

        self.global_avg_pool = nn.AdaptiveAvgPool2d((1, 1))

        self.fc = qnn.QuantLinear(
            in_features=8,
            out_features=num_classes,
            weight_quant=Int8WeightPerTensorFloat,
            act_quant=Int8ActPerTensorFloat,
            bias_quant=Int32Bias,
            return_quant_tensor=True
        )

    def forward(self, x):
        x = self.quant_inp(x)
        x = self.conv1(x)
        x = self.relu(x)
        x = self.global_avg_pool(x)
        x = x.view(x.size(0), -1)
        x = self.fc(x)
        return x

def main():
    torch.manual_seed(42)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    
    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))
    ])
    
    # Carica il dataset CIFAR-10
    train_dataset = torchvision.datasets.CIFAR10(
        root='../data', 
        train=True, 
        download=True, 
        transform=transform)
    
    # Seleziona un'immagine specifica (primo aeroplano)
    class_names = ['airplane', 'automobile', 'bird', 'cat', 'deer', 
                   'dog', 'frog', 'horse', 'ship', 'truck']
    class_idx = 0  # 0 = aeroplano
    target_indices = [i for i, (_, label) in enumerate(train_dataset) if label == class_idx]
    selected_idx = target_indices[0]
    
    image, label = train_dataset[selected_idx]

    
    # Prepara l'input per il modello
    dummy_input = image.unsqueeze(0).to(device)  # Aggiungi dimensione batch
    
    # Modello
    model = SimpleCNNQuantFP(num_classes=10).to(device)
    model.eval()
    
    # Export ONNX
    save_dir = "./Quantization/Nets"
    os.makedirs(save_dir, exist_ok=True)
    save_path = os.path.join(save_dir, "simple_cnn_fp8.onnx")
    
    from brevitas.export import export_onnx_qcdq
    export_onnx_qcdq(
        model,
        dummy_input,
        save_path,
        input_names=["input"],
        output_names=["output"],
        opset_version=13
    )
    
    print(f"Modello FP8 esportato in: {save_path}")

    # Verifica e correzione del modello ONNX
    model_onnx = onnx.load(save_path)
    
    # Identifica i nomi corretti dei nodi
    valid_outputs = []
    potential_outputs = [
    "/conv1/Conv_output_0",
    "/relu/act_quant/activation_impl/Relu_output_0",
    "/relu/act_quant/export_handler/QuantizeLinear_output_0",
    "output"
]
    
    for name in potential_outputs:
        for node in model_onnx.graph.node:
            if name in node.output:
                valid_outputs.append(name)
                break
    
    # Aggiungi solo gli output validi
    for node_name in valid_outputs:
        intermediate_layer_info = helper.ValueInfoProto()
        intermediate_layer_info.name = node_name
        model_onnx.graph.output.append(intermediate_layer_info)
    
    onnx.save(model_onnx, save_path)

    # Inferenza con ONNX Runtime
    import onnxruntime as ort
    ort_session = ort.InferenceSession(save_path)
    input_name = ort_session.get_inputs()[0].name
    
    dummy_input_np = dummy_input.cpu().numpy()
    output_names = [output.name for output in ort_session.get_outputs()]
    all_outputs = ort_session.run(output_names, {input_name: dummy_input_np})
    
    # Salva i risultati
    dump_dir = "./Dump_files_FP8_FullPrecision"
    os.makedirs(dump_dir, exist_ok=True)
    
    # Salva l'input
    dump_tensor_to_txt(dummy_input_np, os.path.join(dump_dir, "input_full_precision.txt"), "Input Image")
    
    # Salva gli output
    for output, name in zip(all_outputs, output_names):
        if "conv1" in name:
            fname = "conv1_output_full_precision.txt"
        elif "Relu" in name:
            fname = "relu_output_full_precision.txt"
        elif "QuantizeLinear" in name:
            fname = "quantize_linear_output_full_precision.txt"
        elif name == "output":
            fname = "output_full_precision.txt"
        else:
            fname = f"{name.replace('/', '_')}_full_precision.txt"
        dump_tensor_to_txt(output, os.path.join(dump_dir, fname), name)

    print(f"Risultati salvati con massima precisione in: {dump_dir}")


if __name__ == "__main__":
    main()