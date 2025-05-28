# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler top_wrapper_sparsemux_51_5_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2009 \
    name mul_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mul_i \
    op interface \
    ports { mul_i { I 5 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2010 \
    name zext_ln40 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_zext_ln40 \
    op interface \
    ports { zext_ln40 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2011 \
    name cmp31_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cmp31_i \
    op interface \
    ports { cmp31_i { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2012 \
    name mul_ln40 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mul_ln40 \
    op interface \
    ports { mul_ln40 { I 37 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2013 \
    name p_cast_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_cast_i \
    op interface \
    ports { p_cast_i { I 13 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2014 \
    name memory_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_memory_load \
    op interface \
    ports { memory_load { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2015 \
    name gmem1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_gmem1 \
    op interface \
    ports { m_axi_gmem1_0_AWVALID { O 1 bit } m_axi_gmem1_0_AWREADY { I 1 bit } m_axi_gmem1_0_AWADDR { O 64 vector } m_axi_gmem1_0_AWID { O 1 vector } m_axi_gmem1_0_AWLEN { O 32 vector } m_axi_gmem1_0_AWSIZE { O 3 vector } m_axi_gmem1_0_AWBURST { O 2 vector } m_axi_gmem1_0_AWLOCK { O 2 vector } m_axi_gmem1_0_AWCACHE { O 4 vector } m_axi_gmem1_0_AWPROT { O 3 vector } m_axi_gmem1_0_AWQOS { O 4 vector } m_axi_gmem1_0_AWREGION { O 4 vector } m_axi_gmem1_0_AWUSER { O 1 vector } m_axi_gmem1_0_WVALID { O 1 bit } m_axi_gmem1_0_WREADY { I 1 bit } m_axi_gmem1_0_WDATA { O 64 vector } m_axi_gmem1_0_WSTRB { O 8 vector } m_axi_gmem1_0_WLAST { O 1 bit } m_axi_gmem1_0_WID { O 1 vector } m_axi_gmem1_0_WUSER { O 1 vector } m_axi_gmem1_0_ARVALID { O 1 bit } m_axi_gmem1_0_ARREADY { I 1 bit } m_axi_gmem1_0_ARADDR { O 64 vector } m_axi_gmem1_0_ARID { O 1 vector } m_axi_gmem1_0_ARLEN { O 32 vector } m_axi_gmem1_0_ARSIZE { O 3 vector } m_axi_gmem1_0_ARBURST { O 2 vector } m_axi_gmem1_0_ARLOCK { O 2 vector } m_axi_gmem1_0_ARCACHE { O 4 vector } m_axi_gmem1_0_ARPROT { O 3 vector } m_axi_gmem1_0_ARQOS { O 4 vector } m_axi_gmem1_0_ARREGION { O 4 vector } m_axi_gmem1_0_ARUSER { O 1 vector } m_axi_gmem1_0_RVALID { I 1 bit } m_axi_gmem1_0_RREADY { O 1 bit } m_axi_gmem1_0_RDATA { I 64 vector } m_axi_gmem1_0_RLAST { I 1 bit } m_axi_gmem1_0_RID { I 1 vector } m_axi_gmem1_0_RFIFONUM { I 9 vector } m_axi_gmem1_0_RUSER { I 1 vector } m_axi_gmem1_0_RRESP { I 2 vector } m_axi_gmem1_0_BVALID { I 1 bit } m_axi_gmem1_0_BREADY { O 1 bit } m_axi_gmem1_0_BRESP { I 2 vector } m_axi_gmem1_0_BID { I 1 vector } m_axi_gmem1_0_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2016 \
    name tmp_i_23 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_i_23 \
    op interface \
    ports { tmp_i_23 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2017 \
    name tmp_1_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_1_i \
    op interface \
    ports { tmp_1_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2018 \
    name tmp_2_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_2_i \
    op interface \
    ports { tmp_2_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2019 \
    name tmp_3_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_3_i \
    op interface \
    ports { tmp_3_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2020 \
    name tmp_4_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_4_i \
    op interface \
    ports { tmp_4_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2021 \
    name tmp_5_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_5_i \
    op interface \
    ports { tmp_5_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2022 \
    name tmp_6_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_6_i \
    op interface \
    ports { tmp_6_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2023 \
    name tmp_7_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_7_i \
    op interface \
    ports { tmp_7_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2024 \
    name tmp_8_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_8_i \
    op interface \
    ports { tmp_8_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2025 \
    name tmp_9_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_9_i \
    op interface \
    ports { tmp_9_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2026 \
    name tmp_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_i \
    op interface \
    ports { tmp_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2027 \
    name tmp_10_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_10_i \
    op interface \
    ports { tmp_10_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2028 \
    name tmp_11_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_11_i \
    op interface \
    ports { tmp_11_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2029 \
    name tmp_12_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_12_i \
    op interface \
    ports { tmp_12_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2030 \
    name tmp_13_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_13_i \
    op interface \
    ports { tmp_13_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2031 \
    name tmp_14_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_14_i \
    op interface \
    ports { tmp_14_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2032 \
    name tmp_15_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_15_i \
    op interface \
    ports { tmp_15_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2033 \
    name tmp_16_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_16_i \
    op interface \
    ports { tmp_16_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2034 \
    name tmp_17_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_17_i \
    op interface \
    ports { tmp_17_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2035 \
    name tmp_18_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_18_i \
    op interface \
    ports { tmp_18_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2036 \
    name tmp_19_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_19_i \
    op interface \
    ports { tmp_19_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2037 \
    name tmp_20_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_20_i \
    op interface \
    ports { tmp_20_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2038 \
    name tmp_21_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_21_i \
    op interface \
    ports { tmp_21_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2039 \
    name tmp_22_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_22_i \
    op interface \
    ports { tmp_22_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2040 \
    name tmp_23_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_23_i \
    op interface \
    ports { tmp_23_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2041 \
    name tmp_24_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_24_i \
    op interface \
    ports { tmp_24_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2042 \
    name tmp_25_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_25_i \
    op interface \
    ports { tmp_25_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2043 \
    name tmp_26_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_26_i \
    op interface \
    ports { tmp_26_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2044 \
    name tmp_27_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_27_i \
    op interface \
    ports { tmp_27_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2045 \
    name tmp_28_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_28_i \
    op interface \
    ports { tmp_28_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2046 \
    name tmp_29_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_29_i \
    op interface \
    ports { tmp_29_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2047 \
    name tmp_30_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_30_i \
    op interface \
    ports { tmp_30_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2048 \
    name tmp_31_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_31_i \
    op interface \
    ports { tmp_31_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2049 \
    name tmp_32_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_32_i \
    op interface \
    ports { tmp_32_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2050 \
    name tmp_33_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_33_i \
    op interface \
    ports { tmp_33_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2051 \
    name tmp_34_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_34_i \
    op interface \
    ports { tmp_34_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2052 \
    name tmp_35_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_35_i \
    op interface \
    ports { tmp_35_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2053 \
    name tmp_36_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_36_i \
    op interface \
    ports { tmp_36_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2054 \
    name tmp_37_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_37_i \
    op interface \
    ports { tmp_37_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2055 \
    name tmp_38_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_38_i \
    op interface \
    ports { tmp_38_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2056 \
    name tmp_39_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_39_i \
    op interface \
    ports { tmp_39_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2057 \
    name tmp_40_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_40_i \
    op interface \
    ports { tmp_40_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2058 \
    name tmp_41_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_41_i \
    op interface \
    ports { tmp_41_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2059 \
    name tmp_42_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_42_i \
    op interface \
    ports { tmp_42_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2060 \
    name tmp_43_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_43_i \
    op interface \
    ports { tmp_43_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2061 \
    name tmp_44_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_44_i \
    op interface \
    ports { tmp_44_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2062 \
    name tmp_45_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_45_i \
    op interface \
    ports { tmp_45_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2063 \
    name tmp_46_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_46_i \
    op interface \
    ports { tmp_46_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2064 \
    name tmp_47_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_47_i \
    op interface \
    ports { tmp_47_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2065 \
    name tmp_48_i \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_tmp_48_i \
    op interface \
    ports { tmp_48_i { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2066 \
    name s_iw \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_s_iw \
    op interface \
    ports { s_iw { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName top_wrapper_flow_control_loop_pipe_sequential_init_U
set CompName top_wrapper_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix top_wrapper_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


