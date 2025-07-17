#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include "top_wrap.h"

#include "scaled_matrix.h"
#include "output_matrix_deq_and_quant.h"




int main() {
    ap_uint<BIT_QUANT> output[BATCH][CHANNELS][HEIGHT][WIDTH]={0};

   

    // Call your top-level quantization function
    top_wrap(relu_quantized, output);

    // Compare output with expected
    int mismatches = 0;
    for (int b = 0; b < BATCH; ++b) {
        for (int c = 0; c < CHANNELS; ++c) {
            for (int h = 0; h < HEIGHT; ++h) {
                for (int w = 0; w < WIDTH; ++w) {
                    ap_uint<BIT_QUANT> actual = output[b][c][h][w];
                    ap_uint<BIT_QUANT> expected_val = expected[b][c][h][w];
                    if (std::abs((actual) - (expected_val)) > TOLERANCE) {
                        std::cerr << "Mismatch at [" << b << "][" << c << "][" << h << "][" << w << "]: "
                                  << "expected " << (expected_val)
                                  << ", got " << (actual) << std::endl;
                        ++mismatches;
                    }
                }
            }
        }
    }

    if (mismatches == 0) {
        std::cout << "Tutti i valori coincidono!" << std::endl;
    } else {
        std::cout << "Numero totale di mismatch: " << mismatches << std::endl;
    }

    return 0;
}

