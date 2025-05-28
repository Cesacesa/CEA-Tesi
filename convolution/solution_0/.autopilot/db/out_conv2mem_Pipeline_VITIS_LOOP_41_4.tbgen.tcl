set moduleName out_conv2mem_Pipeline_VITIS_LOOP_41_4
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 13
set C_modelName {out_conv2mem_Pipeline_VITIS_LOOP_41_4}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ mul_i int 5 regular  }
	{ zext_ln40 int 4 regular  }
	{ cmp31_i int 1 regular  }
	{ mul_ln40 int 37 regular  }
	{ p_cast_i int 13 regular  }
	{ memory_load int 64 regular  }
	{ gmem1 int 64 regular {axi_master 1}  }
	{ tmp_i_23 int 32 regular  }
	{ tmp_1_i int 32 regular  }
	{ tmp_2_i int 32 regular  }
	{ tmp_3_i int 32 regular  }
	{ tmp_4_i int 32 regular  }
	{ tmp_5_i int 32 regular  }
	{ tmp_6_i int 32 regular  }
	{ tmp_7_i int 32 regular  }
	{ tmp_8_i int 32 regular  }
	{ tmp_9_i int 32 regular  }
	{ tmp_i int 32 regular  }
	{ tmp_10_i int 32 regular  }
	{ tmp_11_i int 32 regular  }
	{ tmp_12_i int 32 regular  }
	{ tmp_13_i int 32 regular  }
	{ tmp_14_i int 32 regular  }
	{ tmp_15_i int 32 regular  }
	{ tmp_16_i int 32 regular  }
	{ tmp_17_i int 32 regular  }
	{ tmp_18_i int 32 regular  }
	{ tmp_19_i int 32 regular  }
	{ tmp_20_i int 32 regular  }
	{ tmp_21_i int 32 regular  }
	{ tmp_22_i int 32 regular  }
	{ tmp_23_i int 32 regular  }
	{ tmp_24_i int 32 regular  }
	{ tmp_25_i int 32 regular  }
	{ tmp_26_i int 32 regular  }
	{ tmp_27_i int 32 regular  }
	{ tmp_28_i int 32 regular  }
	{ tmp_29_i int 32 regular  }
	{ tmp_30_i int 32 regular  }
	{ tmp_31_i int 32 regular  }
	{ tmp_32_i int 32 regular  }
	{ tmp_33_i int 32 regular  }
	{ tmp_34_i int 32 regular  }
	{ tmp_35_i int 32 regular  }
	{ tmp_36_i int 32 regular  }
	{ tmp_37_i int 32 regular  }
	{ tmp_38_i int 32 regular  }
	{ tmp_39_i int 32 regular  }
	{ tmp_40_i int 32 regular  }
	{ tmp_41_i int 32 regular  }
	{ tmp_42_i int 32 regular  }
	{ tmp_43_i int 32 regular  }
	{ tmp_44_i int 32 regular  }
	{ tmp_45_i int 32 regular  }
	{ tmp_46_i int 32 regular  }
	{ tmp_47_i int 32 regular  }
	{ tmp_48_i int 32 regular  }
	{ s_iw int 4 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "mul_i", "interface" : "wire", "bitwidth" : 5, "direction" : "READONLY"} , 
 	{ "Name" : "zext_ln40", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "cmp31_i", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "mul_ln40", "interface" : "wire", "bitwidth" : 37, "direction" : "READONLY"} , 
 	{ "Name" : "p_cast_i", "interface" : "wire", "bitwidth" : 13, "direction" : "READONLY"} , 
 	{ "Name" : "memory_load", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "gmem1", "interface" : "axi_master", "bitwidth" : 64, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "memory","offset": { "type": "dynamic","port_name": "memory","bundle": "control_r"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "tmp_i_23", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_1_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_2_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_3_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_4_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_5_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_6_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_7_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_8_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_9_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_10_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_11_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_12_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_13_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_14_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_15_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_16_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_17_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_18_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_19_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_20_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_21_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_22_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_23_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_24_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_25_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_26_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_27_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_28_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_29_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_30_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_31_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_32_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_33_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_34_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_35_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_36_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_37_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_38_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_39_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_40_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_41_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_42_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_43_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_44_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_45_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_46_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_47_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "tmp_48_i", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "s_iw", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 109
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ m_axi_gmem1_0_AWVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_AWREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_AWADDR sc_out sc_lv 64 signal 6 } 
	{ m_axi_gmem1_0_AWID sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_AWLEN sc_out sc_lv 32 signal 6 } 
	{ m_axi_gmem1_0_AWSIZE sc_out sc_lv 3 signal 6 } 
	{ m_axi_gmem1_0_AWBURST sc_out sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_AWLOCK sc_out sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_AWCACHE sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_AWPROT sc_out sc_lv 3 signal 6 } 
	{ m_axi_gmem1_0_AWQOS sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_AWREGION sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_AWUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_WVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_WREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_WDATA sc_out sc_lv 64 signal 6 } 
	{ m_axi_gmem1_0_WSTRB sc_out sc_lv 8 signal 6 } 
	{ m_axi_gmem1_0_WLAST sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_WID sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_WUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_ARVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_ARREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_ARADDR sc_out sc_lv 64 signal 6 } 
	{ m_axi_gmem1_0_ARID sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_ARLEN sc_out sc_lv 32 signal 6 } 
	{ m_axi_gmem1_0_ARSIZE sc_out sc_lv 3 signal 6 } 
	{ m_axi_gmem1_0_ARBURST sc_out sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_ARLOCK sc_out sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_ARCACHE sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_ARPROT sc_out sc_lv 3 signal 6 } 
	{ m_axi_gmem1_0_ARQOS sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_ARREGION sc_out sc_lv 4 signal 6 } 
	{ m_axi_gmem1_0_ARUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_RVALID sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_RREADY sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_RDATA sc_in sc_lv 64 signal 6 } 
	{ m_axi_gmem1_0_RLAST sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_RID sc_in sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_RFIFONUM sc_in sc_lv 9 signal 6 } 
	{ m_axi_gmem1_0_RUSER sc_in sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_RRESP sc_in sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_BVALID sc_in sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_BREADY sc_out sc_logic 1 signal 6 } 
	{ m_axi_gmem1_0_BRESP sc_in sc_lv 2 signal 6 } 
	{ m_axi_gmem1_0_BID sc_in sc_lv 1 signal 6 } 
	{ m_axi_gmem1_0_BUSER sc_in sc_lv 1 signal 6 } 
	{ mul_i sc_in sc_lv 5 signal 0 } 
	{ zext_ln40 sc_in sc_lv 4 signal 1 } 
	{ cmp31_i sc_in sc_lv 1 signal 2 } 
	{ mul_ln40 sc_in sc_lv 37 signal 3 } 
	{ p_cast_i sc_in sc_lv 13 signal 4 } 
	{ memory_load sc_in sc_lv 64 signal 5 } 
	{ tmp_i_23 sc_in sc_lv 32 signal 7 } 
	{ tmp_1_i sc_in sc_lv 32 signal 8 } 
	{ tmp_2_i sc_in sc_lv 32 signal 9 } 
	{ tmp_3_i sc_in sc_lv 32 signal 10 } 
	{ tmp_4_i sc_in sc_lv 32 signal 11 } 
	{ tmp_5_i sc_in sc_lv 32 signal 12 } 
	{ tmp_6_i sc_in sc_lv 32 signal 13 } 
	{ tmp_7_i sc_in sc_lv 32 signal 14 } 
	{ tmp_8_i sc_in sc_lv 32 signal 15 } 
	{ tmp_9_i sc_in sc_lv 32 signal 16 } 
	{ tmp_i sc_in sc_lv 32 signal 17 } 
	{ tmp_10_i sc_in sc_lv 32 signal 18 } 
	{ tmp_11_i sc_in sc_lv 32 signal 19 } 
	{ tmp_12_i sc_in sc_lv 32 signal 20 } 
	{ tmp_13_i sc_in sc_lv 32 signal 21 } 
	{ tmp_14_i sc_in sc_lv 32 signal 22 } 
	{ tmp_15_i sc_in sc_lv 32 signal 23 } 
	{ tmp_16_i sc_in sc_lv 32 signal 24 } 
	{ tmp_17_i sc_in sc_lv 32 signal 25 } 
	{ tmp_18_i sc_in sc_lv 32 signal 26 } 
	{ tmp_19_i sc_in sc_lv 32 signal 27 } 
	{ tmp_20_i sc_in sc_lv 32 signal 28 } 
	{ tmp_21_i sc_in sc_lv 32 signal 29 } 
	{ tmp_22_i sc_in sc_lv 32 signal 30 } 
	{ tmp_23_i sc_in sc_lv 32 signal 31 } 
	{ tmp_24_i sc_in sc_lv 32 signal 32 } 
	{ tmp_25_i sc_in sc_lv 32 signal 33 } 
	{ tmp_26_i sc_in sc_lv 32 signal 34 } 
	{ tmp_27_i sc_in sc_lv 32 signal 35 } 
	{ tmp_28_i sc_in sc_lv 32 signal 36 } 
	{ tmp_29_i sc_in sc_lv 32 signal 37 } 
	{ tmp_30_i sc_in sc_lv 32 signal 38 } 
	{ tmp_31_i sc_in sc_lv 32 signal 39 } 
	{ tmp_32_i sc_in sc_lv 32 signal 40 } 
	{ tmp_33_i sc_in sc_lv 32 signal 41 } 
	{ tmp_34_i sc_in sc_lv 32 signal 42 } 
	{ tmp_35_i sc_in sc_lv 32 signal 43 } 
	{ tmp_36_i sc_in sc_lv 32 signal 44 } 
	{ tmp_37_i sc_in sc_lv 32 signal 45 } 
	{ tmp_38_i sc_in sc_lv 32 signal 46 } 
	{ tmp_39_i sc_in sc_lv 32 signal 47 } 
	{ tmp_40_i sc_in sc_lv 32 signal 48 } 
	{ tmp_41_i sc_in sc_lv 32 signal 49 } 
	{ tmp_42_i sc_in sc_lv 32 signal 50 } 
	{ tmp_43_i sc_in sc_lv 32 signal 51 } 
	{ tmp_44_i sc_in sc_lv 32 signal 52 } 
	{ tmp_45_i sc_in sc_lv 32 signal 53 } 
	{ tmp_46_i sc_in sc_lv 32 signal 54 } 
	{ tmp_47_i sc_in sc_lv 32 signal 55 } 
	{ tmp_48_i sc_in sc_lv 32 signal 56 } 
	{ s_iw sc_in sc_lv 4 signal 57 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "m_axi_gmem1_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem1_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem1_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem1_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem1_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem1_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem1_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem1_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem1_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem1_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem1_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem1_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem1_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem1_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem1_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem1_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem1_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem1_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem1_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem1_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem1_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem1_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem1_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem1_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem1_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem1_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem1_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem1_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem1_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem1_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem1_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem1_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem1_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem1_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem1_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem1_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem1_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem1_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem1_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem1_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem1_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem1_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem1_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem1_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem1_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem1_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BUSER" }} , 
 	{ "name": "mul_i", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "mul_i", "role": "default" }} , 
 	{ "name": "zext_ln40", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "zext_ln40", "role": "default" }} , 
 	{ "name": "cmp31_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cmp31_i", "role": "default" }} , 
 	{ "name": "mul_ln40", "direction": "in", "datatype": "sc_lv", "bitwidth":37, "type": "signal", "bundle":{"name": "mul_ln40", "role": "default" }} , 
 	{ "name": "p_cast_i", "direction": "in", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "p_cast_i", "role": "default" }} , 
 	{ "name": "memory_load", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "memory_load", "role": "default" }} , 
 	{ "name": "tmp_i_23", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_i_23", "role": "default" }} , 
 	{ "name": "tmp_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_1_i", "role": "default" }} , 
 	{ "name": "tmp_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_2_i", "role": "default" }} , 
 	{ "name": "tmp_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_3_i", "role": "default" }} , 
 	{ "name": "tmp_4_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_4_i", "role": "default" }} , 
 	{ "name": "tmp_5_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_5_i", "role": "default" }} , 
 	{ "name": "tmp_6_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_6_i", "role": "default" }} , 
 	{ "name": "tmp_7_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_7_i", "role": "default" }} , 
 	{ "name": "tmp_8_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_8_i", "role": "default" }} , 
 	{ "name": "tmp_9_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_9_i", "role": "default" }} , 
 	{ "name": "tmp_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_i", "role": "default" }} , 
 	{ "name": "tmp_10_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_10_i", "role": "default" }} , 
 	{ "name": "tmp_11_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_11_i", "role": "default" }} , 
 	{ "name": "tmp_12_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_12_i", "role": "default" }} , 
 	{ "name": "tmp_13_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_13_i", "role": "default" }} , 
 	{ "name": "tmp_14_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_14_i", "role": "default" }} , 
 	{ "name": "tmp_15_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_15_i", "role": "default" }} , 
 	{ "name": "tmp_16_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_16_i", "role": "default" }} , 
 	{ "name": "tmp_17_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_17_i", "role": "default" }} , 
 	{ "name": "tmp_18_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_18_i", "role": "default" }} , 
 	{ "name": "tmp_19_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_19_i", "role": "default" }} , 
 	{ "name": "tmp_20_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_20_i", "role": "default" }} , 
 	{ "name": "tmp_21_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_21_i", "role": "default" }} , 
 	{ "name": "tmp_22_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_22_i", "role": "default" }} , 
 	{ "name": "tmp_23_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_23_i", "role": "default" }} , 
 	{ "name": "tmp_24_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_24_i", "role": "default" }} , 
 	{ "name": "tmp_25_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_25_i", "role": "default" }} , 
 	{ "name": "tmp_26_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_26_i", "role": "default" }} , 
 	{ "name": "tmp_27_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_27_i", "role": "default" }} , 
 	{ "name": "tmp_28_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_28_i", "role": "default" }} , 
 	{ "name": "tmp_29_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_29_i", "role": "default" }} , 
 	{ "name": "tmp_30_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_30_i", "role": "default" }} , 
 	{ "name": "tmp_31_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_31_i", "role": "default" }} , 
 	{ "name": "tmp_32_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_32_i", "role": "default" }} , 
 	{ "name": "tmp_33_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_33_i", "role": "default" }} , 
 	{ "name": "tmp_34_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_34_i", "role": "default" }} , 
 	{ "name": "tmp_35_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_35_i", "role": "default" }} , 
 	{ "name": "tmp_36_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_36_i", "role": "default" }} , 
 	{ "name": "tmp_37_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_37_i", "role": "default" }} , 
 	{ "name": "tmp_38_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_38_i", "role": "default" }} , 
 	{ "name": "tmp_39_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_39_i", "role": "default" }} , 
 	{ "name": "tmp_40_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_40_i", "role": "default" }} , 
 	{ "name": "tmp_41_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_41_i", "role": "default" }} , 
 	{ "name": "tmp_42_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_42_i", "role": "default" }} , 
 	{ "name": "tmp_43_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_43_i", "role": "default" }} , 
 	{ "name": "tmp_44_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_44_i", "role": "default" }} , 
 	{ "name": "tmp_45_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_45_i", "role": "default" }} , 
 	{ "name": "tmp_46_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_46_i", "role": "default" }} , 
 	{ "name": "tmp_47_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_47_i", "role": "default" }} , 
 	{ "name": "tmp_48_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_48_i", "role": "default" }} , 
 	{ "name": "s_iw", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "s_iw", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3"],
		"CDFG" : "out_conv2mem_Pipeline_VITIS_LOOP_41_4",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "mul_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "zext_ln40", "Type" : "None", "Direction" : "I"},
			{"Name" : "cmp31_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "mul_ln40", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_cast_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "memory_load", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem1_blk_n_B", "Type" : "RtlSignal"},
					{"Name" : "gmem1_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "gmem1_blk_n_W", "Type" : "RtlSignal"}]},
			{"Name" : "tmp_i_23", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_1_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_2_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_3_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_4_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_5_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_6_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_7_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_8_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_9_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_10_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_11_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_12_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_13_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_14_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_15_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_16_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_17_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_18_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_19_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_20_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_21_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_22_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_23_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_24_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_25_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_26_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_27_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_28_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_29_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_30_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_31_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_32_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_33_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_34_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_35_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_36_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_37_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_38_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_39_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_40_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_41_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_42_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_43_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_44_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_45_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_46_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_47_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "tmp_48_i", "Type" : "None", "Direction" : "I"},
			{"Name" : "s_iw", "Type" : "None", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_41_4", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "2", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage1", "LastStateIter" : "ap_enable_reg_pp0_iter4", "LastStateBlock" : "ap_block_pp0_stage1_subdone", "QuitState" : "ap_ST_fsm_pp0_stage1", "QuitStateIter" : "ap_enable_reg_pp0_iter4", "QuitStateBlock" : "ap_block_pp0_stage1_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_51_5_32_1_1_U2006", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_51_5_32_1_1_U2007", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	out_conv2mem_Pipeline_VITIS_LOOP_41_4 {
		mul_i {Type I LastRead 0 FirstWrite -1}
		zext_ln40 {Type I LastRead 0 FirstWrite -1}
		cmp31_i {Type I LastRead 0 FirstWrite -1}
		mul_ln40 {Type I LastRead 0 FirstWrite -1}
		p_cast_i {Type I LastRead 0 FirstWrite -1}
		memory_load {Type I LastRead 0 FirstWrite -1}
		gmem1 {Type O LastRead 5 FirstWrite 3}
		tmp_i_23 {Type I LastRead 0 FirstWrite -1}
		tmp_1_i {Type I LastRead 0 FirstWrite -1}
		tmp_2_i {Type I LastRead 0 FirstWrite -1}
		tmp_3_i {Type I LastRead 0 FirstWrite -1}
		tmp_4_i {Type I LastRead 0 FirstWrite -1}
		tmp_5_i {Type I LastRead 0 FirstWrite -1}
		tmp_6_i {Type I LastRead 0 FirstWrite -1}
		tmp_7_i {Type I LastRead 0 FirstWrite -1}
		tmp_8_i {Type I LastRead 0 FirstWrite -1}
		tmp_9_i {Type I LastRead 0 FirstWrite -1}
		tmp_i {Type I LastRead 0 FirstWrite -1}
		tmp_10_i {Type I LastRead 0 FirstWrite -1}
		tmp_11_i {Type I LastRead 0 FirstWrite -1}
		tmp_12_i {Type I LastRead 0 FirstWrite -1}
		tmp_13_i {Type I LastRead 0 FirstWrite -1}
		tmp_14_i {Type I LastRead 0 FirstWrite -1}
		tmp_15_i {Type I LastRead 0 FirstWrite -1}
		tmp_16_i {Type I LastRead 0 FirstWrite -1}
		tmp_17_i {Type I LastRead 0 FirstWrite -1}
		tmp_18_i {Type I LastRead 0 FirstWrite -1}
		tmp_19_i {Type I LastRead 0 FirstWrite -1}
		tmp_20_i {Type I LastRead 0 FirstWrite -1}
		tmp_21_i {Type I LastRead 0 FirstWrite -1}
		tmp_22_i {Type I LastRead 0 FirstWrite -1}
		tmp_23_i {Type I LastRead 0 FirstWrite -1}
		tmp_24_i {Type I LastRead 0 FirstWrite -1}
		tmp_25_i {Type I LastRead 0 FirstWrite -1}
		tmp_26_i {Type I LastRead 0 FirstWrite -1}
		tmp_27_i {Type I LastRead 0 FirstWrite -1}
		tmp_28_i {Type I LastRead 0 FirstWrite -1}
		tmp_29_i {Type I LastRead 0 FirstWrite -1}
		tmp_30_i {Type I LastRead 0 FirstWrite -1}
		tmp_31_i {Type I LastRead 0 FirstWrite -1}
		tmp_32_i {Type I LastRead 0 FirstWrite -1}
		tmp_33_i {Type I LastRead 0 FirstWrite -1}
		tmp_34_i {Type I LastRead 0 FirstWrite -1}
		tmp_35_i {Type I LastRead 0 FirstWrite -1}
		tmp_36_i {Type I LastRead 0 FirstWrite -1}
		tmp_37_i {Type I LastRead 0 FirstWrite -1}
		tmp_38_i {Type I LastRead 0 FirstWrite -1}
		tmp_39_i {Type I LastRead 0 FirstWrite -1}
		tmp_40_i {Type I LastRead 0 FirstWrite -1}
		tmp_41_i {Type I LastRead 0 FirstWrite -1}
		tmp_42_i {Type I LastRead 0 FirstWrite -1}
		tmp_43_i {Type I LastRead 0 FirstWrite -1}
		tmp_44_i {Type I LastRead 0 FirstWrite -1}
		tmp_45_i {Type I LastRead 0 FirstWrite -1}
		tmp_46_i {Type I LastRead 0 FirstWrite -1}
		tmp_47_i {Type I LastRead 0 FirstWrite -1}
		tmp_48_i {Type I LastRead 0 FirstWrite -1}
		s_iw {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	mul_i { ap_none {  { mul_i in_data 0 5 } } }
	zext_ln40 { ap_none {  { zext_ln40 in_data 0 4 } } }
	cmp31_i { ap_none {  { cmp31_i in_data 0 1 } } }
	mul_ln40 { ap_none {  { mul_ln40 in_data 0 37 } } }
	p_cast_i { ap_none {  { p_cast_i in_data 0 13 } } }
	memory_load { ap_none {  { memory_load in_data 0 64 } } }
	 { m_axi {  { m_axi_gmem1_0_AWVALID VALID 1 1 }  { m_axi_gmem1_0_AWREADY READY 0 1 }  { m_axi_gmem1_0_AWADDR ADDR 1 64 }  { m_axi_gmem1_0_AWID ID 1 1 }  { m_axi_gmem1_0_AWLEN SIZE 1 32 }  { m_axi_gmem1_0_AWSIZE BURST 1 3 }  { m_axi_gmem1_0_AWBURST LOCK 1 2 }  { m_axi_gmem1_0_AWLOCK CACHE 1 2 }  { m_axi_gmem1_0_AWCACHE PROT 1 4 }  { m_axi_gmem1_0_AWPROT QOS 1 3 }  { m_axi_gmem1_0_AWQOS REGION 1 4 }  { m_axi_gmem1_0_AWREGION USER 1 4 }  { m_axi_gmem1_0_AWUSER DATA 1 1 }  { m_axi_gmem1_0_WVALID VALID 1 1 }  { m_axi_gmem1_0_WREADY READY 0 1 }  { m_axi_gmem1_0_WDATA FIFONUM 1 64 }  { m_axi_gmem1_0_WSTRB STRB 1 8 }  { m_axi_gmem1_0_WLAST LAST 1 1 }  { m_axi_gmem1_0_WID ID 1 1 }  { m_axi_gmem1_0_WUSER DATA 1 1 }  { m_axi_gmem1_0_ARVALID VALID 1 1 }  { m_axi_gmem1_0_ARREADY READY 0 1 }  { m_axi_gmem1_0_ARADDR ADDR 1 64 }  { m_axi_gmem1_0_ARID ID 1 1 }  { m_axi_gmem1_0_ARLEN SIZE 1 32 }  { m_axi_gmem1_0_ARSIZE BURST 1 3 }  { m_axi_gmem1_0_ARBURST LOCK 1 2 }  { m_axi_gmem1_0_ARLOCK CACHE 1 2 }  { m_axi_gmem1_0_ARCACHE PROT 1 4 }  { m_axi_gmem1_0_ARPROT QOS 1 3 }  { m_axi_gmem1_0_ARQOS REGION 1 4 }  { m_axi_gmem1_0_ARREGION USER 1 4 }  { m_axi_gmem1_0_ARUSER DATA 1 1 }  { m_axi_gmem1_0_RVALID VALID 0 1 }  { m_axi_gmem1_0_RREADY READY 1 1 }  { m_axi_gmem1_0_RDATA FIFONUM 0 64 }  { m_axi_gmem1_0_RLAST LAST 0 1 }  { m_axi_gmem1_0_RID ID 0 1 }  { m_axi_gmem1_0_RFIFONUM LEN 0 9 }  { m_axi_gmem1_0_RUSER DATA 0 1 }  { m_axi_gmem1_0_RRESP RESP 0 2 }  { m_axi_gmem1_0_BVALID VALID 0 1 }  { m_axi_gmem1_0_BREADY READY 1 1 }  { m_axi_gmem1_0_BRESP RESP 0 2 }  { m_axi_gmem1_0_BID ID 0 1 }  { m_axi_gmem1_0_BUSER DATA 0 1 } } }
	tmp_i_23 { ap_none {  { tmp_i_23 in_data 0 32 } } }
	tmp_1_i { ap_none {  { tmp_1_i in_data 0 32 } } }
	tmp_2_i { ap_none {  { tmp_2_i in_data 0 32 } } }
	tmp_3_i { ap_none {  { tmp_3_i in_data 0 32 } } }
	tmp_4_i { ap_none {  { tmp_4_i in_data 0 32 } } }
	tmp_5_i { ap_none {  { tmp_5_i in_data 0 32 } } }
	tmp_6_i { ap_none {  { tmp_6_i in_data 0 32 } } }
	tmp_7_i { ap_none {  { tmp_7_i in_data 0 32 } } }
	tmp_8_i { ap_none {  { tmp_8_i in_data 0 32 } } }
	tmp_9_i { ap_none {  { tmp_9_i in_data 0 32 } } }
	tmp_i { ap_none {  { tmp_i in_data 0 32 } } }
	tmp_10_i { ap_none {  { tmp_10_i in_data 0 32 } } }
	tmp_11_i { ap_none {  { tmp_11_i in_data 0 32 } } }
	tmp_12_i { ap_none {  { tmp_12_i in_data 0 32 } } }
	tmp_13_i { ap_none {  { tmp_13_i in_data 0 32 } } }
	tmp_14_i { ap_none {  { tmp_14_i in_data 0 32 } } }
	tmp_15_i { ap_none {  { tmp_15_i in_data 0 32 } } }
	tmp_16_i { ap_none {  { tmp_16_i in_data 0 32 } } }
	tmp_17_i { ap_none {  { tmp_17_i in_data 0 32 } } }
	tmp_18_i { ap_none {  { tmp_18_i in_data 0 32 } } }
	tmp_19_i { ap_none {  { tmp_19_i in_data 0 32 } } }
	tmp_20_i { ap_none {  { tmp_20_i in_data 0 32 } } }
	tmp_21_i { ap_none {  { tmp_21_i in_data 0 32 } } }
	tmp_22_i { ap_none {  { tmp_22_i in_data 0 32 } } }
	tmp_23_i { ap_none {  { tmp_23_i in_data 0 32 } } }
	tmp_24_i { ap_none {  { tmp_24_i in_data 0 32 } } }
	tmp_25_i { ap_none {  { tmp_25_i in_data 0 32 } } }
	tmp_26_i { ap_none {  { tmp_26_i in_data 0 32 } } }
	tmp_27_i { ap_none {  { tmp_27_i in_data 0 32 } } }
	tmp_28_i { ap_none {  { tmp_28_i in_data 0 32 } } }
	tmp_29_i { ap_none {  { tmp_29_i in_data 0 32 } } }
	tmp_30_i { ap_none {  { tmp_30_i in_data 0 32 } } }
	tmp_31_i { ap_none {  { tmp_31_i in_data 0 32 } } }
	tmp_32_i { ap_none {  { tmp_32_i in_data 0 32 } } }
	tmp_33_i { ap_none {  { tmp_33_i in_data 0 32 } } }
	tmp_34_i { ap_none {  { tmp_34_i in_data 0 32 } } }
	tmp_35_i { ap_none {  { tmp_35_i in_data 0 32 } } }
	tmp_36_i { ap_none {  { tmp_36_i in_data 0 32 } } }
	tmp_37_i { ap_none {  { tmp_37_i in_data 0 32 } } }
	tmp_38_i { ap_none {  { tmp_38_i in_data 0 32 } } }
	tmp_39_i { ap_none {  { tmp_39_i in_data 0 32 } } }
	tmp_40_i { ap_none {  { tmp_40_i in_data 0 32 } } }
	tmp_41_i { ap_none {  { tmp_41_i in_data 0 32 } } }
	tmp_42_i { ap_none {  { tmp_42_i in_data 0 32 } } }
	tmp_43_i { ap_none {  { tmp_43_i in_data 0 32 } } }
	tmp_44_i { ap_none {  { tmp_44_i in_data 0 32 } } }
	tmp_45_i { ap_none {  { tmp_45_i in_data 0 32 } } }
	tmp_46_i { ap_none {  { tmp_46_i in_data 0 32 } } }
	tmp_47_i { ap_none {  { tmp_47_i in_data 0 32 } } }
	tmp_48_i { ap_none {  { tmp_48_i in_data 0 32 } } }
	s_iw { ap_none {  { s_iw in_data 0 4 } } }
}
