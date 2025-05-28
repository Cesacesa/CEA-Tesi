// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xtop_wrapper.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XTop_wrapper_CfgInitialize(XTop_wrapper *InstancePtr, XTop_wrapper_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_r_BaseAddress = ConfigPtr->Control_r_BaseAddress;
    InstancePtr->Gmem3_BaseAddress = ConfigPtr->Gmem3_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XTop_wrapper_Start(XTop_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL) & 0x80;
    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XTop_wrapper_IsDone(XTop_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XTop_wrapper_IsIdle(XTop_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XTop_wrapper_IsReady(XTop_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XTop_wrapper_EnableAutoRestart(XTop_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XTop_wrapper_DisableAutoRestart(XTop_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_AP_CTRL, 0);
}

void XTop_wrapper_Set_filter_val(XTop_wrapper *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_FILTER_VAL_DATA, (u32)(Data));
    XTop_wrapper_WriteReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_FILTER_VAL_DATA + 4, (u32)(Data >> 32));
}

u64 XTop_wrapper_Get_filter_val(XTop_wrapper *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_FILTER_VAL_DATA);
    Data += (u64)XTop_wrapper_ReadReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_FILTER_VAL_DATA + 4) << 32;
    return Data;
}

void XTop_wrapper_Set_memory(XTop_wrapper *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_MEMORY_DATA, (u32)(Data));
    XTop_wrapper_WriteReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_MEMORY_DATA + 4, (u32)(Data >> 32));
}

u64 XTop_wrapper_Get_memory(XTop_wrapper *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTop_wrapper_ReadReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_MEMORY_DATA);
    Data += (u64)XTop_wrapper_ReadReg(InstancePtr->Control_r_BaseAddress, XTOP_WRAPPER_CONTROL_R_ADDR_MEMORY_DATA + 4) << 32;
    return Data;
}

u32 XTop_wrapper_Get_memory_in_BaseAddress(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE);
}

u32 XTop_wrapper_Get_memory_in_HighAddress(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH);
}

u32 XTop_wrapper_Get_memory_in_TotalBytes(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH - XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + 1);
}

u32 XTop_wrapper_Get_memory_in_BitWidth(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOP_WRAPPER_GMEM3_WIDTH_MEMORY_IN;
}

u32 XTop_wrapper_Get_memory_in_Depth(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOP_WRAPPER_GMEM3_DEPTH_MEMORY_IN;
}

u32 XTop_wrapper_Write_memory_in_Words(XTop_wrapper *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH - XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XTop_wrapper_Read_memory_in_Words(XTop_wrapper *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH - XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + (offset + i)*4);
    }
    return length;
}

u32 XTop_wrapper_Write_memory_in_Bytes(XTop_wrapper *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH - XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XTop_wrapper_Read_memory_in_Bytes(XTop_wrapper *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_HIGH - XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Gmem3_BaseAddress + XTOP_WRAPPER_GMEM3_ADDR_MEMORY_IN_BASE + offset + i);
    }
    return length;
}

void XTop_wrapper_InterruptGlobalEnable(XTop_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_GIE, 1);
}

void XTop_wrapper_InterruptGlobalDisable(XTop_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_GIE, 0);
}

void XTop_wrapper_InterruptEnable(XTop_wrapper *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_IER);
    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_IER, Register | Mask);
}

void XTop_wrapper_InterruptDisable(XTop_wrapper *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_IER);
    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_IER, Register & (~Mask));
}

void XTop_wrapper_InterruptClear(XTop_wrapper *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTop_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_ISR, Mask);
}

u32 XTop_wrapper_InterruptGetEnabled(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_IER);
}

u32 XTop_wrapper_InterruptGetStatus(XTop_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTop_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XTOP_WRAPPER_CONTROL_ADDR_ISR);
}

