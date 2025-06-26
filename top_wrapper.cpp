#include "top_wrapper.h"

template< int ICH, int IW, int IH,
    int FW_IN, int FH_IN,
    int OCH, int OW, int OH, 
    int ICH_PAR_IN,
    int WINDOW_IN>
void input2conv(memory_in_t* memory_in,
    memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN>& memory_in_local,
    const int NR_IMG)
    {
    int s_window_h = 0; 
    int in_idx = 0;
    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int special_row_window = 0;
    int special_col_window = 0;
    special_row_window = FW_IN - ((IW / FW_IN +1) * FW_IN - IW);
    special_col_window = FH_IN - ((IH / FH_IN +1) * FH_IN - IH);
    for (int dim_input = 0; dim_input < CONV_0_INPUT_SIZE_MAX; dim_input++) {
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
                            // memory[img][s_mem_i][s_mem_i_depth] = input[in_idx]; //SENZA ICH_PAR
                            memory_in_local[s_mem_i][s_mem_i_depth] = memory_in[in_idx]; 
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

template<
    int FW,
    int FH,
    int ICH,
    int OCH,
    typename T = ap_int<8>>
void kernel2conv(const int* filter_val, hls::stream<T>& filter2conv) {
    const int total_kernel = FW * FH * ICH * OCH;
    for (int i = 0; i < total_kernel; i++) {
        #pragma HLS PIPELINE II=1
        filter2conv.write(filter_val[i]);
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
void out_conv2mem(memory_out_conv_t<FW_OUT, FH_OUT, ICH_PAR_OUT, OCH_OUT, WINDOW_OUT>& memory,
    memory_out_t* output,
    int img)
{
    int idx = 0;
    constexpr int MEM_WIDTH = FW_OUT * FH_OUT * ICH_PAR_OUT;
    constexpr int MEM_DEPTH = (OCH * WINDOW_OUT * FW_OUT * WINDOW_OUT * FH_OUT) / MEM_WIDTH;
    for (int j = 0; j < MEM_DEPTH; j++) {
        for (int i = 0; i < MEM_WIDTH; i++) {
            output[idx] = memory[i][j];
            idx++;
        }
    }
}

void top_wrapper(memory_in_t* memory_in, 
    const int NR_IMG,
    const int* filter_val,
    const int* filter_val_2, 
    memory_out_t* memory)
{
    #pragma HLS INTERFACE m_axi port=memory offset=slave bundle=gmem1 depth=90 max_widen_bitwidth=64
    #pragma HLS INTERFACE m_axi port=memory_in offset=slave bundle=gmem2 depth=490 max_widen_bitwidth=64
    #pragma HLS INTERFACE m_axi port=filter_val offset=slave bundle=gmem3 depth=100 max_widen_bitwidth=64
    #pragma HLS INTERFACE m_axi port=filter_val_2 offset=slave bundle=gmem4 depth=100 max_widen_bitwidth=64
    #pragma HLS INTERFACE s_axilite port=NR_IMG
    #pragma HLS INTERFACE s_axilite port=return
    
    for (int img = 0; img < NR_IMG; img++) {
        filter_stream_t filter2conv; //stream of single value of filter
        #pragma HLS STREAM variable=filter2conv depth=100
        filter_stream_t filter2conv2; //stream of single value of filter2
        #pragma HLS STREAM variable=filter2conv2 depth=100

        #pragma HLS DATAFLOW
        kernel2conv<CONV_0_FW, CONV_0_FH, CONV_0_ICH, CONV_0_OCH>(filter_val, filter2conv);
        kernel2conv<CONV_1_FW, CONV_1_FH, CONV_0_OCH, CONV_1_OCH>(filter_val_2, filter2conv2);

        
        memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN> memory_in_local;
        #pragma HLS ARRAY_PARTITION variable=memory_in_local complete dim=0

        memory_out_conv_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem;
        #pragma HLS ARRAY_PARTITION variable=out_mem complete dim=0

        memory_out_conv_t<CONV_2_FW, CONV_2_FH, CONV_2_ICH_PAR, CONV_2_OCH, WINDOW_OUT_2> out_mem2;
        #pragma HLS ARRAY_PARTITION variable=out_mem2 complete dim=0
        // #ifndef __SYNTHESIS__
        // std::cout << "img: " << img << std::endl;
        // #endif
        input2conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, WINDOW_IN>(memory_in, memory_in_local, NR_IMG);

        conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, WINDOW_IN, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(memory_in_local, filter2conv, out_mem);

        conv<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE,WINDOW_OUT, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem, filter2conv2, out_mem2);

        out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_OUTPUT_SIZE, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem2, memory, img);
    }
}


