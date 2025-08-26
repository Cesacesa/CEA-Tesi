#ifndef OPERATION_MATRIX
#define OPERATION_MATRIX

#include <ap_int.h>
#include "dequant_and_quant.h"
#ifndef __SYNTHESIS__
#include <fstream>
#endif

template<int HEIGHT, int WIDTH, int BIT_INPUT, int BIT_QUANT, int SHIFT_FACTOR_TOT>
inline void matrix_wrapper(ap_uint<BIT_INPUT> input[HEIGHT][WIDTH],
                           ap_uint<BIT_QUANT> output[HEIGHT][WIDTH]) {
#ifndef __SYNTHESIS__
    static std::ofstream debug_file("matrix_check.txt", std::ios::app);
#endif

    Height_loop: for (int h = 0; h < HEIGHT; h++) {
        Width_loop: for (int w = 0; w < WIDTH; w++) {
#pragma HLS PIPELINE II=1
            output[h][w] = deq_and_quant<BIT_INPUT, BIT_QUANT, SHIFT_FACTOR_TOT>(input[h][w]);

#ifndef __SYNTHESIS__
            debug_file << "INPUT:  " << input[h][w] << "\n";
            debug_file << "h:  " << h << "\n";
            debug_file << "w:  " << w << "\n";
            debug_file << "OUTPUT: " << output[h][w] << "\n";
            debug_file << "-----------------------------\n";
#endif
        }
    }
}

#endif
