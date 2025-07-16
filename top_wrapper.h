#ifndef TOP_WRAPPER_H
#define TOP_WRAPPER_H

#include "conv.h"

void top_wrapper(hls::stream<mem_in_t>  &memory_in_stream,
                 filter_stream_t        &filter_val_stream,
                //  filter_stream_t        &filter_val_2_stream,
                 hls::stream<mem_out_t> &memory_out_stream);


#endif // TOP_WRAPPER_H