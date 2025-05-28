// 0x8000 ~
// 0xffff : Memory 'memory_in' (2250 * 45b)
//          Word 2n   : bit [31:0] - memory_in[n][31: 0]
//          Word 2n+1 : bit [12:0] - memory_in[n][44:32]
//                      others     - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define GMEM3_ADDR_MEMORY_IN_BASE 0x8000
#define GMEM3_ADDR_MEMORY_IN_HIGH 0xffff
#define GMEM3_WIDTH_MEMORY_IN     45
#define GMEM3_DEPTH_MEMORY_IN     2250
