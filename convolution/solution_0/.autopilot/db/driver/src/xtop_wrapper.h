// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XTOP_WRAPPER_H
#define XTOP_WRAPPER_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xtop_wrapper_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
    u64 Gmem3_BaseAddress;
} XTop_wrapper_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
    u64 Gmem3_BaseAddress;
    u32 IsReady;
} XTop_wrapper;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XTop_wrapper_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XTop_wrapper_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XTop_wrapper_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XTop_wrapper_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XTop_wrapper_Initialize(XTop_wrapper *InstancePtr, UINTPTR BaseAddress);
XTop_wrapper_Config* XTop_wrapper_LookupConfig(UINTPTR BaseAddress);
#else
int XTop_wrapper_Initialize(XTop_wrapper *InstancePtr, u16 DeviceId);
XTop_wrapper_Config* XTop_wrapper_LookupConfig(u16 DeviceId);
#endif
int XTop_wrapper_CfgInitialize(XTop_wrapper *InstancePtr, XTop_wrapper_Config *ConfigPtr);
#else
int XTop_wrapper_Initialize(XTop_wrapper *InstancePtr, const char* InstanceName);
int XTop_wrapper_Release(XTop_wrapper *InstancePtr);
#endif

void XTop_wrapper_Start(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_IsDone(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_IsIdle(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_IsReady(XTop_wrapper *InstancePtr);
void XTop_wrapper_EnableAutoRestart(XTop_wrapper *InstancePtr);
void XTop_wrapper_DisableAutoRestart(XTop_wrapper *InstancePtr);

void XTop_wrapper_Set_filter_val(XTop_wrapper *InstancePtr, u64 Data);
u64 XTop_wrapper_Get_filter_val(XTop_wrapper *InstancePtr);
void XTop_wrapper_Set_memory(XTop_wrapper *InstancePtr, u64 Data);
u64 XTop_wrapper_Get_memory(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Get_memory_in_BaseAddress(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Get_memory_in_HighAddress(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Get_memory_in_TotalBytes(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Get_memory_in_BitWidth(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Get_memory_in_Depth(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_Write_memory_in_Words(XTop_wrapper *InstancePtr, int offset, word_type *data, int length);
u32 XTop_wrapper_Read_memory_in_Words(XTop_wrapper *InstancePtr, int offset, word_type *data, int length);
u32 XTop_wrapper_Write_memory_in_Bytes(XTop_wrapper *InstancePtr, int offset, char *data, int length);
u32 XTop_wrapper_Read_memory_in_Bytes(XTop_wrapper *InstancePtr, int offset, char *data, int length);

void XTop_wrapper_InterruptGlobalEnable(XTop_wrapper *InstancePtr);
void XTop_wrapper_InterruptGlobalDisable(XTop_wrapper *InstancePtr);
void XTop_wrapper_InterruptEnable(XTop_wrapper *InstancePtr, u32 Mask);
void XTop_wrapper_InterruptDisable(XTop_wrapper *InstancePtr, u32 Mask);
void XTop_wrapper_InterruptClear(XTop_wrapper *InstancePtr, u32 Mask);
u32 XTop_wrapper_InterruptGetEnabled(XTop_wrapper *InstancePtr);
u32 XTop_wrapper_InterruptGetStatus(XTop_wrapper *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
