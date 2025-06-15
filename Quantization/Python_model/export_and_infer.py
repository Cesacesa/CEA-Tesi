import torch
import torch.nn as nn
import brevitas.nn as qnn
from brevitas.quant import Int8WeightPerTensorFixedPoint, Int8ActPerTensorFixedPoint, Int32Bias
from torchvision import datasets, transforms

class SimpleCNNConstInput(nn.Module):
    def __init__(self, image_tensor):
        super().__init__()
        # Registra l'input come buffer costante
        self.register_buffer('image_tensor', image_tensor)

        self.quant_inp = qnn.QuantIdentity(
            act_quant=Int8ActPerTensorFixedPoint,
            bit_width=8,
            return_quant_tensor=False)  # Modificato per compatibilità

        self.conv1 = qnn.QuantConv2d(
            in_channels=3, out_channels=8, kernel_size=3,
            padding=0, bias=False,
            weight_quant=Int8WeightPerTensorFixedPoint,
            weight_bit_width=8,
            act_quant=Int8ActPerTensorFixedPoint,
            act_bit_width=8,
            return_quant_tensor=False)

        self.relu = qnn.QuantReLU(
            act_quant=Int8ActPerTensorFixedPoint,
            bit_width=8,
            return_quant_tensor=False)

        self.global_avg_pool = nn.AdaptiveAvgPool2d((1, 1))

        self.fc = qnn.QuantLinear(
            in_features=8, out_features=10,
            weight_quant=Int8WeightPerTensorFixedPoint,
            weight_bit_width=8,
            act_quant=Int8ActPerTensorFixedPoint,
            act_bit_width=8,
            bias=None,
            bias_quant=Int32Bias,
            return_quant_tensor=False)

    def forward(self):
        # Calcola tutti i passaggi mantenendo i valori intermedi
        x0 = self.image_tensor
        x1 = self.quant_inp(x0)
        x2 = self.conv1(x1)
        x3 = self.relu(x2)
        x4 = self.global_avg_pool(x3)
        x5 = x4.view(x4.size(0), -1)
        x6 = self.fc(x5)
        
        # Ritorna tutti i valori intermedi per Netron
        return {
            'input': x0,
            'quant_inp': x1,
            'conv1': x2,
            'relu': x3,
            'avgpool': x4,
            'flatten': x5,
            'output': x6
        }

def export_static_model():
    transform = transforms.Compose([transforms.ToTensor()])
    cifar10 = datasets.CIFAR10(root='./data', train=False, download=True, transform=transform)
    image, _ = cifar10[0]
    image_tensor = image.unsqueeze(0)

    model = SimpleCNNConstInput(image_tensor)
    model.eval()

    # Esportazione standard ONNX che Netron può visualizzare
    torch.onnx.export(
        model,
        args=(),  # Nessun input dinamico
        f="./Quantization/Nets/cnn_const_input_static.onnx",
        input_names=[],
        output_names=['input', 'quant_inp', 'conv1', 'relu', 'avgpool', 'flatten', 'output'],
        opset_version=15,
        do_constant_folding=True,
        verbose=True
    )
    print("✅ Modello esportato con successo. Puoi aprirlo con Netron per vedere tutti i valori intermedi.")

if __name__ == "__main__":
    export_static_model()



    