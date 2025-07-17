#ifndef DEQUANT_AND_QUANT
#define DEQUANT_AND_QUANT

#include "parameters_dq.h"
#include <hls_math.h>
#include <ap_int.h>

#ifndef __SYNTHESIS__
#include <fstream>
#endif

inline ap_uint<BIT_QUANT> deq_and_quant(ap_uint<BIT_INPUT> input) {
ap_uint<BIT_QUANT> output;
#ifndef __SYNTHESIS__
    static std::ofstream debug_file("debugging_quant.txt", std::ios::app); // apertura in append
#endif

    //SCALING
    ap_uint<SHIFT_FACTOR_TOT> decimal_part= input.range(SHIFT_FACTOR_TOT-1,0);
    ap_uint<BIT_INPUT-SHIFT_FACTOR_TOT> temp=input.range(BIT_INPUT-1,SHIFT_FACTOR_TOT);

    
#ifndef __SYNTHESIS__
    debug_file <<"-----------------------------\n";
    debug_file << "Input: " << input << "\n";
    debug_file << "Decimal part (fraction bits): " << decimal_part << "\n";
    debug_file << "Integer part before rounding: " << temp << "\n";
#endif

    //ROUNDING, with nearest even to solve ties
    if (decimal_part > (1 << (SHIFT_FACTOR_TOT-1))) {
    temp++;
}
    else if (decimal_part == (1 << (SHIFT_FACTOR_TOT-1)) && temp[0] == 1) {
    temp++;
}

#ifndef __SYNTHESIS__
    debug_file << "Temp (after rounding): " << temp << "\n";
   
#endif


    //SATURATION
    ap_uint<BIT_QUANT> max_value=~0;
#ifndef __SYNTHESIS__
    debug_file << "max_value " << max_value << "\n";
   
#endif
    //output=0;
    if (temp>max_value) {
        return output=max_value;
    }
    else if (temp<0) {
        return output=0;
    }
    else {
        return output=temp;
    }
    #ifndef __SYNTHESIS__
    debug_file << "output: " << output << "\n";
    debug_file <<"-----------------------------\n";
   
#endif

}

#endif
