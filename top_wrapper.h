#ifndef TOP_WRAPPER_H
#define TOP_WRAPPER_H

#include "conv.h"

void top_wrapper(memory_in_t input[NR_IMG], const int* filter_val, const int* filter_val_2, memory_out_t memory[NR_IMG]);


#endif // TOP_WRAPPER_H