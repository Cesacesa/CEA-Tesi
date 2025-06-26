#include <iostream>
#include "top_wrapper.h"
#include "kernel.h"

#include <fstream>
#include <iostream>
#include "input.h"
#include <ap_int.h>
#include "parameter.h"
#include "input_ap_int.h"

template< int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int STRIDE>
void convoluzione_gold(const int input[], int output_conv[OH * OW * OCH]){
    int input_idx = 0;
    int kernel_idx = 0;
    int out_idx = 0;
    for (int out_h = 0; out_h < OH; out_h++) {
        for (int out_w = 0; out_w < OW; out_w++) {
            for (int out_c = 0; out_c < OCH; out_c++) {
            int sum = 0;
                for (int in_c = 0; in_c < ICH; in_c++) {
                    for (int filter_h = 0; filter_h < FH_IN; filter_h++) {
                        for (int filter_w = 0; filter_w < FW_IN; filter_w++) {
                            int in_h = out_h + filter_h;
                            int in_w = out_w * STRIDE + filter_w;
                            input_idx = in_c + (in_w * ICH) + (in_h * IW * ICH);
                            kernel_idx = ((out_c * FH_IN + filter_h) * FW_IN + filter_w) * ICH + in_c;
                            sum += input[input_idx] * kernel[kernel_idx];
                        }
                    }
                }
                output_conv[out_idx] = sum;
                out_idx++;
            }
        }
    }
}

template< int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int OUT_SIZE_IN,
    int STRIDE,    
    int ICH_PAR_OUT,
    int FW_OUT, int FH_OUT, int OCH_OUT,
    int WINDOW_OUT>
void out_conv2mem(memory_out_t* output_flat,
                  ap_int<45> memory[][CONV_2_OH][CONV_2_OW][CONV_2_OCH],
                  int NR_IMG,
                  int img)
{
    int idx = 0;
    int s_window_h = 0;
    int special_row_window = FW_OUT - ((OW / FW_OUT + 1) * FW_OUT - OW);
    int special_col_window = FH_OUT - ((OH / FH_OUT + 1) * FH_OUT - OH);
    for (int s_ih = 0; s_ih < WINDOW_OUT * FH_OUT; s_ih += FH_OUT) {
            int s_window_w = 0;
            for (int s_iw = 0; s_iw < WINDOW_OUT * FW_OUT; s_iw += FW_OUT) {
                for (int s_ich = 0; s_ich < OCH; s_ich += ICH_PAR_OUT) {
                    for (int s_ich_par = 0; s_ich_par < ICH_PAR_OUT; s_ich_par++) {
                        for (int s_fh = 0; s_fh < FH_OUT; s_fh++) {
                            for (int s_fw = 0; s_fw < FW_OUT; s_fw++) {
                            
                                int s_mem_i = (s_fw + s_fh * FW_OUT) + s_ich_par * FW_OUT * FH_OUT;
                                int s_mem_i_depth = s_window_h + s_window_w + s_ich / ICH_PAR_OUT;

                                // Leggi da output_flat
                                int val = output_flat[idx++];
                                int in_h = s_ih + s_fh;
                                int in_w = s_iw + s_fw;
                                int in_c = s_ich + s_ich_par;

                                if (in_h < IH && in_w < IW && in_c < ICH) {
                                    memory[img][in_h][in_w][in_c] = val;
                                }
                            }
                        }
                        s_window_w += OCH / ICH_PAR_OUT;
                       
                    }         
            } 
            if (s_iw >= OW - FW_OUT) {
                if (special_row_window != 0) {
                    special_row_window--;
                    if (special_row_window == 0) {
                        special_row_window = FW_OUT - ((OW / FW_OUT + 1) * FW_OUT - OW);
                        s_iw += FW_OUT;
                    }       
                }
            }
            s_window_h += OCH / ICH_PAR_OUT * WINDOW_OUT; 
        } 
        if (s_ih >= OH - FH_OUT) {
            if (special_col_window != 0) {
                special_col_window--;
                if (special_col_window == 0) {
                    special_col_window = FH_OUT - ((OH / FH_OUT + 1) * FH_OUT - OH);
                    s_ih += FH_OUT;
                }
            }
        }          
    }
    
}



int main(){
    constexpr int NR_IMG = 5; //define number of images

    memory_out_t memory_out_local[CONV_2_OUTPUT_SIZE * NR_IMG] = {0}; // Local memory for output

    top_wrapper(input_ap_int, NR_IMG, kernel, kernel, memory_out_local); // Call the top wrapper function
    
    ap_int<45> output[NR_IMG][CONV_2_OH][CONV_2_OW][CONV_2_OCH] = {0}; // Output memory to store the golden results

    for (int img = 0; img < NR_IMG; img++) {
        std::cout << "img: " << img << std::endl;
        out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_OUTPUT_SIZE, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(memory_out_local, output, NR_IMG, img);
    }
    std::cout << "memory hw: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {    
        for (int k = 0; k < CONV_1_OCH; k++) {
            for (int i = 0; i < CONV_1_OH; i++) {
                for (int j = 0; j < CONV_1_OW; j++) {
                    std::cout << output[img][i][j][k] << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
        std::cout << std::endl;
    }

    int output_conv[CONV_0_OH * CONV_0_OW * CONV_0_OCH] = {0};
    convoluzione_gold< CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE>(input, output_conv);
    
    int output_conv_2[CONV_1_OH * CONV_1_OW * CONV_1_OCH] = {0};
    convoluzione_gold<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE>(output_conv, output_conv_2);
    
    int golden_out[NR_IMG][CONV_1_OH][CONV_1_OW][CONV_1_OCH] = {0};
    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_1_OH; i++) {
            for (int j = 0; j < CONV_1_OW; j++) {
                for (int k = 0; k < CONV_1_OCH; k++) {
                    golden_out[img][i][j][k] = output_conv_2[i * CONV_1_OW * CONV_1_OCH + j * CONV_1_OCH + k];
                }
            }
        }
    }
    std::cout << "golden_out_tb: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {
        for (int k = 0; k < CONV_1_OCH; k++) {
            for (int i = 0; i < CONV_1_OH; i++) {
                for (int j = 0; j < CONV_1_OW; j++) {
                    std::cout << golden_out[img][i][j][k] << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
        std::cout << std::endl;
    }
    for (int img = 0; img < NR_IMG; img++) {
        for (int k = 0; k < CONV_1_OCH; k++) {
            for (int i = 0; i < CONV_1_OH; i++) {
                for (int j = 0; j < CONV_1_OW; j++) {
                    if (output[img][i][j][k] != golden_out[img][i][j][k]) {
                        std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << output[img][i][j][k] << " != " << golden_out[img][i][j][k] << std::endl;
                        return 1;
                    }
                }
            }
        }
    }
    return 0;
}

