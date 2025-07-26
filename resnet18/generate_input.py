import argparse
import numpy as np

def nchw_to_nhwc(data):
    """Converte NCHW → NHWC"""
    return np.transpose(data, (0, 2, 3, 1))  # N,H,W,C

def to_c_array(name, arr, values_per_line=12, c_type="ap_uint<8>"):
    """Converte un array numpy in una stringa formattata C."""
    flat = arr.flatten()
    lines = []
    for i in range(0, len(flat), values_per_line):
        chunk = ", ".join(str(int(v)) for v in flat[i:i+values_per_line])
        lines.append("    " + chunk)
    return f"static {c_type} {name}[{len(flat)}] = {{\n" + ",\n".join(lines) + "\n};\n"

def process_input_output(data, scaling_factor=1.0):
    """Processa input/output: NCHW → NHWC e scala"""
    if data.ndim == 4:  # N,C,H,W
        data = nchw_to_nhwc(data)[0]  # prendo solo batch 0
    elif data.ndim == 3:  # C,H,W
        data = np.transpose(data, (1, 2, 0))  # → HWC
    else:
        raise ValueError(f"Shape {data.shape} non gestita per input/output")

    # Scala e cast → uint8
    return (data / scaling_factor).round().astype(np.uint8)

def process_weights(data, scaling_factor=1.0):
    """Processa filtri Conv: OIHW → per-pixel-per-canale"""
    if data.ndim != 4:
        raise ValueError(f"Expected 4D weights (O,I,H,W), got {data.shape}")

    # Scala (pesano anche negativi? → int8, altrimenti uint8)
    data_scaled = (data / scaling_factor).round().astype(np.int8)

    # Riordino: O,I,H,W → O,H,W,I
    data_hwio = np.transpose(data_scaled, (0, 2, 3, 1))

    # Flatten per output filter
    return data_hwio.reshape(-1)

def main():
    parser = argparse.ArgumentParser(description="Converti .npy in .h")
    parser.add_argument("--file", required=True, help="Path al file .npy")
    parser.add_argument("--type", choices=["input", "output", "weights"], required=True, help="Tipo di dato da convertire")
    parser.add_argument("--scale", type=float, required=True, help="Scaling factor da applicare")
    parser.add_argument("--name", default="tensor_values", help="Nome variabile C")
    parser.add_argument("--out", default="tensor_values.h", help="Nome file .h di output")
    parser.add_argument("--values_per_line", type=int, default=12, help="Quanti valori per riga nel .h")
    args = parser.parse_args()

    # Carica il tensore
    data = np.load(args.file)

    # Processa in base al tipo
    if args.type in ["input", "output"]:
        processed = process_input_output(data, scaling_factor=args.scale)
        c_type = "ap_uint<8>"
    elif args.type == "weights":
        processed = process_weights(data, scaling_factor=args.scale)
        c_type = "ap_int<8>"  # filtri possono essere negativi
    else:
        raise ValueError("Tipo non supportato")

    # Genera codice C
    c_code = to_c_array(args.name, processed, values_per_line=args.values_per_line, c_type=c_type)

    # Salva
    with open(args.out, "w") as f:
        f.write(c_code)

    print(f"✅ Generato {args.out} per tipo {args.type}, shape originale={data.shape}")

if __name__ == "__main__":
    main()
