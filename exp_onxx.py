import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
from torch.utils.data import DataLoader

import brevitas.nn as qnn
from brevitas.quant import Int8WeightPerTensorFixedPoint, Int8ActPerTensorFixedPoint, Int32Bias
from brevitas.core.scaling import ScalingImplType

class SimpleCNNQuant(nn.Module):
    def __init__(self, num_classes=10):
        super(SimpleCNNQuant, self).__init__()

        self.conv1 = qnn.QuantConv2d(
            in_channels=3,
            out_channels=8,
            kernel_size=3,
            padding=0,
            bias = False,
            weight_quant=Int8WeightPerTensorFixedPoint,
            act_quant=Int8ActPerTensorFixedPoint
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
        x = self.conv1(x)
        x = self.relu(x)
        x = self.global_avg_pool(x)
        x = x.view(x.size(0), -1)
        x = self.fc(x)
        return x

def main():
    # Trasformazioni
    transform = transforms.Compose([transforms.ToTensor()])

    # Dataset CIFAR-10
    train_dataset = torchvision.datasets.CIFAR10(root='./data', train=True, download=True, transform=transform)
    test_dataset = torchvision.datasets.CIFAR10(root='./data', train=False, download=True, transform=transform)

    train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)
    test_loader = DataLoader(test_dataset, batch_size=64, shuffle=False)

    # Dispositivo
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = SimpleCNNQuant(num_classes=10).to(device)

    # Dummy forward per costruzione cache quantizzata
    dummy_input = torch.randn(1, 3, 32, 32, device=device)
    with torch.no_grad():
        model(dummy_input)

    # Loss e ottimizzatore
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)

    # Addestramento
    num_epochs = 0
    for epoch in range(num_epochs):
        model.train()
        running_loss = 0.0
        for images, labels in train_loader:
            images, labels = images.to(device), labels.to(device)
            optimizer.zero_grad()
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()
            running_loss += loss.item()
        print(f"Epoch {epoch+1}/{num_epochs}, Loss: {running_loss/len(train_loader):.4f}")

    # Valutazione
    model.eval()
    correct = 0
    total = 0
    with torch.no_grad():
        for images, labels in test_loader:
            images, labels = images.to(device), labels.to(device)
            outputs = model(images)
            _, predicted = torch.max(outputs, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print(f"Accuracy sul test set: {100 * correct / total:.2f}%")

    # Salvataggio modello
    torch.save(model.state_dict(), "simple_cnn_quant_cifar10.pth")
    print("Modello quantizzato salvato come simple_cnn_quant_cifar10.pth")

    from brevitas.export import export_onnx_qcdq
    export_onnx_qcdq(model, dummy_input, "simple_cnn_quant_cifar10.onnx")
    print("Modello esportato in formato ONNX come simple_cnn_quant_cifar10.onnx")

if __name__ == "__main__":
    main()