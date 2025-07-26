#ifndef CONV_H
#define CONV_H

#include <iostream>
#include <fstream>
#include <ap_int.h>
#include <hls_vector.h>
#include <array>
#include "parameter.h"

template<int ICH, int IW, int IH,
    int FW, int FH, 
    int OCH, int OW, int OH,
    int ICH_PAR,
    int STRIDE,
    int WINDOW_IN,    
    int ICH_PAR_OUT,
    int FW_OUT, int FH_OUT, int OCH_OUT,
    int WINDOW_OUT>
void conv(hls::stream<conv_packet_t<FW, FH, ICH_PAR>> &conv_data_stream,
    filter_stream_t& filter_stream, //default ap_int<8>
    memory_out_conv_t<FW_OUT, FH_OUT, ICH_PAR_OUT, OCH_OUT, WINDOW_OUT>& out_mem)
{     
    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int s_fil_i = 0;
    int s_fil_i_depth = 0;
    int s_mem_o = 0;
    int s_mem_o_depth = 0;
    int special_row_window = 0;
    int special_col_window = 0;
    special_row_window = FW_OUT - ((OW / FW_OUT +1) * FW_OUT - OW);
    special_col_window = FH_OUT - ((OH / FH_OUT +1) * FH_OUT - OH);    
    int OUTPUT_SIZE = OCH * (FW_OUT * WINDOW_OUT) * (FH_OUT * WINDOW_OUT);

    constexpr int MEM_WIDTH = FW * FH * ICH_PAR;
    memory_out_t local_mem[MEM_WIDTH] = {0}; // local memory for debug purposes
    #pragma HLS ARRAY_PARTITION variable=local_mem complete dim=0

    ap_int<8> filter_mem[FW * FH * ICH_PAR][ICH / ICH_PAR] = {0};
    #pragma HLS ARRAY_PARTITION variable=filter_mem complete dim=0

    ap_int<16> bias[OCH] = {-1424, 1350, -1579, -5, 378, 642, 509, 531, 654, 130, 800, -213, 1473, -51, 439, 648}; // bias for each output channel

    L6: for (int s_och = 0; s_och < OCH; s_och += ICH_PAR_OUT) {
        for (int s_och_par = 0; s_och_par < ICH_PAR_OUT; s_och_par++){
            //read the filter_stream and put it in the filter_mem
            for (int s_fh = 0; s_fh < FH; s_fh++){
                for (int s_fw = 0; s_fw < FW; s_fw++){
                    for (int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR) {
                        for (int s_ich_par = 0; s_ich_par < ICH_PAR; s_ich_par++){
                            #pragma HLS pipeline II=1
                            int idx_filter = (s_fw + s_fh * FW) + s_ich_par * FW * FH;
                            int idx_depth = s_ich / ICH_PAR;
                            filter_mem[idx_filter][idx_depth] = filter_stream.read();
                        }
                    }
                }
            }
            // print filter_mem for debug purposes
            #ifndef __SYNTHESIS__
            std::cout << "Filter memory for output channel " << s_och + s_och_par << ": " << std::endl;
            for (int i = 0; i < FW * FH * ICH_PAR; i++) {
                for (int j = 0; j < ICH / ICH_PAR; j++) {
                    std::cout << (int)filter_mem[i][j] << " ";
                }
                std::cout << std::endl;
            }
            #endif
            L5: for(int s_oh = 0; s_oh < OH; s_oh++){
                L4: for(int s_ow = 0; s_ow < OW; s_ow++){
                    memory_out_t sum = bias[s_och + s_och_par]; // inizializza la somma con il bias -------------------------------------------------
                    L3: for(int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR){
                        #pragma HLS pipeline II=1
                        // read the conv_data_stream and put it in a local_mem
                        conv_packet_t<FW, FH, ICH_PAR> conv_packet = conv_data_stream.read();
                        // Estrai valori dal pacchetto nei rispettivi elementi locali
                        for (int idx = 0; idx < MEM_WIDTH; idx++) {
                            local_mem[idx] = conv_packet((idx + 1) * 8 - 1, idx * 8);
                        }
                        L3_bis: for (int s_ich_par = 0; s_ich_par < ICH_PAR; s_ich_par++){
                            L2: for (int s_fh = 0; s_fh < FH; s_fh++){
                                L1: for (int s_fw = 0; s_fw < FW; s_fw++){
                                    s_fil_i = s_fw + s_fh*FW + s_ich_par * FW * FH;
                                    s_fil_i_depth = s_ich / ICH_PAR; // + s_och * ICH / ICH_PAR;
                                    sum += local_mem[s_fil_i] * filter_mem[s_fil_i][s_fil_i_depth];
                                    // #ifndef __SYNTHESIS__
                                    // std::cout << "DEBUG: local_mem[s_fil_i]=" << (int)local_mem[s_fil_i]
                                    //           << " filter_mem[s_fil_i][s_fil_i_depth]=" << (int)filter_mem[s_fil_i][s_fil_i_depth]
                                    //           << " sum=" << sum << std::endl;
                                    // #endif
                                    s_mem_o = (s_ow) % FW_OUT + (s_oh * FH_OUT) % (FH_OUT * FW_OUT) + s_och_par * FH_OUT * FW_OUT; 
                                    s_mem_o_depth = (s_ow / FW_OUT) * (OCH / ICH_PAR_OUT) + (s_oh / FH_OUT) * (OCH / ICH_PAR_OUT) * (WINDOW_OUT) + s_och / ICH_PAR_OUT;
                                    // if (sum < 0) {
                                    //     sum = 0;
                                    // }
                                    // out_mem[s_mem_o][s_mem_o_depth] = sum;
                                    if (s_ow >= OW - FW_OUT){
                                        if (special_row_window != 0){
                                            special_row_window--;
                                            if (special_row_window == 0){
                                                special_row_window = FW_OUT - ((OW / FW_OUT +1) * FW_OUT - OW);
                                            }
                                        }
                                    }
                                    if (s_oh >= OH - FH_OUT){
                                        if (special_col_window != 0){
                                            special_col_window--;
                                            if (special_col_window == 0){
                                                special_col_window = FH_OUT - ((OH / FH_OUT +1) * FH_OUT - OH);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (sum < 0) {
                        sum = 0;
                    }
                    out_mem[s_mem_o][s_mem_o_depth] = sum;
                    // #ifndef __SYNTHESIS__
                    // std::cout << "DEBUG: Writing to out_mem[" << s_mem_o << "][" << s_mem_o_depth << "] = " << (int)sum << std::endl;       
                    // #endif
                }
            }
        }
    }
    // #ifndef __SYNTHESIS__
    // std::cout << "Out Memory conv.h: " << std::endl;
    // for (int i = 0; i < FW_OUT * FH_OUT * ICH_PAR_OUT; i++){
    //     for (int j = 0; j < OUTPUT_SIZE / (FW_OUT * FH_OUT * ICH_PAR_OUT); j++){
    //         std::cout << out_mem[i][j] << " ";
    //     }
    //     std::cout << std::endl;
    // }
    // std::cout << std::endl;
    // #endif
}
#endif // CONV_H