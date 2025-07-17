#ifndef PARAMETERS_DQ_H
#define PARAMETERS_DQ_H
#include "parameter.h"
//data types dimensions
#define BIT_INPUT 32
#define BIT_QUANT 8

//quantization parameters
#define SHIFT_FACTOR_ACTIVATION 7
#define SHIFT_FACTOR_WEIGHTS 9
#define SHIFT_FACTOR_QUANT 7
#define SHIFT_FACTOR_TOT (SHIFT_FACTOR_ACTIVATION+SHIFT_FACTOR_WEIGHTS-SHIFT_FACTOR_QUANT)

#define zero_point 0

#define TOLERANCE 0//(1<<SHIFT_FACTOR_TOT)-1






//data matrix dimensions
#define HEIGHT CONV_1_FW * CONV_1_FH * CONV_1_ICH_PAR
#define WIDTH (CONV_1_OCH *CONV_1_FW * CONV_1_FH * WINDOW_OUT * WINDOW_OUT) / (CONV_1_ICH_PAR *CONV_1_FW * CONV_1_FH)

#endif // PARAMETERS_DQ_H   