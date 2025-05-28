// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xtop_wrapper.h"

extern XTop_wrapper_Config XTop_wrapper_ConfigTable[];

#ifdef SDT
XTop_wrapper_Config *XTop_wrapper_LookupConfig(UINTPTR BaseAddress) {
	XTop_wrapper_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XTop_wrapper_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XTop_wrapper_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XTop_wrapper_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTop_wrapper_Initialize(XTop_wrapper *InstancePtr, UINTPTR BaseAddress) {
	XTop_wrapper_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTop_wrapper_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTop_wrapper_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XTop_wrapper_Config *XTop_wrapper_LookupConfig(u16 DeviceId) {
	XTop_wrapper_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XTOP_WRAPPER_NUM_INSTANCES; Index++) {
		if (XTop_wrapper_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XTop_wrapper_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTop_wrapper_Initialize(XTop_wrapper *InstancePtr, u16 DeviceId) {
	XTop_wrapper_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTop_wrapper_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTop_wrapper_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

