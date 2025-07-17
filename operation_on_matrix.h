#ifndef OPERATOIN_MATRIX
#define OPERATOIN_MATRIX
#include "parameters_dq.h"
#include "dequant_and_quant.h"
 
inline void matrix_wrapper(ap_uint<BIT_INPUT> input[HEIGHT][WIDTH],ap_uint<BIT_QUANT> output[HEIGHT][WIDTH]){
    #ifndef __SYNTHESIS__
    static std::ofstream debug_file("matrix_check.txt", std::ios::app); // apertura in append
#endif
 
   
   
            Height_loop: for (int h = 0; h < HEIGHT; h++) {
                Width_loop: for (int w = 0; w < WIDTH; w++) {
                    #pragma HLS PIPELINE II=1
 
                    output[h][w]= deq_and_quant(input[h][w]);
                    #ifndef __SYNTHESIS__
                        debug_file << "INPUT:  " << input[h][w] << "\n";
                        debug_file << "h:  " << h << "\n";
                        debug_file << "w:  " << w << "\n";
                        debug_file << "OUTPUT: " << output[h][w] << "\n";
                        debug_file <<"-----------------------------\n";
                    #endif
                }
            }
        }
 
 
#endif