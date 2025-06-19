import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
import brevitas.nn as qnn
from brevitas.quant import Int8WeightPerTensorFixedPoint, Int8ActPerTensorFixedPoint, Int32Bias
import onnx
from onnx import helper
import numpy as np
import os

def dump_tensor_to_txt(tensor, path, label):
    """
    Salva un tensor numpy su file, mantenendo la struttura matriciale per batch, canali e dimensioni spaziali.
    """
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
        elif tensor.ndim == 2:  # Batch x Class
            for b in range(tensor.shape[0]):
                f.write(" ".join([repr(val) for val in tensor[b]]) + "\n")
        elif tensor.ndim == 1:
            f.write(" ".join([repr(val) for val in tensor]) + "\n")
        else:
            f.write(repr(tensor))

class SimpleCNNQuant(nn.Module):
    def __init__(self, num_classes=10):
        super(SimpleCNNQuant, self).__init__()

        self.quant_inp = qnn.QuantIdentity(
            act_quant=Int8ActPerTensorFixedPoint,
            return_quant_tensor=True
        )

        self.conv1 = qnn.QuantConv2d(
            in_channels=3,
            out_channels=8,
            kernel_size=3,
            padding=0,
            bias=False,
            weight_quant=Int8WeightPerTensorFixedPoint,
            act_quant=Int8ActPerTensorFixedPoint,
            return_quant_tensor=True
        )

        self.relu = qnn.QuantReLU(
            act_quant=Int8ActPerTensorFixedPoint,
            return_quant_tensor=True
        )

        self.global_avg_pool = nn.AdaptiveAvgPool2d((1, 1))

        self.fc = qnn.QuantLinear(
            in_features=8,
            out_features=num_classes,
            weight_quant=Int8WeightPerTensorFixedPoint,
            act_quant=Int8ActPerTensorFixedPoint,
            input_quant=Int8ActPerTensorFixedPoint,
            output_quant=Int8ActPerTensorFixedPoint,
            bias=None,
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
    transform = transforms.Compose([transforms.ToTensor()])
    train_dataset = torchvision.datasets.CIFAR10(root='/home/jajo/quantization/data', train=True, download=True, transform=transform)
    train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = SimpleCNNQuant(num_classes=10).to(device)

    data_iter = iter(train_loader)
    images, labels = next(data_iter)
    images = images.to(device)
    dummy_input = images[:1]

    save_dir = "./Quantization/Nets"
    os.makedirs(save_dir, exist_ok=True)
    save_path = os.path.join(save_dir, "simple_cnn_quant_cifar10_qcdq_fixed.onnx")

    from brevitas.export import export_onnx_qcdq
    export_onnx_qcdq(
        model,
        dummy_input,
        save_path,
        input_names=["input"],
        output_names=["output"]
    )
    print("Modello esportato con Q/DQ come 'simple_cnn_quant_cifar10_qcdq.onnx'")

    model_onnx = onnx.load(save_path)

    for node_name in [
    "/conv1/Conv_output_0",
    "/relu/act_quant/activation_impl/Relu_output_0",
    "/relu/act_quant/export_handler/QuantizeLinear_output_0"
]:
        intermediate_layer_info = helper.ValueInfoProto()
        intermediate_layer_info.name = node_name
        model_onnx.graph.output.append(intermediate_layer_info)

    onnx.save(model_onnx, save_path)

    import onnxruntime as ort
    ort_session = ort.InferenceSession(save_path)
    input_name = ort_session.get_inputs()[0].name
    output_name = ort_session.get_outputs()[0].name

    dummy_input_np = dummy_input.cpu().numpy()

    # Inferenza
    pred_onnx = ort_session.run([output_name], {input_name: dummy_input_np})
    conv1_output = ort_session.run(["/conv1/Conv_output_0"], {input_name: dummy_input_np})
    relu_output = ort_session.run(["/relu/act_quant/activation_impl/Relu_output_0"], {input_name: dummy_input_np})
    quantize_output = ort_session.run(["/relu/act_quant/export_handler/QuantizeLinear_output_0"], {input_name: dummy_input_np})

    # Dump directory
    os.makedirs("./Dump_files", exist_ok=True)

    # Dump input image
    dump_tensor_to_txt(dummy_input_np, "./Dump_files/input_image_fixed_point.txt", "Input image tensor")

    # Dump final prediction
    dump_tensor_to_txt(pred_onnx[0], "./Dump_files/output_prediction_fixed_point.txt", "Output from ONNX model")

    # Dump conv1 output
    dump_tensor_to_txt(conv1_output[0], "./Dump_files/conv1_output_fixed_point.txt", "Output of conv1")

    # Dump QuantizeLinear output
    dump_tensor_to_txt(quantize_output[0], "./Dump_files/quantize_linear_output_fixed_point.txt", "Output of QuantizeLinear after ReLU")

    # Dump ReLU output
    dump_tensor_to_txt(relu_output[0], "./Dump_files/relu_output_fixed_point.txt", "Output of ReLU quantized")

    print("Tutti i file sono stati salvati in ./Dump_files")

if __name__ == "__main__":
    main()
