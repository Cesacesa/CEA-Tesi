# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
# Tool Version Limit: 2024.11
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
# 
# ==============================================================
proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "XTop_wrapper" \
        "NUM_INSTANCES" \
        "DEVICE_ID" \
        "C_S_AXI_CONTROL_BASEADDR" \
        "C_S_AXI_CONTROL_HIGHADDR" \
        "C_S_AXI_CONTROL_R_BASEADDR" \
        "C_S_AXI_CONTROL_R_HIGHADDR" \
        "C_S_AXI_GMEM3_BASEADDR" \
        "C_S_AXI_GMEM3_HIGHADDR"

    xdefine_config_file $drv_handle "xtop_wrapper_g.c" "XTop_wrapper" \
        "DEVICE_ID" \
        "C_S_AXI_CONTROL_BASEADDR" \
        "C_S_AXI_CONTROL_R_BASEADDR" \
        "C_S_AXI_GMEM3_BASEADDR"

    xdefine_canonical_xpars $drv_handle "xparameters.h" "XTop_wrapper" \
        "DEVICE_ID" \
        "C_S_AXI_CONTROL_BASEADDR" \
        "C_S_AXI_CONTROL_HIGHADDR" \
        "C_S_AXI_CONTROL_R_BASEADDR" \
        "C_S_AXI_CONTROL_R_HIGHADDR" \
        "C_S_AXI_GMEM3_BASEADDR" \
        "C_S_AXI_GMEM3_HIGHADDR"
}

