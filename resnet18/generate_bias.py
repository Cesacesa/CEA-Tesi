import argparse
import numpy as np

def to_c_array(name, arr, values_per_line=12, c_type="int32_t"):
    """Converte un array numpy in una stringa formattata C."""
    flat = arr.flatten()
    lines = []
    for i in range(0, len(flat), values_per_line):
        chunk = ", ".join(str(int(v)) for v in flat[i:i+values_per_line])
        lines.append("    " + chunk)
    return f"static {c_type} {name}[{len(flat)}] = {{\n" + ",\n".join(lines) + "\n};\n"

def process_biases(data, scaling_factor=1.0):
    """Processa i bias dividendo per il fattore di scaling e castando a int32."""
    return (data / scaling_factor).round().astype(np.int32)

def main():
    parser = argparse.ArgumentParser(description="Converti bias .npy in .h")
    parser.add_argument("--file", required=True, help="Path al file .npy")
    parser.add_argument("--scale", type=float, required=True, help="Scaling factor da applicare")
    parser.add_argument("--name", default="bias_values", help="Nome variabile C")
    parser.add_argument("--out", default="bias_values.h", help="Nome file .h di output")
    parser.add_argument("--values_per_line", type=int, default=12, help="Quanti valori per riga nel .h")
    args = parser.parse_args()

    # Carica i bias
    data = np.load(args.file)

    # Controllo che sia 1D
    if data.ndim != 1:
        raise ValueError(f"Bias devono essere un array 1D, shape trovato={data.shape}")

    # Processa i bias
    processed = process_biases(data, scaling_factor=args.scale)

    # Genera codice C
    c_code = to_c_array(args.name, processed, values_per_line=args.values_per_line, c_type="int32_t")

    # Salva
    with open(args.out, "w") as f:
        f.write(c_code)

    print(f"✅ Generato {args.out} con {len(data)} bias, shape originale={data.shape}")

if __name__ == "__main__":
    main()
