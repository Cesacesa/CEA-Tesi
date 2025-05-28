// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x0 : Control signals
//       bit 0  - ap_start (Read/Write/COH)
//       bit 1  - ap_done (Read/COR)
//       bit 2  - ap_idle (Read)
//       bit 3  - ap_ready (Read/COR)
//       bit 7  - auto_restart (Read/Write)
//       bit 9  - interrupt (Read)
//       others - reserved
// 0x4 : Global Interrupt Enable Register
//       bit 0  - Global Interrupt Enable (Read/Write)
//       others - reserved
// 0x8 : IP Interrupt Enable Register (Read/Write)
//       bit 0 - enable ap_done interrupt (Read/Write)
//       bit 1 - enable ap_ready interrupt (Read/Write)
//       others - reserved
// 0xc : IP Interrupt Status Register (Read/TOW)
//       bit 0 - ap_done (Read/TOW)
//       bit 1 - ap_ready (Read/TOW)
//       others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL 0x0
#define XTOP_WRAPPER_CONTROL_ADDR_GIE     0x4
#define XTOP_WRAPPER_CONTROL_ADDR_IER     0x8
#define XTOP_WRAPPER_CONTROL_ADDR_ISR     0xc

// control_r
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

#define XTOP_WRAPPER_CONTROL_R_ADDR_FILTER_VAL_DATA 0x10
#define XTOP_WRAPPER_CONTROL_R_BITS_FILTER_VAL_DATA 64
#define XTOP_WRAPPER_CONTROL_R_ADDR_MEMORY_DATA     0x1c
#define XTOP_WRAPPER_CONTROL_R_BITS_MEMORY_DATA     64

// gmem3
// 0x8000 ~
// 0xffff : Memory 'memory_in' (2250 * 45b)
//          Word 2n   : bit [31:0] - memory_in[n][31: 0]
//          Word 2n+1 : bit [12:0] - memory_in[n][44:32]
//                      others     - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE 0x8000
#define XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH 0xffff
#define XTOP_WRAPPER_GMEM3_WIDTH_MEMORY_IN     45
#define XTOP_WRAPPER_GMEM3_DEPTH_MEMORY_IN     2250

