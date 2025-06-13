import torch
import torch.nn as nn
import torchvision
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
import brevitas.nn as qnn
from brevitas.quant import Int8WeightPerTensorFixedPoint, Int8ActPerTensorFixedPoint, Int32Bias

class SimpleCNNQuant(nn.Module):
    def __init__(self, num_classes=10):
        super(SimpleCNNQuant, self).__init__()

        # Quantizzazione input (visibile in Netron)
        self.quant_inp = qnn.QuantIdentity(
            act_quant=Int8ActPerTensorFixedPoint,
            return_quant_tensor=True  # <-- Importante per Netron
        )

        self.conv1 = qnn.QuantConv2d(
            in_channels=3,
            out_channels=8,
            kernel_size=3,
            padding=0,
            bias=False,
            weight_quant=Int8WeightPerTensorFixedPoint,
            act_quant=Int8ActPerTensorFixedPoint,
            return_quant_tensor=True  # <-- Aggiunto
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
            return_quant_tensor=True  # <-- Già presente
        )

    def forward(self, x):
        x = self.quant_inp(x)  # Input quantizzato (visibile in Netron)
        x = self.conv1(x)      # Conv con Q/DQ
        x = self.relu(x)       # ReLU con Q/DQ
        x = self.global_avg_pool(x)
        x = x.view(x.size(0), -1)
        x = self.fc(x)        # Linear con Q/DQ
        return x

def main():
    transform = transforms.Compose([transforms.ToTensor()])
    train_dataset = torchvision.datasets.CIFAR10(root='../data', train=True, download=True, transform=transform)
    train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = SimpleCNNQuant(num_classes=10).to(device)

    # Forward con un dummy input per inizializzare le scale
    dummy_input = torch.randn(1, 3, 32, 32, device=device)
    with torch.no_grad():
        model(dummy_input)
    import os

    # Percorso dove salvare
    save_dir = "./Quantization/Nets"
    save_path = os.path.join(save_dir, "simple_cnn_quant_cifar10_qcdq.onnx")
# Crea la directory se non esiste
    os.makedirs(save_dir, exist_ok=True)
    # Export ONNX con Q/DQ (Quantize/Dequantize)
    from brevitas.export import export_onnx_qcdq
    export_onnx_qcdq(
        model,
        dummy_input,
        save_path,
        input_names=["input"],  # Nome esplicito per l'input
        output_names=["output"] # Nome esplicito per l'output
    )
    print("Modello esportato con Q/DQ come 'simple_cnn_quant_cifar10_qcdq.onnx'")

if __name__ == "__main__":
    main()

     #faare inference con onnxruntime prendere i dati prima della quantizzaione della relu