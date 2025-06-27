import onnx
import onnx.numpy_helper as numpy_helper

def extract_quant_params_from_onnx(onnx_model_path):
    model = onnx.load(onnx_model_path)
    initializers = {init.name: init for init in model.graph.initializer}

    quant_params = {}

    for node in model.graph.node:
        if node.op_type in ['QuantizeLinear', 'DequantizeLinear']:
            input_name = node.input[0]
            scale_name = node.input[1]
            zero_point_name = node.input[2] if len(node.input) > 2 else None
            
            scale_tensor = initializers.get(scale_name, None)
            zero_point_tensor = initializers.get(zero_point_name, None) if zero_point_name else None
            
            scale = numpy_helper.to_array(scale_tensor) if scale_tensor else None
            zero_point = numpy_helper.to_array(zero_point_tensor) if zero_point_tensor else None
            
            quant_params[node.name or input_name] = {
                'scale': scale,
                'zero_point': zero_point
            }

    return quant_params

# Uso
onnx_path = "./Quantization/Nets/simple_cnn_quant_cifar10_qcdq_fixed.onnx"
params = extract_quant_params_from_onnx(onnx_path)

for node, p in params.items():
    print(f"Node: {node}")
    print(f"  scale: {p['scale']}")
    print(f"  zero_point: {p['zero_point']}")
    print()
