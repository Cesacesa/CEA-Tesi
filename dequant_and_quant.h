#ifndef DEQUANT_AND_QUANT
#define DEQUANT_AND_QUANT

#include <hls_math.h>
#include <ap_int.h>
#ifndef __SYNTHESIS__
#include <fstream>
#endif

template<int BIT_INPUT, int BIT_QUANT, int SHIFT_FACTOR_TOT>
inline ap_uint<BIT_QUANT> deq_and_quant(ap_uint<BIT_INPUT> input) {
    ap_uint<BIT_QUANT> output;
#ifndef __SYNTHESIS__
    static std::ofstream debug_file("debugging_quant.txt", std::ios::app);
#endif

    // SCALING
    ap_uint<SHIFT_FACTOR_TOT> decimal_part = input.range(SHIFT_FACTOR_TOT - 1, 0);
    ap_uint<BIT_INPUT - SHIFT_FACTOR_TOT> temp = input.range(BIT_INPUT - 1, SHIFT_FACTOR_TOT);

#ifndef __SYNTHESIS__
    debug_file << "-----------------------------\n";
    debug_file << "Input: " << input << "\n";
    debug_file << "Decimal part: " << decimal_part << "\n";
    debug_file << "Integer part before rounding: " << temp << "\n";
#endif

    // ROUNDING (nearest even)
    if (decimal_part > (1 << (SHIFT_FACTOR_TOT - 1))) {
        temp++;
    } else if (decimal_part == (1 << (SHIFT_FACTOR_TOT - 1)) && temp[0] == 1) {
        temp++;
    }

#ifndef __SYNTHESIS__
    debug_file << "Temp (after rounding): " << temp << "\n";
#endif

    // SATURATION
    ap_uint<BIT_QUANT> max_value = ~0;
    if (temp > max_value) {
        output = max_value;
    } else {
        output = temp;
    }

#ifndef __SYNTHESIS__
    debug_file << "output: " << output << "\n";
    debug_file << "-----------------------------\n";
#endif

    return output;
}

#endif
