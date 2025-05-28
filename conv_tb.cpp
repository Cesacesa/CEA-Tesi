#include <iostream>
#include "top_wrapper.h"
#include "kernel.h"

#include <fstream>
#include <iostream>
#include "input.h"
#include <ap_int.h>
#include "parameter.h"

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
    int WINDOW_IN,
    int NR_IMG>
void input2conv(ap_int<45> memory[NR_IMG][FW_IN * FH_IN * ICH_PAR_IN][(ICH * (WINDOW_IN * FW_IN) * (WINDOW_IN * FH_IN)) / (FW_IN * FH_IN * ICH_PAR_IN)]){
    int s_window_h = 0; 
    int in_idx = 0;
    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int special_row_window = 0;
    int special_col_window = 0;
    special_row_window = FW_IN - ((IW / FW_IN +1) * FW_IN - IW);
    special_col_window = FH_IN - ((IH / FH_IN +1) * FH_IN - IH);
    for (int img = 0; img < NR_IMG; img++) {
        in_idx = 0;
        s_mem_i = 0;
        s_window_h = 0;
        s_mem_i_depth = 0;
        for (int s_ih = 0; s_ih < WINDOW_IN * FW_IN; s_ih += FH_IN) {
            for (int s_fh = 0; s_fh < FH_IN; s_fh++) {
            int s_window_w = 0;  
                for (int s_iw = 0; s_iw < WINDOW_IN * FW_IN; s_iw += FW_IN) {
                    for (int s_fw = 0; s_fw < FW_IN; s_fw++) {
                        for (int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR_IN) {
                            for (int s_ich_par = 0; s_ich_par < ICH_PAR_IN; s_ich_par++) {
                            s_mem_i = (s_fw + s_fh * FW_IN) + s_ich_par * FW_IN * FH_IN; 
                            s_mem_i_depth = s_window_h + s_window_w + s_ich / ICH_PAR_IN;
                            memory[img][s_mem_i][s_mem_i_depth] = input[in_idx]; //SENZA ICH_PAR
                            in_idx++; 
                            }
                        }
                        if (s_iw >= IW - FW_IN) { // last filter window
                            if (special_row_window != 0) { //if IW % FW != 0
                                special_row_window--; // decrement the special row window in case there are more than one
                                if (special_row_window == 0){ // if the special row window is 0, we need to pass to the next row window
                                    special_row_window = FW_IN - ((IW / FW_IN +1) * FW_IN - IW); // reset the special row window
                                    s_fw += (FW_IN); 
                                }
                            }
                        }    
                    }
                    s_window_w += ICH/ICH_PAR_IN;
                }
                if (s_ih >= IH - FH_IN) { // last filter window
                    if (special_col_window != 0) { //if IH % FH != 0
                        special_col_window--;  // decrement the special col window in case there are more than one
                        if (special_col_window == 0){ // if the special col window is 0, we need to pass to the next row window
                            special_col_window = FH_IN - ((IH / FH_IN +1) * FH_IN - IH); // reset the special col window
                            s_fh += FH_IN; 
                        }
                    }
                }
            }
            s_window_h+= ICH/ICH_PAR_IN * (WINDOW_IN);
        }
    }
}


int main(){

    ap_int<45> memory_in[NR_IMG][CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR][(CONV_0_ICH * (WINDOW_IN * CONV_0_FW) * (WINDOW_IN * CONV_0_FH)) / (CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR)] = {0};
    input2conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN, NR_IMG>(memory_in);

    memory_in_t memory_in_local[NR_IMG] = {0};
    memory_out_t memory_out_local[NR_IMG] = {0};

    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR; i++) {
            for (int j = 0; j < (CONV_0_ICH * (WINDOW_IN * CONV_0_FW) * (WINDOW_IN * CONV_0_FH)) / (CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR); j++) {
                memory_in_local[img][i][j] = memory_in[img][i][j];
            }
        }
    }

    top_wrapper(memory_in_local, kernel, memory_out_local);

    int output_conv[CONV_0_OH * CONV_0_OW * CONV_0_OCH] = {0};
    convoluzione_gold< CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE>(input, output_conv);
    
    // int output_conv_2[CONV_1_OH * CONV_1_OW * CONV_1_OCH] = {0};
    // convoluzione_gold<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE>(output_conv, output_conv_2);
    
    // int golden_out[NR_IMG][CONV_1_OH][CONV_1_OW][CONV_1_OCH] = {0}; //use if there is 2 conv and modify the parameter below
    int golden_out[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0}; //use if there is 1 conv
    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_OH; i++) {
            for (int j = 0; j < CONV_0_OW; j++) {
                for (int k = 0; k < CONV_0_OCH; k++) {
                    golden_out[img][i][j][k] = output_conv[i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
                }
            }
        }
    }
    std::cout << "golden_out_tb: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {
        for (int k = 0; k < CONV_0_OCH; k++) {
            for (int i = 0; i < CONV_0_OH; i++) {
                for (int j = 0; j < CONV_0_OW; j++) {
                    std::cout << golden_out[img][i][j][k] << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
        std::cout << std::endl;
    }
    for (int img = 0; img < NR_IMG; img++) {
        for (int k = 0; k < CONV_0_OCH; k++) {
            for (int i = 0; i < CONV_0_OH; i++) {
                for (int j = 0; j < CONV_0_OW; j++) {
                    if (memory_out_local[img][i][j][k] != golden_out[img][i][j][k]) {
                        std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << memory_out_local[img][i][j][k] << " != " << golden_out[img][i][j][k] << std::endl;
                        return 1;
                    }
                }
            }
        }
    }
    return 0;
}

