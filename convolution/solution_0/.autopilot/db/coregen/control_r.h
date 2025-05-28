// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of filter_val
//        bit 31~0 - filter_val[31:0] (Read/Write)
// 0x14 : Data signal of filter_val
//        bit 31~0 - filter_val[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of memory
//        bit 31~0 - memory[31:0] (Read/Write)
// 0x20 : Data signal of memory
//        bit 31~0 - memory[63:32] (Read/Write)
// 0x24 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define CONTROL_R_ADDR_FILTER_VAL_DATA 0x10
#define CONTROL_R_BITS_FILTER_VAL_DATA 64
#define CONTROL_R_ADDR_MEMORY_DATA     0x1c
#define CONTROL_R_BITS_MEMORY_DATA     64
