#include <iostream>
#include "top_wrapper.h"
#include <fstream>
#include <iostream>

#include <ap_int.h>
#include "parameter.h"

#include "input_lenet.h"
#include "kernel_lenet.h"
#include "output_lenet.h"

#include "output_matrix_deq_and_quant.h"


template< int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int STRIDE>
void convoluzione_gold(const memory_in_t input_values[], memory_out_t output_conv[OH * OW * OCH]){
    int input_idx = 0;
    int kernel_idx = 0;
    int out_idx = 0;
    for (int out_h = 0; out_h < OH; out_h++) {
        for (int out_w = 0; out_w < OW; out_w++) {
            for (int out_c = 0; out_c < OCH; out_c++) {
            memory_out_t sum = 0;
                for (int in_c = 0; in_c < ICH; in_c++) {
                    for (int filter_h = 0; filter_h < FH_IN; filter_h++) {
                        for (int filter_w = 0; filter_w < FW_IN; filter_w++) {
                            int in_h = out_h + filter_h;
                            int in_w = out_w * STRIDE + filter_w;
                            input_idx = in_c + (in_w * ICH) + (in_h * IW * ICH);
                            kernel_idx = ((out_c * FH_IN + filter_h) * FW_IN + filter_w) * ICH + in_c;
                            sum += input_values[input_idx] * weights[kernel_idx];
                        }
                    }
                }
                // ReLU activation
                if (sum < 0) {
                    sum = 0;
                }
                output_conv[out_idx] = sum;
                out_idx++;
            }
        }
    }
}

// template< int ICH, int IW, int IH,
//     int FW_IN, int FH_IN,
//     int OCH, int OW, int OH, 
//     int ICH_PAR_IN,
//     int STRIDE,    
//     int ICH_PAR_OUT,
//     int FW_OUT, int FH_OUT, int OCH_OUT,
//     int WINDOW_OUT>
// void out_conv2mem(memory_out_t* output_flat,
//                   memory_out_t memory[][CONV_1_OH][CONV_1_OW][CONV_1_OCH],
//                   int NR_IMG,
//                   int img)
// {
//     int idx = 0;
//     int s_window_h = 0;
//     int special_row_window = FW_OUT - ((OW / FW_OUT + 1) * FW_OUT - OW);
//     int special_col_window = FH_OUT - ((OH / FH_OUT + 1) * FH_OUT - OH);
//     for (int s_ih = 0; s_ih < WINDOW_OUT * FH_OUT; s_ih += FH_OUT) {
//             int s_window_w = 0;
//             for (int s_iw = 0; s_iw < WINDOW_OUT * FW_OUT; s_iw += FW_OUT) {
//                 for (int s_ich = 0; s_ich < OCH; s_ich += ICH_PAR_OUT) {
//                     for (int s_ich_par = 0; s_ich_par < ICH_PAR_OUT; s_ich_par++) {
//                         for (int s_fh = 0; s_fh < FH_OUT; s_fh++) {
//                             for (int s_fw = 0; s_fw < FW_OUT; s_fw++) {
//                                 int s_mem_i = (s_fw + s_fh * FW_OUT) + s_ich_par * FW_OUT * FH_OUT;
//                                 int s_mem_i_depth = s_window_h + s_window_w + s_ich / ICH_PAR_OUT;
//                                 int val = output_flat[idx++];
//                                 int in_h = s_ih + s_fh;
//                                 int in_w = s_iw + s_fw;
//                                 int in_c = s_ich + s_ich_par;
//                                 if (in_h < IH && in_w < IW && in_c < ICH) {
//                                     memory[img][in_h][in_w][in_c] = val;
//                                 }
//                             }                   
//                         }
//                         s_window_w += OCH / ICH_PAR_OUT;
//                     }         
//                 } 
//             if (s_iw >= OW - FW_OUT) {
//                 if (special_row_window != 0) {
//                     special_row_window--;
//                     if (special_row_window == 0) {
//                         special_row_window = FW_OUT - ((OW / FW_OUT + 1) * FW_OUT - OW);
//                         s_iw += FW_OUT;
//                     }       
//                 }
//             }
//             s_window_h += OCH / ICH_PAR_OUT * WINDOW_OUT; 
//         } 
//         if (s_ih >= OH - FH_OUT) {
//             if (special_col_window != 0) {
//                 special_col_window--;
//                 if (special_col_window == 0) {
//                     special_col_window = FH_OUT - ((OH / FH_OUT + 1) * FH_OUT - OH);
//                     s_ih += FH_OUT;
//                 }
//             }
//         }          
//     }
    
// }

void simple_out_conv2mem(memory_out_t* output_flat,
                         memory_out_t output[1][CONV_0_OH][CONV_0_OW][CONV_0_OCH]) {
    int idx = 0;
    for (int i = 0; i < CONV_0_OH; i++) {
        for (int j = 0; j < CONV_0_OW; j++) {
            for (int k = 0; k < CONV_0_OCH; k++) {
                output[0][i][j][k] = output_flat[idx++];
            }
        }
    }
}


int main(){
    constexpr int NR_IMG = 1; // Number of images to process
    // Variables for input and output to pass to the top_wrapper
    hls::stream<mem_in_t> memory_in_stream("input_stream");
    filter_stream_t filter_val_stream("filter1_stream");
    // filter_stream_t filter_val_2_stream("filter2_stream");
    hls::stream<mem_out_t> memory_out_stream("output_stream");


    // memory_out_t memory_out_local[CONV_2_OUTPUT_SIZE * NR_IMG] = {0}; // Local memory to store the output from the hardware
    // ap_int<45> output[NR_IMG][CONV_2_OH][CONV_2_OW][CONV_2_OCH] = {0}; // Partitioned memory to store the output from the hardware and do comparison with the golden output


    memory_out_t memory_out_local[CONV_1_OUTPUT_SIZE * NR_IMG] = {0}; // Local memory to store the output from the hardware
    memory_out_t output[NR_IMG][CONV_1_OH][CONV_1_OW][CONV_1_OCH] = {0}; // Partitioned memory to store the output from the hardware and do comparison with the golden output


    // Insert the input data into the memory_in_stream
    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_INPUT_SIZE; i++) {
            memory_in_stream.write(input_values[img * CONV_0_INPUT_SIZE + i]); 
        }
        // Insert the data in filter_val_stream fot the kernel 1
        for (int i = 0; i < KERNEL_SIZE_0; i++) {
            filter_val_stream.write( (ap_int<8>)weights[i] );
        }

        // Insert the data in filter_val_2_stream for the kernel 2
        // for (int i = 0; i < KERNEL_SIZE_1; i++) {
        //     filter_val_2_stream.write( (ap_int<8>)kernel[i] );
        // } 
            top_wrapper(memory_in_stream, filter_val_stream, memory_out_stream); //call the top_wrapper function to process the input data and generate the output

    }

    int out_idx = 0;
    for (int img = 0; img < NR_IMG; img++) {
        while (true) { //until flag TLAST is set
            mem_out_t pkt = memory_out_stream.read(); // read packet from output stream
            memory_out_local[out_idx++] = pkt.data; // store the data in the local memory
            if (pkt.last) break; // if TLAST is set, break the loop
        }
        std::cout << "\nTotale output letti: " << out_idx << std::endl;
    }
    // Convert the output from the local memory to the output array for the comparison with the golden output
    for (int img = 0; img < NR_IMG; img++) {
        // out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(&memory_out_local[img * CONV_2_OUTPUT_SIZE], output, NR_IMG, img);
        //out_conv2mem<CONV_0_ICH, CONV_0_OW, CONV_0_OH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_1_OW, CONV_1_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(&memory_out_local[img * CONV_1_OUTPUT_SIZE], output, NR_IMG, img);
        simple_out_conv2mem(&memory_out_local[img * CONV_1_OUTPUT_SIZE], output);
    }

    std::cout << "memory hw: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {   
        std::cout << "Image " << img << ":" << std::endl; 
        for (int k = 0; k < CONV_0_OCH; k++) {
            for (int i = 0; i < CONV_0_OH; i++) {
                for (int j = 0; j < CONV_0_OW; j++) {
                    std::cout << output[img][i][j][k] << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
        std::cout << std::endl;
    }

    memory_out_t output_conv[NR_IMG][CONV_0_OH * CONV_0_OW * CONV_0_OCH] = {0};
    for (int img = 0; img < NR_IMG; img++) {
        convoluzione_gold< CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE>(&input_values[img * CONV_0_INPUT_SIZE], output_conv[img]);
    }

    // int golden_out_tb[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0};
    // for (int img = 0; img < NR_IMG; img++) {
    //     for (int i = 0; i < CONV_0_OH; i++) {
    //         for (int j = 0; j < CONV_0_OW; j++) {
    //             for (int k = 0; k < CONV_0_OCH; k++) {
    //                 golden_out_tb[img][i][j][k] = output_conv[img][i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
    //             }
    //         }
    //     }
    // }
    // std::cout << "golden_out_tb: " << std::endl;
    // for (int img = 0; img < NR_IMG; img++) {
    //     std::cout << "Image " << img << ":" << std::endl;
    //     for (int k = 0; k < CONV_0_OCH; k++) {
    //         for (int i = 0; i < CONV_0_OH; i++) {
    //             for (int j = 0; j < CONV_0_OW; j++) {
    //                 std::cout << golden_out_tb[img][i][j][k] << " ";
    //             }
    //             std::cout << std::endl;
    //         }
    //         std::cout << std::endl;
    //     }
    //     std::cout << std::endl;
    // }

    // for (int img = 0; img < NR_IMG; img++) {
    //     for (int k = 0; k < CONV_0_OCH; k++) {
    //         for (int i = 0; i < CONV_0_OH; i++) {
    //             for (int j = 0; j < CONV_0_OW; j++) {
    //                 if (output[img][i][j][k] != golden_out_tb[img][i][j][k]) {
    //                     std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << output[img][i][j][k] << " != " << golden_out_tb[img][i][j][k] << std::endl;
    //                     //return 1;
    //                 }
    //             }
    //         }
    //     }
    // }
    // std::cout << "Testbench passed ✅" << std::endl;
    //return 0;

    
    memory_out_t golden_out[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0};
    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_OH; i++) {
            for (int j = 0; j < CONV_0_OW; j++) {
                for (int k = 0; k < CONV_0_OCH; k++) {
                    golden_out[img][i][j][k] = quant_out[i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
                }
            }
        }
    }
    
    std::cout << "golden_out_tb: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {
        std::cout << "Image " << img << ":" << std::endl;
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
                    if (output[img][i][j][k] != golden_out[img][i][j][k]) {
                        std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << output[img][i][j][k] << " != " << golden_out[img][i][j][k] << std::endl;
                        return 1;
                    }
                }
            }
        }
    }
    std::cout << "Testbench passed ✅" << std::endl;
    return 0;
}

