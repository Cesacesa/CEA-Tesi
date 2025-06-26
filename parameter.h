#ifndef PARAMETER_H
#define PARAMETER_H

#include <ap_int.h> 
#include <hls_stream.h>

#define CONV_0_STRIDE 1 
#define CONV_0_ICH_PAR 1

#define CONV_0_ICH 2// input channels
#define CONV_0_IW 7 // input width
#define CONV_0_IH 7 // input height
#define CONV_0_INPUT_SIZE (CONV_0_ICH * CONV_0_IW * CONV_0_IH) // input size


#define CONV_0_FW 3 // filter width
#define CONV_0_FH 3 // filter height

#if (CONV_0_IW % CONV_0_FW != 0) 
    constexpr int WINDOW_IN = CONV_0_IW / CONV_0_FW + 1; 
#else 
    constexpr int WINDOW_IN = CONV_0_IW / CONV_0_FW;
#endif

#define CONV_0_OCH 2 // output channels
#define CONV_0_OW ((CONV_0_IW - CONV_0_FW) / CONV_0_STRIDE + 1) // output width
#define CONV_0_OH ((CONV_0_IH - CONV_0_FH) / CONV_0_STRIDE + 1) // output height
constexpr int CONV_0_INPUT_SIZE_MAX =  CONV_0_FH * WINDOW_IN * CONV_0_FW *WINDOW_IN * CONV_0_ICH; // input size
//---------------------------CONV_1--------------------------------

#define CONV_1_STRIDE 1
#define CONV_1_ICH_PAR 1

#define CONV_1_FW 3 // filter width 
#define CONV_1_FH 3 // filter height

#define CONV_1_OCH 2 // Numero di canali output
#define CONV_1_OW ((CONV_0_OW - CONV_1_FW) / CONV_1_STRIDE + 1) // Larghezza output
#define CONV_1_OH ((CONV_0_OH - CONV_1_FH) / CONV_1_STRIDE + 1) // Altezza output

#if (CONV_0_OW % CONV_1_FW != 0)
    constexpr int WINDOW_OUT = CONV_0_OW / CONV_1_FW + 1; 
#else
    constexpr int WINDOW_OUT = CONV_0_OW / CONV_1_FW; 
#endif

#define CONV_0_OUTPUT_SIZE (CONV_0_FH * WINDOW_OUT * CONV_0_FW * WINDOW_OUT * CONV_0_OCH) // output size

//---------------------------CONV_2--------------------------------
#define CONV_2_STRIDE 1
#define CONV_2_ICH_PAR 1
#define CONV_2_FW 1 // filter width 
#define CONV_2_FH 1 // filter height

#define CONV_2_OCH 2 // input channels
#define CONV_2_OW ((CONV_1_OW - CONV_2_FW) / CONV_2_STRIDE + 1) // output width
#define CONV_2_OH ((CONV_1_OH - CONV_2_FH) / CONV_2_STRIDE + 1) // output height

#if (CONV_1_OW % CONV_2_FW != 0)
    #define WINDOW_OUT_2 (CONV_1_OW / CONV_2_FW + 1)
#else
    #define WINDOW_OUT_2 (CONV_1_OW / CONV_2_FW)
#endif

#define CONV_1_OUTPUT_SIZE (CONV_1_FH * WINDOW_OUT * CONV_1_FW * WINDOW_OUT * CONV_1_OCH) // output size
constexpr int CONV_2_OUTPUT_SIZE = CONV_2_OH * CONV_2_OW * CONV_2_OCH; // output size

//-----------------------------FILTER STREAM--------------------------------------
using filter_stream_t = hls::stream<ap_int<8>>;

//---------------------------MEMORY IN AND OUT OF TOP_WRAPPER----------------------------------

// typedef ap_int<45> memory_in_t[CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR][(CONV_0_ICH * (WINDOW_IN * CONV_0_FW) * (WINDOW_IN * CONV_0_FH)) / (CONV_0_FW * CONV_0_FH * CONV_0_ICH_PAR)];
// typedef ap_int<45> memory_out_t[CONV_1_OH][CONV_1_OW][CONV_1_OCH];
typedef ap_int<45> memory_in_t;
typedef ap_int<45> memory_out_t;

//--------------------------MEMORY IN AND OUT OF CONVOLUTION LAYER------------------------------
template<int FW, int FH, int ICH_PAR, int ICH, int WINDOW_IN>
using memory_in_conv_t = ap_int<45>[FW * FH * ICH_PAR][(ICH * FW * FH * WINDOW_IN * WINDOW_IN) / (FW * FH * ICH_PAR)];

template<int FW_OUT, int FH_OUT, int ICH_PAR_OUT, int OCH, int WINDOW_OUT>
using memory_out_conv_t = ap_int<45>[FW_OUT * FH_OUT * ICH_PAR_OUT][(OCH * FW_OUT * FH_OUT * WINDOW_OUT * WINDOW_OUT) / (FW_OUT * FH_OUT * ICH_PAR_OUT)];

//--------------------------NUMBER OF IMAGES--------------------------------
//constexpr int NR_IMG = 5;

#endif // PARAMETER_H