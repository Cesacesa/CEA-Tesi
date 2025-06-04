#include "top_wrapper.h"

void load_input(memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN>& memory_in_local,
     memory_in_t* memory_in, int img)
{
    #pragma HLS INLINE off
    load_input_loop:
        for (int i = 0; i < CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR; i++) {
            for (int j = 0; j < (CONV_0_ICH * (WINDOW_IN * CONV_0_FW) * (WINDOW_IN * CONV_0_FH)) / (CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR); j++) {
                #pragma HLS PIPELINE
                memory_in_local[i][j] = memory_in[img][i][j];
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
    int in_idx = 0;
    int s_window_h = 0;
    int s_mem_i = 0;
    int s_mem_i_depth = 0;
    int special_row_window = 0;
    int special_col_window = 0;
    special_row_window = FW_OUT - ((OW / FW_OUT +1) * FW_OUT - OW);
    special_col_window = FH_OUT - ((OH / FH_OUT +1) * FH_OUT - OH);
    for (int s_ih = 0; s_ih < WINDOW_OUT * FW_OUT; s_ih += FH_OUT) {
        for (int s_fh = 0; s_fh < FH_OUT; s_fh++) {
            int s_window_w = 0;
            for (int s_iw = 0; s_iw < WINDOW_OUT * FW_OUT; s_iw += FW_OUT) {
                for (int s_fw = 0; s_fw < FW_OUT; s_fw++) {
                    for (int s_ich = 0; s_ich < OCH; s_ich += ICH_PAR_OUT) {
                        for (int s_ich_par = 0; s_ich_par < ICH_PAR_OUT; s_ich_par++) {
                            s_mem_i = (s_fw + s_fh * FW_OUT) + s_ich_par * FW_OUT * FH_OUT;
                            s_mem_i_depth = s_window_h + s_window_w + s_ich / ICH_PAR_OUT;
                            int val = memory[s_mem_i][s_mem_i_depth];
                            int in_h = s_ih + s_fh;
                            int in_w = s_iw + s_fw;
                            int in_c = s_ich + s_ich_par;
                            if (in_h < IH && in_w < IW && in_c < ICH) {
                                output[img][in_h][in_w][in_c] = val;
                            }                        
                        }
                    }
                    if (s_iw >= OW - FW_OUT) { // last filter window
                        if (special_row_window != 0) { //if CONV_0_IW % FW != 0
                            special_row_window--; // decrement the special row window in case there are more than one
                            if (special_row_window == 0){ // if the special row window is 0, we need to pass to the next row window
                                    special_row_window = FW_OUT - ((OW / FW_OUT +1) * FW_OUT - OW); // reset the special row window
                                s_fw += (FW_OUT); 
                            }
                        }
                    }    
                }
                s_window_w += OCH/ICH_PAR_OUT;
            }
            if (s_ih >= OH - FH_OUT) { // last filter window
                if (special_col_window != 0) { //if CONV_0_IH % FH != 0
                    special_col_window--;  // decrement the special col window in case there are more than one
                    if (special_col_window == 0){ // if the special col window is 0, we need to pass to the next row window
                        special_col_window = FH_OUT - ((OH / FH_OUT +1) * FH_OUT - OH); // reset the special col window
                        s_fh += FH_OUT; 
                    }
                }
            }
        }
        s_window_h+= OCH/ICH_PAR_OUT * (WINDOW_OUT);
    }
}


void top_wrapper(memory_in_t memory_in[NR_IMG], 
    const int* filter_val,  
    const int* filter_val_2, 
    memory_out_t memory[NR_IMG])
{
    #pragma HLS INTERFACE m_axi port=memory offset=slave bundle=gmem1
    #pragma HLS INTERFACE s_axilite port=return bundle=control
    #pragma HLS INTERFACE s_axilite port=memory_in bundle=gmem3
    #pragma HLS INTERFACE m_axi port=filter_val offset=slave bundle=gmem2 depth=100
    // #pragma HLS INTERFACE m_axi port=filter_val_2 offset=slave bundle=gmem4 depth=100

    
    for (int img = 0; img < NR_IMG; img++) {
        filter_stream_t filter2conv; //stream of single value of filter
        #pragma HLS STREAM variable=filter2conv depth=100
        // filter_stream_t filter2conv2; //stream of single value of filter2
        // #pragma HLS STREAM variable=filter2conv2 depth=100

        //write the value of the filter in the stream filter2conv
        // for (int i = 0; i < CONV_0_FW * CONV_0_FH * CONV_0_ICH * CONV_0_OCH; i++) {
        //     #pragma HLS PIPELINE II=1
        //     filter2conv.write((ap_int<8>)filter_val[i]);
        // }
        //write the value of the filter in the stream filter2conv2
        // for (int i = 0; i < CONV_1_FW * CONV_1_FH * CONV_0_OCH * CONV_1_OCH; i++) {
        //     #pragma HLS PIPELINE II=1
        //     filter2conv2.write((ap_int<8>)filter_val[i]);
        // }

        #pragma HLS DATAFLOW
        kernel2conv<CONV_0_FW, CONV_0_FH, CONV_0_ICH, CONV_0_OCH>(filter_val, filter2conv);
        //kernel2conv<CONV_1_FW, CONV_1_FH, CONV_0_OCH, CONV_1_OCH>(filter_val_2, filter2conv2);
        
        memory_in_conv_t<CONV_0_FW, CONV_0_FH, CONV_0_ICH_PAR, CONV_0_ICH, WINDOW_IN> memory_in_local;
        #pragma HLS ARRAY_PARTITION variable=memory_in_local complete dim=0

        memory_out_conv_t<CONV_1_FW, CONV_1_FH, CONV_1_ICH_PAR, CONV_1_OCH, WINDOW_OUT> out_mem;
        #pragma HLS ARRAY_PARTITION variable=out_mem complete dim=0

        // memory_out_conv_t<CONV_2_FW, CONV_2_FH, CONV_2_ICH_PAR, CONV_2_OCH, WINDOW_OUT_2> out_mem2;
        // #pragma HLS ARRAY_PARTITION variable=out_mem2 complete dim=0
        #ifndef __SYNTHESIS__
        std::cout << "img: " << img << std::endl;
        #endif
        load_input(memory_in_local, memory_in, img);

        conv<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_STRIDE, WINDOW_IN, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(memory_in_local, filter2conv, out_mem);

        //conv<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_STRIDE,WINDOW_OUT, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem, filter2conv2, out_mem2);

        //out_conv2mem<CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_1_FW, CONV_1_FH, CONV_1_OCH, CONV_1_OW, CONV_1_OH, CONV_1_ICH_PAR, CONV_1_OUTPUT_SIZE, CONV_1_STRIDE, CONV_2_ICH_PAR, CONV_2_FW, CONV_2_FH, CONV_2_OCH, WINDOW_OUT_2>(out_mem2, memory, img);

        out_conv2mem<CONV_0_ICH, CONV_0_IW, CONV_0_IH, CONV_0_FW, CONV_0_FH, CONV_0_OCH, CONV_0_OW, CONV_0_OH, CONV_0_ICH_PAR, CONV_0_OUTPUT_SIZE, CONV_0_STRIDE, CONV_1_ICH_PAR, CONV_1_FW, CONV_1_FH, CONV_1_OCH, WINDOW_OUT>(out_mem, memory, img);
        //print memory
        #ifndef __SYNTHESIS__
        std::cout << "memory hw: " << std::endl;
            for (int k = 0; k < CONV_0_OCH; k++) {
                for (int i = 0; i < CONV_0_OH; i++) {
                    for (int j = 0; j < CONV_0_OW; j++) {
                        std::cout << memory[img][i][j][k] << " ";
                    }
                    std::cout << std::endl;
                }
                std::cout << std::endl;
            }
            std::cout << std::endl;
        #endif
    }
}


