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
    const int total_kernel = FW * FH * ICH * OCH;
    for (int i = 0; i < total_kernel; i++) {
        #pragma HLS PIPELINE II=1
        T filter_val = filter_val_stream.read(); // read filter value from stream
        filter2conv.write(filter_val); // write filter value to filter2conv stream
    }
}

template<
    int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int WINDOW_IN,
    int STRIDE,
    int ICH_PAR_OUT>
void mem_conv2stream(
    memory_in_conv_t<FW_IN, FH_IN, ICH_PAR_IN, ICH, WINDOW_IN>& memory_in,
    hls::stream<conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN>> &conv_data_stream)
{

    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int packet_element_idx = 0; // index to write in the packet
    int MEM_IN_T_BIT_WIDTH = 8; // bit width of each packet element
    conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN> current_packet;
    // #pragma HLS STREAM variable=current_packet depth=1
    
    for (int s_och = 0; s_och < OCH; s_och += ICH_PAR_OUT) {
        for (int s_och_par = 0; s_och_par < ICH_PAR_OUT; s_och_par++){
            for(int s_oh = 0; s_oh < OH; s_oh++){
                for(int s_ow = 0; s_ow < OW; s_ow++){
                    for(int s_ich = 0; s_ich < ICH; s_ich += ICH_PAR_IN){
                        #pragma HLS pipeline II=1
                        for (int s_ich_par = 0; s_ich_par < ICH_PAR_IN; s_ich_par++){
                            conv_packet_t<FW_IN, FH_IN, ICH_PAR_IN> current_packet = 0; // azzera!
                            packet_element_idx = 0;
                            for (int s_fh = 0; s_fh < FH_IN; s_fh++){
                                for (int s_fw = 0; s_fw < FW_IN; s_fw++){
                                    s_mem_i_depth = ((s_ow * STRIDE + s_fw) / FW_IN ) * (ICH/ICH_PAR_IN) + ((s_oh + s_fh) / FH_IN) * ICH/ICH_PAR_IN * WINDOW_IN + s_ich / ICH_PAR_IN; //CON STRIDE E ICH_PAR
                                    s_mem_i = (((s_ow * STRIDE + s_fh * FW_IN + s_fw) % FW_IN) + ((s_oh * FH_IN + s_fh * FW_IN)) % (FH_IN * FW_IN)) + s_ich_par * FW_IN * FH_IN; //CON STRIDE

                                    current_packet((packet_element_idx + 1) * MEM_IN_T_BIT_WIDTH - 1, packet_element_idx * MEM_IN_T_BIT_WIDTH) = memory_in[s_mem_i][s_mem_i_depth]; // read from memory and write to packet
                                    packet_element_idx++;
                                    // print debug
                                    // #ifndef __SYNTHESIS__
                                    // std::cout << "s_mem_i: " << s_mem_i 
                                    //         << ", s_mem_i_depth: " << s_mem_i_depth
                                    //         << ", memory_in[s_mem_i][s_mem_i_depth]: " << memory_in[s_mem_i][s_mem_i_depth] 
                                    //         << ", packet_element_idx: " << packet_element_idx 
                                    //         << ", current_packet: " << current_packet
                                    //         << std::endl;
                                    // #endif
                                }
                            }
                            // #ifndef __SYNTHESIS__
                            // for (int i = 0; i < FW_IN * FH_IN * ICH_PAR_IN; i++) {
                            //     memory_out_t slice = current_packet.range((i+1)*8 - 1, i*8);
                            //     std::cout << "Packet slice[" << i << "]: " << slice.to_int() << std::endl;
                            // }
                            // #endif
                            conv_data_stream.write(current_packet);
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
            // if (memory[i][j] < 0) {
            //     memory[i][j] = 0; // ReLU activation
            // }
            pkt.data = memory[i][j];
            pkt.keep = -1;              // tutti i byte validi
            pkt.last = (j == MEM_DEPTH - 1) && (i == MEM_WIDTH - 1); //set flag TLAST
            memory_out_stream.write(pkt); //send packet to output stream
        }
    }
}


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
    #pragma HLS STREAM variable=filter2conv depth=500
    // filter_stream_t filter2conv2; //stream of single value of filter2
    // #pragma HLS STREAM variable=filter2conv2 depth=100

    #pragma HLS DATAFLOW
    kernel2conv<CONV_0_FW, CONV_0_FH, CONV_0_ICH, CONV_0_OCH>(filter_val_stream, filter2conv); // stream passed to first conv
    // kernel2conv<CONV_1_FW, CONV_1_FH, CONV_0_OCH, CONV_1_OCH>(filter_val_2_stream, filter2conv2); // stream passed to second conv

    memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN> memory_in_local; // partiotioned memory for input
    //#pragma HLS ARRAY_PARTITION variable=memory_in_local complete dim=0
    #pragma HLS ARRAY_PARTITION variable=memory_in_local cyclic factor=9 dim=0


    memory_out_conv_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem; // partiotioned memory for output of first conv
    //#pragma HLS ARRAY_PARTITION variable=out_mem complete dim=0
    #pragma HLS BIND_STORAGE variable=out_mem type=ram_t2p impl=bram

    // memory_out_conv_t<CONV_2_FW, CONV_2_FH, CONV_2_ICH_PAR, CONV_2_OCH, WINDOW_OUT_2> out_mem2; // partiotioned memory for output of second conv
    // #pragma HLS ARRAY_PARTITION variable=out_mem2 complete dim=0

    input2conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN>(memory_in_stream, memory_in_local); // read stream and fill memory_in_local
    //print memory_in_local; // debug print
    // #ifndef __SYNTHESIS__
    // std::cout << "Memory in local: " << std::endl;
    // for (int i = 0; i < CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR; i++) {
    //     for (int j = 0; j < (CONV_0_ICH * (WINDOW_IN * CONV_0_FW) * (WINDOW_IN * CONV_0_FH)) / (CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR); j++) {
    //         std::cout << memory_in_local[i][j] << " ";
    //     }  
    //     std::cout << std::endl;
    // }
    // std::cout << std::endl;
    // #endif
    
    hls::stream<conv_packet_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR>> conv_data_stream; // stream of conv data
    #pragma HLS STREAM variable=conv_data_stream depth=100
    mem_conv2stream<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN, CONV_0_STRIDE, CONV_1_ICH_PAR>(memory_in_local, conv_data_stream); // convert memory to stream for first conv

    conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, WINDOW_IN, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(conv_data_stream, filter2conv, out_mem); // fisrt convolution
    //print out_mem; // debug print
    // #ifndef __SYNTHESIS__
    // std::cout << "Output memory after first convolution: " << std::endl;
    // for (int i = 0; i < CONV_1_FW * CONV_1_FH * CONV_1_ICH_PAR; i++) {
    //     for (int j = 0; j < (CONV_1_OCH * (WINDOW_OUT * CONV_1_FW) * (WINDOW_OUT * CONV_1_FH)) / (CONV_1_FW * CONV_1_FH * CONV_1_ICH_PAR); j++) {
    //         std::cout << out_mem[i][j] << " ";
    //     }  
    //     std::cout << std::endl;
    // }
    // std::cout << std::endl;
    // #endif

    // hls::stream<conv_packet_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR>> conv_data_stream2; // stream of conv data for second conv
    // #pragma HLS STREAM variable=conv_data_stream2 depth=100
    // mem_conv2stream<CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, WINDOW_OUT, CONV_1_STRIDE, CONV_2_ICH_PAR>(out_mem, conv_data_stream2); // convert memory to stream for second conv

    // conv<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE,WINDOW_OUT, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(conv_data_stream2, filter2conv2, out_mem2); // second convolution

    
    // out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem, memory_out_stream); // read partitioned memory and write to output stream

    memory_out_quant <CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem_quant; // partitioned memory for quantized output
    matrix_wrapper(out_mem, out_mem_quant);

    out_conv2mem<CONV_0_ICH, CONV_0_OW, CONV_0_OH, CONV_0_FW, CONV_0_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(out_mem_quant, memory_out_stream); // read partitioned memory and write to output stream
}


