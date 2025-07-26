import onnx
import numpy as np
import argparse
import os
from qonnx.core.onnx_exec import execute_onnx_and_make_model
from qonnx.core.onnx_exec import execute_onnx
from qonnx.transformation import infer_shapes
from qonnx.core.datatype import DataType
from qonnx.transformation.infer_datatypes import InferDataTypes
from qonnx.util.cleanup import cleanup_model
from qonnx.core.modelwrapper import ModelWrapper
 
def extract_intermediate_tensors(model_path, input_tensor, intermediate_names, save_dir=None):
    # Load the ONNX/QONNX model
    model = onnx.load(model_path)
    input_name = model.graph.input[0].name
    print(f"Input name: {input_name}, shape: {input_tensor.shape}")
    inferred_model = ModelWrapper(model)
    cleanup_model(inferred_model)
    inferred_model = inferred_model.transform(infer_shapes.InferShapes())
    inferred_model, _ = InferDataTypes().apply(inferred_model)
    #export model with shapes to onnx
    mode_path = model_path + "_shaped.onnx"
    inferred_model.save(mode_path)
    # Run simulation using FINN's interpreter
    model = ModelWrapper(mode_path)
    print(f"Input name: {input_name}")
    print(f"Model expected shape: {[dim.dim_value for dim in model.graph.input[0].type.tensor_type.shape.dim]}")
    print(f"Input dtype: {input_tensor.dtype}")
    # output_dict = execute_onnx_and_make_model(model, {input_name: input_tensor})
    output_dict = execute_onnx(model, {input_name: input_tensor},True)
    # Filter only requested intermediate tensors
    extracted = {}
    if save_dir:
        os.makedirs(save_dir, exist_ok=True)
 
    for name in intermediate_names:
        val = output_dict.get(name, None)
        if val is None:
            print(f"[✗] Tensor '{name}' not found or is None")
        else:
            extracted[name] = val
            print(f"[✓] Found: {name}, shape: {val.shape}")
            if save_dir:
                file_name = "out_" + name.replace("/", "_").replace(":", "_")
                file_path = os.path.join(save_dir, f"{file_name}.npy")
                print(f"Saving {name} to {file_path}")
                np.save(file_path, val)
                print(f"Value: {val }")
    # extracted = {}
    # for name in intermediate_names:
    #     if name in output_dict:
    #         extracted[name] = output_dict[name]
    #         print(f"[✓] Found: {name}, shape: {output_dict[name].shape}")
    #         if save_dir:
    #             os.makedirs(save_dir, exist_ok=True)
    #             print(f"Saving {name} to {save_dir}")
    #             if not os.path.exists(save_dir):
    #                 os.makedirs(save_dir)
    #             np.save(os.path.join(save_dir, f"{name}.npy"), output_dict[name])
    #     else:
    #         print(f"[✗] Not found: {name}")
 
    return extracted
 
 
def parse_args():
    parser = argparse.ArgumentParser(description="Extract intermediate tensors from QONNX model")
    parser.add_argument("--model", help="Path to QONNX model (.onnx)", default="resnet8.onnx")
    parser.add_argument("--input_shape", help="Input shape, e.g., 1,3,32,32", default="1,3,32,32")
    parser.add_argument("--intermediates", help="Comma-separated list of intermediate tensor names")
    parser.add_argument("--save_dir", help="Directory to save extracted tensors as .npy", default="./outputs")
    return parser.parse_args()
 
 
def main():
    args = parse_args()
 
    # Parse input shape
    input_shape = tuple(map(int, args.input_shape.split(",")))
 
    dummy_input = np.random.rand(*input_shape).astype(np.float32)
    #dummy_input = np.arange(np.prod(input_shape), dtype=np.float32).reshape(input_shape)
    # Print dummy input and its shape
    print(f"Dummy input value:\n{dummy_input}")
    # Parse intermediate tensor names
    intermediates = [s.strip() for s in args.intermediates.split(",")]
 
    # Run extraction
    extract_intermediate_tensors(args.model, dummy_input, intermediates, args.save_dir)
 
 
if __name__ == "__main__":
    main()