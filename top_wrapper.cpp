#include "top_wrapper.h"
#include "operation_on_matrix.h"

template< int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int WINDOW_IN>
void input2conv(hls::stream<mem_in_t>& memory_in_stream,
    memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN>& memory_in_local)
    {
    #ifndef __SYNTHESIS__
    std::cout << "Start input to conv" << std::endl;
    #endif
    int s_window_h = 0; 
    int in_idx = 0;
    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int special_row_window = 0;
    int special_col_window = 0;
    special_row_window = FW_IN - ((IW / FW_IN +1) * FW_IN - IW); // calculate the special row window in case IW % FW != 0
    special_col_window = FH_IN - ((IH / FH_IN +1) * FH_IN - IH); // calculate the special col window in case IH % FH != 0
    s_mem_i = 0;
    s_window_h = 0;
    s_mem_i_depth = 0;
    int read_counter = 0; 
    for (int s_ih = 0; s_ih < WINDOW_IN * FW_IN; s_ih += FH_IN) {
        for (int s_fh = 0; s_fh < FH_IN; s_fh++) {
        int s_window_w = 0;  
            for (int s_iw = 0; s_iw < WINDOW_IN * FW_IN; s_iw += FW_IN) {
                for (int s_fw = 0; s_fw < FW_IN; s_fw++) {
                    for (int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR_IN) {
                        for (int s_ich_par = 0; s_ich_par < ICH_PAR_IN; s_ich_par++) {
                            #pragma HLS PIPELINE II=1
                            s_mem_i = (s_fw + s_fh * FW_IN) + s_ich_par * FW_IN * FH_IN; 
                            s_mem_i_depth = s_window_h + s_window_w + s_ich / ICH_PAR_IN;
                            memory_in_local[s_mem_i][s_mem_i_depth] = memory_in_stream.read();
                            #ifndef __SYNTHESIS__
                            read_counter++;
                            #endif
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
    #ifndef __SYNTHESIS__
    std::cout << "Total reads from memory_in_stream: " << read_counter << std::endl;
    #endif
}

template<
    int FW,
    int FH,
    int ICH,
    int OCH,
    typename T = ap_int<8>>
void kernel2conv(filter_stream_t& filter_val_stream, hls::stream<T>& filter2conv) {
    #ifndef __SYNTHESIS__
    std::cout << "Start kernel to conv" << std::endl;
    #endif
    const int total_kernel = FW * FH * ICH * OCH;
    for (int i = 0; i < total_kernel; i++) {
        #pragma HLS PIPELINE II=1
        T filter_val = filter_val_stream.read(); // read filter value from stream
        filter2conv.write(filter_val); // write filter value to filter2conv stream
    }
}


// #ifndef __SYNTHESIS__
// template<
//     int ICH, int IW, int IH,
//     int FW_IN, int FH_IN,
//     int ICH_PAR_IN,
//     int WINDOW_IN,
//     int PADDING
// >
// void debug_print_padded_image(
//     memory_in_conv_t<FW_IN, FH_IN, ICH_PAR_IN, ICH, WINDOW_IN>& memory_in)
// {
//     constexpr int PH = IH + 2 * PADDING;
//     constexpr int PW = IW + 2 * PADDING;

//     printf("\n=== DEBUG: Immagine con padding=%d (%dx%d -> %dx%d), %d canali ===\n",
//            PADDING, IH, IW, PH, PW, ICH);
//     // Cicliamo su tutti i canali
//     for (int c = 0; c < ICH; c++) {
//         printf("\n--- Canale %d ---\n", c);
//         for (int ih_padded = 0; ih_padded < PH; ih_padded++) {
//             for (int iw_padded = 0; iw_padded < PW; iw_padded++) {
//                 int ih_real = ih_padded - PADDING;
//                 int iw_real = iw_padded - PADDING;
//                 int val_dbg = 0;
//                 if (ih_real >= 0 && ih_real < IH && iw_real >= 0 && iw_real < IW) {
//                     // pixel valido -> leggi il valore del canale c
//                     int s_mem_depth = (iw_real / FW_IN) * (ICH/ICH_PAR_IN) + (ih_real / FH_IN) * (ICH/ICH_PAR_IN) * WINDOW_IN + (c / ICH_PAR_IN);
//                     int s_mem_idx   = (iw_real % FW_IN) + (ih_real % FH_IN) * FW_IN;
//                     val_dbg = (int)memory_in[s_mem_idx][s_mem_depth * ICH_PAR_IN + (c % ICH_PAR_IN)];
//                 } else {
//                     // padding
//                     val_dbg = 0;
//                 }
//                 printf("%3d ", val_dbg);
//             }
//             printf("\n");
//         }
//     }
//     printf("=== END DEBUG ===\n");
// }
// #endif

template<
    int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int WINDOW_IN,
    int STRIDE,
    int ICH_PAR_OUT,
    int PADDING>
void mem_conv2stream(
    memory_in_conv_t<FW_IN, FH_IN, ICH_PAR_IN, ICH, WINDOW_IN>& memory_in,
    hls::stream<conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN>> &conv_data_stream)
{

    // #ifndef __SYNTHESIS__
    // // QUI faccio una stampa dell’immagine padded per vedere se è corretta
    // debug_print_padded_image<ICH, IW, IH, FW_IN, FH_IN, ICH_PAR_IN, WINDOW_IN, PADDING>(memory_in);
    // #endif

    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int packet_element_idx = 0; // index to write in the packet
    constexpr int MEM_IN_T_BIT_WIDTH = 8; // bit width of each packet element
    conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN> current_packet;
    
    for (int s_och = 0; s_och < OCH; s_och += ICH_PAR_OUT) {
        for (int s_och_par = 0; s_och_par < ICH_PAR_OUT; s_och_par++){
            for(int s_oh = 0; s_oh < OH; s_oh++){
                for(int s_ow = 0; s_ow < OW; s_ow++){
                    for(int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR_IN){
                        for (int s_ich_par = 0; s_ich_par < ICH_PAR_IN; s_ich_par++){
                            conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN> current_packet = 0; // azzera!
                            packet_element_idx = 0;
                            for (int s_fh = 0; s_fh < FH_IN; s_fh++){
                                for (int s_fw = 0; s_fw < FW_IN; s_fw++){
                                    int ih_real = s_oh * STRIDE + s_fh - PADDING;
                                    int iw_real = s_ow * STRIDE + s_fw - PADDING;

                                    if (ih_real < 0 || ih_real >= IH || iw_real < 0 || iw_real >= IW) {
                                        // padding -> scrivi 0
                                        current_packet((packet_element_idx + 1) * MEM_IN_T_BIT_WIDTH - 1, packet_element_idx * MEM_IN_T_BIT_WIDTH) = 0;
                                    } else {
                                        // valido -> leggi da memoria
                                        s_mem_i_depth = (iw_real / FW_IN) * (ICH/ICH_PAR_IN) + (ih_real / FH_IN) * ICH/ICH_PAR_IN * WINDOW_IN + s_ich / ICH_PAR_IN;
                                        s_mem_i = ( (iw_real % FW_IN) + (ih_real % FH_IN) * FW_IN ) + s_ich_par * FW_IN * FH_IN;
                                        current_packet((packet_element_idx + 1) * MEM_IN_T_BIT_WIDTH - 1, packet_element_idx * MEM_IN_T_BIT_WIDTH) = memory_in[s_mem_i][s_mem_i_depth];
                                    }
                                    packet_element_idx++;
                                }
                            }
                            // #ifndef __SYNTHESIS__
                            // for (int i = 0; i < FW_IN * FH_IN * ICH_PAR_IN; i++) {
                            //     memory_out_t slice = current_packet.range((i+1)*8 - 1, i*8);
                            //     std::cout << "Packet slice[" << i << "]: " << slice.to_int() << std::endl;
                            // }
                            // #endif
                            conv_data_stream.write(current_packet);
                            // #ifndef __SYNTHESIS__
                            // printf("DEBUG WINDOW: OH=%d OW=%d ICH_BASE=%d : ", s_oh, s_ow, s_ich);
                            // for (int dbg_idx = 0; dbg_idx < FW_IN * FH_IN * ICH_PAR_IN; dbg_idx++) {
                            //     ap_uint<MEM_IN_T_BIT_WIDTH> val_dbg = current_packet((dbg_idx + 1) * MEM_IN_T_BIT_WIDTH - 1, dbg_idx * MEM_IN_T_BIT_WIDTH);
                            //     printf("%3d ", (int)val_dbg);
                            // }
                            // printf("\n");
                            // #endif
                        }
                    }
                }
            }
        }
    }
}




template< int ICH, int IW, int IH,
          int FW_IN, int FH_IN,
          int OCH, int OW, int OH,
          int ICH_PAR_IN, int STRIDE,
          int ICH_PAR_OUT, int FW_OUT, int FH_OUT, int OCH_OUT,
          int WINDOW_OUT>
void out_conv2mem(memory_out_quant<FW_OUT, FH_OUT, ICH_PAR_OUT, OCH_OUT, WINDOW_OUT>& memory,
                  hls::stream<mem_out_t>& memory_out_stream)
{
    constexpr int MEM_WIDTH = FW_OUT * FH_OUT * ICH_PAR_OUT;
    constexpr int MEM_DEPTH = (OCH * WINDOW_OUT * FW_OUT * WINDOW_OUT * FH_OUT) / MEM_WIDTH;

    for (int j = 0; j < MEM_DEPTH; ++j) {
        #pragma HLS PIPELINE II=1
        for (int i = 0; i < MEM_WIDTH; ++i) {
            mem_out_t pkt;
            pkt.data = memory[i][j];
            pkt.keep = -1;              // tutti i byte validi
            pkt.last = (j == MEM_DEPTH - 1) && (i == MEM_WIDTH - 1); //set flag TLAST
            memory_out_stream.write(pkt); //send packet to output stream
        }
    }
}

// template<int FW,
//         int FH,
//         int ICH_PAR,
//         int OCH,
//         int WINDOW>
// void skip_add(
//     memory_out_quant<FW, FH, ICH_PAR, OCH, WINDOW> &in1,
//     memory_out_quant<FW, FH, ICH_PAR, OCH, WINDOW> &in2,
//     memory_out_quant<FW, FH, ICH_PAR, OCH, WINDOW> &out)
// {
//     #ifndef __SYNTHESIS__
//         std::cout << "Start skip_add" << std::endl;
//     #endif
//     constexpr int MEM_WIDTH = FW * FH * ICH_PAR;
//     constexpr int MEM_DEPTH = (OCH * WINDOW * FW * WINDOW * FH) / MEM_WIDTH;
//     for (int j = 0; j < MEM_DEPTH; j++) {
//         for (int i = 0; i < MEM_WIDTH; i++) {
//             #pragma HLS PIPELINE II=1
//             out[i][j] = in1[i][j] + in2[i][j];
//         }
//     }
// }



void top_wrapper(hls::stream<mem_in_t>  &memory_in_stream,
                 filter_stream_t        &filter_val_stream,
                //  filter_stream_t        &filter_val_2_stream,
                 hls::stream<mem_out_t> &memory_out_stream)
{
    #pragma HLS INTERFACE axis port=memory_in_stream
    #pragma HLS INTERFACE axis port=filter_val_stream
    // #pragma HLS INTERFACE axis port=filter_val_2_stream
    #pragma HLS INTERFACE axis port=memory_out_stream
    #pragma HLS INTERFACE ap_ctrl_none port=return

    filter_stream_t filter2conv; //stream of single value of filter
    #pragma HLS STREAM variable=filter2conv depth=10000 //-------------------------------------------------------------------------------
    // filter_stream_t filter2conv2; //stream of single value of filter2
    // #pragma HLS STREAM variable=filter2conv2 depth=100

    #pragma HLS DATAFLOW
    kernel2conv<CONV_0_FW, CONV_0_FH, CONV_0_ICH, CONV_0_OCH>(filter_val_stream, filter2conv); // stream passed to first conv
    // kernel2conv<CONV_1_FW, CONV_1_FH, CONV_0_OCH, CONV_1_OCH>(filter_val_2_stream, filter2conv2); // stream passed to second conv

    memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN> memory_in_local; // partiotioned memory for input
    //#pragma HLS ARRAY_PARTITION variable=memory_in_local complete dim=0
    #pragma HLS ARRAY_PARTITION variable=memory_in_local cyclic factor=7 dim=0 //-----------------------------------------------------------
    #pragma HLS ARRAY_PARTITION variable=memory_in_local cyclic factor=8 dim=1

    memory_out_conv_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem; // partiotioned memory for output of first conv
    // #pragma HLS ARRAY_PARTITION variable=out_mem complete dim=0
    // #pragma HLS ARRAY_PARTITION variable=out_mem cyclic factor=7 dim=0

    // memory_out_conv_t<CONV_2_FW, CONV_2_FH, CONV_2_ICH_PAR, CONV_2_OCH, WINDOW_OUT_2> out_mem2; // partiotioned memory for output of second conv
    // #pragma HLS ARRAY_PARTITION variable=out_mem2 complete dim=0


    ap_int<32> bias_conv1[CONV_0_OCH] = {722, 873, 493, 954, 839, 561, 679, 732, 336, 796, 766, 836, 675, 739, 564, 838, 613, 896, 747, 517, 657, 357, 725, 913, 1088, 756, 252, 647, 256, 646, 617, 806,
    721, 873, 678, 793, 699, 563, 744, 590, 526, 896, 758, 672, 916, 659, 771, 651, 706, 552, 852, 1006, 799, 861, 650, 688, 405, 653, 792, 725, 589, 240, 779, 330, 160, 634, 662, 515, 1077, 625, 774, 778,
    864, 666, 773, 725, 1022, 834, 848, 616, 809, 827, 920, 858, 820, 848, 693, 1236, 829, 878, 846, 351, 686, 652, 990, 626, 618, 791, 629, 839, 741, 829, 679, 735, 597, 824, 710, 548, 1011, 714, 428, 689,
    668, 735, 767, -1168, 939, 558, 784, 661, 582, 697, 474, 705, 677, 624, 721, 465, 856, 953, 845, 633, 789, 777, 609, 436, 584, 694, 431, 484, 311, 527, 1082, 787, 893, 708, 670, 869, 771, 612, 785, 549,
    860, 885, 513, 738, 536, 798, 611, 1049, 745, 731, 837, 699, 995, 642, 676, 992, 261, 681, 551, 764, 416, 785, 922, 863, 823, 738, 748, 692, 674, 797, 813, 734, 551, 751, 993, 814, 631, 481, 659, 616,
    513, 777, 673, 618, -226, 683, 670, 807, 579, 733, 240, 725, 689, 666, 630, 1087, 633, 468, 842, 774, 800, 709, 973, 849, 421, 706, 770, 652, 612, 379, 675, 504, 786, 898, 738, 730, 547, 673, 760, 945,
    1001, 847, 585, 919, 863, 612, 648, 713, 1040, 930, 735, 1213, 698, 821, 505, 436, 638, 764, 835, 420, 659, 714, 789, 432, 565, 559, 808, 645, 820, 484, 503, 750, 792, 544, 804, 706, 697, 582, 539, 654,
    731, 918, 803, 688, 730, 891, 960, 579, 647, 584, 517, 673, 870, 660, 680, 797, 814, 755, 891, 758, 596, 715, 794, 646, 587, 671, 748, 803, 878, 868, 549, 803, 705, 764, 951, 807, 1055, 845, 813, 803,
    685, 664, 566, 852, 783, 1000, 841, 4, 803, 516, 340, 680, 868, 692, 731, 781, 278, 779, 441, 858, 674, 698, 890, 780, 345, 668, 310, 592, 698, 759, 911, 845, 267, 823, 675, 647, 654, 1001, 633, 619,
    774, 703, 910, 736, 627, 414, 759, 764, 666, 839, 875, 701, 673, 767, 657, 642, 439, 579, 516, 824, 704, 780, 643, 520, 527, 837, 725, 663, 702, 771, 554, 646, 744, 823, 839, 530, 566, 665, 858, 632,
    588, 1208, 336, 923, 596, 699, 668, 762, 103, 596, 690, 732, 568, 913, 1114, 542, 398, 690, 734, 866, 856, -73, 477, 678, 616, 707, 576, 929, 591, 700, 636, 287, 728, 721, 420, 849, 550, 631, 839, 1017,
    828, 781, 710, 488, 733, 697, 616, 711, 370, 712, 718, 627, 796, 660, 887, 603, 826, 768, 715, 347, 1200, 759, 800, 787, 639, 1019, 610, 572, 1106, 632, 785, 745, 872, 711, 719, 693, 863, 776, 622, 816,
    616, 702, 760, 918, 836, 738, 594, 754, 374, 971, 752, 834, 736, 903, 841, 932, 772, 360, 507, 221, 743, 785, 527, 916, 699, 1100, 822, 731, 707, 859, 716, 894, 1031, 852, 776, 975, 735, 793, 905, 860
    };
    
    input2conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN>(memory_in_stream, memory_in_local); // read stream and fill memory_in_local
    
    hls::stream<conv_packet_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR>> conv_data_stream; // stream of conv data
    #pragma HLS STREAM variable=conv_data_stream depth=2000 //MODIFICARE QUESTO PRIMA 100 --> 1000
    mem_conv2stream<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_0_PADDING>(memory_in_local, conv_data_stream); // convert memory to stream for first conv

    #ifndef __SYNTHESIS__
    std::cout << "-------------------------------------------------------" << std::endl;
    #endif

    conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, WINDOW_IN, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(conv_data_stream, filter2conv, bias_conv1, out_mem); // fisrt convolution

    // hls::stream<conv_packet_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR>> conv_data_stream2; // stream of conv data for second conv
    // #pragma HLS STREAM variable=conv_data_stream2 depth=100
    // mem_conv2stream<CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, WINDOW_OUT, CONV_1_STRIDE, CONV_2_ICH_PAR>(out_mem, conv_data_stream2); // convert memory to stream for second conv

    // conv<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE,WINDOW_OUT, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(conv_data_stream2, filter2conv2, out_mem2); // second convolution

    
    // out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem, memory_out_stream); // read partitioned memory and write to output stream

    memory_out_quant <CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem_quant; // partitioned memory for quantized output
    // #pragma HLS BIND_STORAGE variable=out_mem_quant type=ram_t2p impl=bram
    constexpr int HEIGHT_1 = CONV_1_FW * CONV_1_FH * CONV_1_ICH_PAR;
    constexpr int WIDTH_1 = (CONV_1_OCH * CONV_1_FW * CONV_1_FH * WINDOW_OUT * WINDOW_OUT) / (CONV_1_FW * CONV_1_FH * CONV_1_ICH_PAR);
    matrix_wrapper<HEIGHT_1, WIDTH_1, 32, 8, 5>(out_mem, out_mem_quant);

    // memory_out_quant<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem_added; // partitioned memory for skip connection
    // skip_add<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT>(out_mem_quant, out_mem_skip, out_mem_added);

    out_conv2mem<CONV_0_ICH, CONV_0_OW, CONV_0_OH, CONV_0_FW, CONV_0_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(out_mem_quant, memory_out_stream); // read partitioned memory and write to output stream
}


