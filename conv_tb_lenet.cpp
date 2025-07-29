// #include <iostream>
// #include "top_wrapper.h"
// #include <fstream>
// #include <iostream>

// #include <ap_int.h>
// #include "parameter.h"

// // #include "input_lenet.h"
// // #include "kernel_lenet.h"
// // #include "output_lenet.h"

// // #include "input_resnet8.h"
// // #include "kernel_resnet8.h"
// // #include "output_resnet8.h"

// #include "input_resnet_18.h"
// #include "kernel_resnet_18.h"
// #include "output_resnet_18.h"

// #include "output_matrix_deq_and_quant.h"


// // template< int ICH, int IW, int IH,
// //     int FW_IN, int FH_IN,
// //     int OCH, int OW, int OH, 
// //     int ICH_PAR_IN,
// //     int STRIDE>
// // void convoluzione_gold(const memory_in_t input_values[], memory_out_t output_conv[OH * OW * OCH]){
// //     int input_idx = 0;
// //     int kernel_idx = 0;
// //     int out_idx = 0;
// //     for (int out_h = 0; out_h < OH; out_h++) {
// //         for (int out_w = 0; out_w < OW; out_w++) {
// //             for (int out_c = 0; out_c < OCH; out_c++) {
// //             memory_out_t sum = 0;
// //                 for (int in_c = 0; in_c < ICH; in_c++) {
// //                     for (int filter_h = 0; filter_h < FH_IN; filter_h++) {
// //                         for (int filter_w = 0; filter_w < FW_IN; filter_w++) {
// //                             int in_h = out_h + filter_h;
// //                             int in_w = out_w * STRIDE + filter_w;
// //                             input_idx = in_c + (in_w * ICH) + (in_h * IW * ICH);
// //                             kernel_idx = ((out_c * FH_IN + filter_h) * FW_IN + filter_w) * ICH + in_c;
// //                             sum += input_values[input_idx] * weights[kernel_idx];
// //                         }
// //                     }
// //                 }
// //                 // ReLU activation
// //                 if (sum < 0) {
// //                     sum = 0;
// //                 }
// //                 output_conv[out_idx] = sum;
// //                 out_idx++;
// //             }
// //         }
// //     }
// // }


// void simple_out_conv2mem(memory_out_t* output_flat,
//                          memory_out_t output[1][CONV_0_OH][CONV_0_OW][CONV_0_OCH]) {
//     int idx = 0;
//     for (int i = 0; i < CONV_0_OH; i++) {
//         for (int j = 0; j < CONV_0_OW; j++) {
//             for (int k = 0; k < CONV_0_OCH; k++) {
//                 output[0][i][j][k] = output_flat[idx++];
//             }
//         }
//     }
// }


// int main(){
//     constexpr int NR_IMG = 1; // Number of images to process
//     // Variables for input and output to pass to the top_wrapper
//     static hls::stream<mem_in_t> memory_in_stream("input_stream");
//     filter_stream_t filter_val_stream("filter1_stream");
//     // filter_stream_t filter_val_2_stream("filter2_stream");
//     static hls::stream<mem_out_t> memory_out_stream("output_stream");


//     // memory_out_t memory_out_local[CONV_2_OUTPUT_SIZE * NR_IMG] = {0}; // Local memory to store the output from the hardware
//     // ap_int<45> output[NR_IMG][CONV_2_OH][CONV_2_OW][CONV_2_OCH] = {0}; // Partitioned memory to store the output from the hardware and do comparison with the golden output

//     //-----------------------------------------------------------
//     // memory_out_t memory_out_local[CONV_0_OUTPUT_SIZE * NR_IMG] = {0}; // Local memory to store the output from the hardware
//     // memory_out_t output[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0}; // Partitioned memory to store the output from the hardware and do comparison with the golden output
//     auto memory_out_local = new memory_out_t[CONV_0_OUTPUT_SIZE * NR_IMG];
//     auto output = new memory_out_t[NR_IMG * CONV_0_OH * CONV_0_OW * CONV_0_OCH];
//     auto golden_out = new memory_out_t[NR_IMG * CONV_0_OH * CONV_0_OW * CONV_0_OCH];

//     // Insert the input data into the memory_in_stream
//     for (int img = 0; img < NR_IMG; img++) {
//         for (int i = 0; i < CONV_0_INPUT_SIZE; i++) {
//             memory_in_stream.write(input_values[img * CONV_0_INPUT_SIZE + i]); 
//         }
//         // Insert the data in filter_val_stream fot the kernel 1
//         for (int i = 0; i < KERNEL_SIZE_0; i++) {
//             filter_val_stream.write( (ap_int<8>)weights[i] ); 
//         }

//         // Insert the data in filter_val_2_stream for the kernel 2
//         // for (int i = 0; i < KERNEL_SIZE_1; i++) {
//         //     filter_val_2_stream.write( (ap_int<8>)kernel[i] );
//         // } 
//             top_wrapper(memory_in_stream, filter_val_stream, memory_out_stream); //call the top_wrapper function to process the input data and generate the output

//     }

//     int out_idx = 0;
//     for (int img = 0; img < NR_IMG; img++) {
//         while (true) { //until flag TLAST is set
//             mem_out_t pkt = memory_out_stream.read(); // read packet from output stream
//             memory_out_local[out_idx++] = pkt.data; // store the data in the local memory
//             if (pkt.last) break; // if TLAST is set, break the loop
//         }
//         std::cout << "\nTotale output letti: " << out_idx << std::endl;
//     }
//     // Convert the output from the local memory to the output array for the comparison with the golden output
//     for (int img = 0; img < NR_IMG; img++) {
//         // out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(&memory_out_local[img * CONV_2_OUTPUT_SIZE], output, NR_IMG, img);
//         //out_conv2mem<CONV_0_ICH, CONV_0_OW, CONV_0_OH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_1_OW, CONV_1_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(&memory_out_local[img * CONV_1_OUTPUT_SIZE], output, NR_IMG, img);
//         simple_out_conv2mem(&memory_out_local[img * CONV_0_OUTPUT_SIZE], output); //---------------------------------------------
//     }

//     std::cout << "memory hw: " << std::endl;
//     for (int img = 0; img < NR_IMG; img++) {   
//         std::cout << "Image " << img << ":" << std::endl; 
//         for (int k = 0; k < CONV_0_OCH; k++) {
//             for (int i = 0; i < CONV_0_OH; i++) {
//                 for (int j = 0; j < CONV_0_OW; j++) {
//                     std::cout << output[img][i][j][k] << " ";
//                 }
//                 std::cout << std::endl;
//             }
//             std::cout << std::endl;
//         }
//         std::cout << std::endl;
//     }

//     // memory_out_t output_conv[NR_IMG][CONV_0_OH * CONV_0_OW * CONV_0_OCH] = {0};
//     // for (int img = 0; img < NR_IMG; img++) {
//     //     convoluzione_gold< CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE>(&input_values[img * CONV_0_INPUT_SIZE], output_conv[img]);
//     // }

//     // int golden_out_tb[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0};
//     // for (int img = 0; img < NR_IMG; img++) {
//     //     for (int i = 0; i < CONV_0_OH; i++) {
//     //         for (int j = 0; j < CONV_0_OW; j++) {
//     //             for (int k = 0; k < CONV_0_OCH; k++) {
//     //                 golden_out_tb[img][i][j][k] = output_conv[img][i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
//     //             }
//     //         }
//     //     }
//     // }
//     // std::cout << "golden_out_tb: " << std::endl;
//     // for (int img = 0; img < NR_IMG; img++) {
//     //     std::cout << "Image " << img << ":" << std::endl;
//     //     for (int k = 0; k < CONV_0_OCH; k++) {
//     //         for (int i = 0; i < CONV_0_OH; i++) {
//     //             for (int j = 0; j < CONV_0_OW; j++) {
//     //                 std::cout << golden_out_tb[img][i][j][k] << " ";
//     //             }
//     //             std::cout << std::endl;
//     //         }
//     //         std::cout << std::endl;
//     //     }
//     //     std::cout << std::endl;
//     // }

//     // for (int img = 0; img < NR_IMG; img++) {
//     //     for (int k = 0; k < CONV_0_OCH; k++) {
//     //         for (int i = 0; i < CONV_0_OH; i++) {
//     //             for (int j = 0; j < CONV_0_OW; j++) {
//     //                 if (output[img][i][j][k] != golden_out_tb[img][i][j][k]) {
//     //                     std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << output[img][i][j][k] << " != " << golden_out_tb[img][i][j][k] << std::endl;
//     //                     //return 1;
//     //                 }
//     //             }
//     //         }
//     //     }
//     // }
//     // std::cout << "Testbench passed ✅" << std::endl;
//     //return 0;

    
//     // memory_out_t golden_out[NR_IMG][CONV_0_OH][CONV_0_OW][CONV_0_OCH] = {0};
//     for (int img = 0; img < NR_IMG; img++) {
//         for (int i = 0; i < CONV_0_OH; i++) {
//             for (int j = 0; j < CONV_0_OW; j++) {
//                 for (int k = 0; k < CONV_0_OCH; k++) {
//                     golden_out[img][i][j][k] = output_values[i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k]; //------------MODIFIED NAME HERE----------------------
//                 }
//             }
//         }
//     }
    
//     std::cout << "golden_out_tb: " << std::endl;
//     for (int img = 0; img < NR_IMG; img++) {
//         std::cout << "Image " << img << ":" << std::endl;
//         for (int k = 0; k < CONV_0_OCH; k++) {
//             for (int i = 0; i < CONV_0_OH; i++) {
//                 for (int j = 0; j < CONV_0_OW; j++) {
//                     std::cout << golden_out[img][i][j][k] << " ";
//                 }
//                 std::cout << std::endl;
//             }
//             std::cout << std::endl;
//         }
//         std::cout << std::endl;
//     }
//     for (int img = 0; img < NR_IMG; img++) {
//         for (int k = 0; k < CONV_0_OCH; k++) {
//             for (int i = 0; i < CONV_0_OH; i++) {
//                 for (int j = 0; j < CONV_0_OW; j++) {
//                     if (output[img][i][j][k] != golden_out[img][i][j][k]) {
//                         std::cout << "Mismatch at (" << i << ", " << j << ", " << k << "): " << output[img][i][j][k] << " != " << golden_out[img][i][j][k] << std::endl;
//                         return 1;
//                     }
//                 }
//             }
//         }
//     }
//     std::cout << "Testbench passed ✅" << std::endl;
//     return 0;
// }

#include <iostream> 
#include <vector>
#include "top_wrapper.h"
#include <fstream>
#include <ap_int.h>
#include "parameter.h"

#include "input_resnet_18.h"
#include "kernel_resnet_18.h"
#include "output_resnet_18.h"
#include "output_matrix_deq_and_quant.h"

void simple_out_conv2mem(memory_out_t* output_flat,
                         std::vector<memory_out_t>& output_vec) {
    int idx = 0;
    for (int i = 0; i < CONV_0_OH; i++) {
        for (int j = 0; j < CONV_0_OW; j++) {
            for (int k = 0; k < CONV_0_OCH; k++) {
                output_vec[i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k] = output_flat[idx++];
            }
        }
    }
}

// Helper per accessi flat-style
memory_out_t& get_output(std::vector<memory_out_t>& vec, int img, int i, int j, int k) {
    return vec[img * CONV_0_OH * CONV_0_OW * CONV_0_OCH + i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
}

int main() {
    constexpr int NR_IMG = 1;
    static hls::stream<mem_in_t> memory_in_stream("input_stream");
    filter_stream_t filter_val_stream("filter1_stream");
    static hls::stream<mem_out_t> memory_out_stream("output_stream");

    std::vector<memory_out_t> memory_out_local(CONV_0_OUTPUT_SIZE * NR_IMG);
    std::vector<memory_out_t> output(NR_IMG * CONV_0_OH * CONV_0_OW * CONV_0_OCH, 0);
    std::vector<memory_out_t> golden_out(NR_IMG * CONV_0_OH * CONV_0_OW * CONV_0_OCH, 0);

    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_INPUT_SIZE; i++) {
            memory_in_stream.write(input_values[img * CONV_0_INPUT_SIZE + i]); 
        }
        for (int i = 0; i < KERNEL_SIZE_0; i++) {
            filter_val_stream.write((ap_int<8>)weights[i]);
        }
        top_wrapper(memory_in_stream, filter_val_stream, memory_out_stream);
    }

    int out_idx = 0;
    for (int img = 0; img < NR_IMG; img++) {
        while (true) {
            mem_out_t pkt = memory_out_stream.read();
            memory_out_local[out_idx++] = pkt.data;
            if (pkt.last) break;
        }
        std::cout << "\nTotale output letti: " << out_idx << std::endl;
    }

    for (int img = 0; img < NR_IMG; img++) {
        simple_out_conv2mem(&memory_out_local[img * CONV_0_OUTPUT_SIZE], output);
    }

    std::cout << "memory hw: " << std::endl;
    for (int img = 0; img < NR_IMG; img++) {
        std::cout << "Image " << img << ":" << std::endl;
        for (int k = 0; k < CONV_0_OCH; k++) {
            for (int i = 0; i < CONV_0_OH; i++) {
                for (int j = 0; j < CONV_0_OW; j++) {
                    std::cout << get_output(output, img, i, j, k) << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
    }

    for (int img = 0; img < NR_IMG; img++) {
        for (int i = 0; i < CONV_0_OH; i++) {
            for (int j = 0; j < CONV_0_OW; j++) {
                for (int k = 0; k < CONV_0_OCH; k++) {
                    get_output(golden_out, img, i, j, k) = output_values[i * CONV_0_OW * CONV_0_OCH + j * CONV_0_OCH + k];
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
                    std::cout << get_output(golden_out, img, i, j, k) << " ";
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        }
    }

    for (int img = 0; img < NR_IMG; img++) {
        for (int k = 0; k < CONV_0_OCH; k++) {
            for (int i = 0; i < CONV_0_OH; i++) {
                for (int j = 0; j < CONV_0_OW; j++) {
                    auto hw_val = get_output(output, img, i, j, k);
                    auto ref_val = get_output(golden_out, img, i, j, k);
                    if (hw_val != ref_val) {
                        std::cout << "Mismatch at (" << i << ", " << j << ", " << k
                                  << "): " << hw_val << " != " << ref_val << std::endl;
                        return 1;
                    }
                }
            }
        }
    }

    std::cout << "Testbench passed ✅" << std::endl;
    return 0;
}
