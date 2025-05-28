set moduleName conv_Pipeline_VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3
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
set C_modelName {conv_Pipeline_VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ filter_mem_17 int 8 regular  }
	{ filter_mem_16 int 8 regular  }
	{ filter_mem_15 int 8 regular  }
	{ filter_mem_14 int 8 regular  }
	{ filter_mem_13 int 8 regular  }
	{ filter_mem_12 int 8 regular  }
	{ filter_mem_11 int 8 regular  }
	{ filter_mem_10 int 8 regular  }
	{ filter_mem_9 int 8 regular  }
	{ filter_mem_8 int 8 regular  }
	{ filter_mem_7 int 8 regular  }
	{ filter_mem_6 int 8 regular  }
	{ filter_mem_5 int 8 regular  }
	{ filter_mem_4 int 8 regular  }
	{ filter_mem_3 int 8 regular  }
	{ filter_mem_2 int 8 regular  }
	{ filter_mem_1 int 8 regular  }
	{ filter_mem int 8 regular  }
	{ filter2conv int 8 regular {fifo 0 volatile }  }
	{ filter_mem_35_out int 8 regular {pointer 1}  }
	{ filter_mem_34_out int 8 regular {pointer 1}  }
	{ filter_mem_33_out int 8 regular {pointer 1}  }
	{ filter_mem_32_out int 8 regular {pointer 1}  }
	{ filter_mem_31_out int 8 regular {pointer 1}  }
	{ filter_mem_30_out int 8 regular {pointer 1}  }
	{ filter_mem_29_out int 8 regular {pointer 1}  }
	{ filter_mem_28_out int 8 regular {pointer 1}  }
	{ filter_mem_27_out int 8 regular {pointer 1}  }
	{ filter_mem_26_out int 8 regular {pointer 1}  }
	{ filter_mem_25_out int 8 regular {pointer 1}  }
	{ filter_mem_24_out int 8 regular {pointer 1}  }
	{ filter_mem_23_out int 8 regular {pointer 1}  }
	{ filter_mem_22_out int 8 regular {pointer 1}  }
	{ filter_mem_21_out int 8 regular {pointer 1}  }
	{ filter_mem_20_out int 8 regular {pointer 1}  }
	{ filter_mem_19_out int 8 regular {pointer 1}  }
	{ filter_mem_18_out int 8 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "filter_mem_17", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_16", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_15", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_14", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_13", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_12", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_11", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_10", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_9", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_8", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_7", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_6", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_5", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_4", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_3", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_2", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_1", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter2conv", "interface" : "fifo", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "filter_mem_35_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_34_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_33_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_32_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_31_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_30_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_29_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_28_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_27_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_26_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_25_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_24_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_23_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_22_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_21_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_20_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_19_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filter_mem_18_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 65
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ filter2conv_dout sc_in sc_lv 8 signal 18 } 
	{ filter2conv_empty_n sc_in sc_logic 1 signal 18 } 
	{ filter2conv_read sc_out sc_logic 1 signal 18 } 
	{ filter2conv_num_data_valid sc_in sc_lv 8 signal 18 } 
	{ filter2conv_fifo_cap sc_in sc_lv 8 signal 18 } 
	{ filter_mem_17 sc_in sc_lv 8 signal 0 } 
	{ filter_mem_16 sc_in sc_lv 8 signal 1 } 
	{ filter_mem_15 sc_in sc_lv 8 signal 2 } 
	{ filter_mem_14 sc_in sc_lv 8 signal 3 } 
	{ filter_mem_13 sc_in sc_lv 8 signal 4 } 
	{ filter_mem_12 sc_in sc_lv 8 signal 5 } 
	{ filter_mem_11 sc_in sc_lv 8 signal 6 } 
	{ filter_mem_10 sc_in sc_lv 8 signal 7 } 
	{ filter_mem_9 sc_in sc_lv 8 signal 8 } 
	{ filter_mem_8 sc_in sc_lv 8 signal 9 } 
	{ filter_mem_7 sc_in sc_lv 8 signal 10 } 
	{ filter_mem_6 sc_in sc_lv 8 signal 11 } 
	{ filter_mem_5 sc_in sc_lv 8 signal 12 } 
	{ filter_mem_4 sc_in sc_lv 8 signal 13 } 
	{ filter_mem_3 sc_in sc_lv 8 signal 14 } 
	{ filter_mem_2 sc_in sc_lv 8 signal 15 } 
	{ filter_mem_1 sc_in sc_lv 8 signal 16 } 
	{ filter_mem sc_in sc_lv 8 signal 17 } 
	{ filter_mem_35_out sc_out sc_lv 8 signal 19 } 
	{ filter_mem_35_out_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ filter_mem_34_out sc_out sc_lv 8 signal 20 } 
	{ filter_mem_34_out_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ filter_mem_33_out sc_out sc_lv 8 signal 21 } 
	{ filter_mem_33_out_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ filter_mem_32_out sc_out sc_lv 8 signal 22 } 
	{ filter_mem_32_out_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ filter_mem_31_out sc_out sc_lv 8 signal 23 } 
	{ filter_mem_31_out_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ filter_mem_30_out sc_out sc_lv 8 signal 24 } 
	{ filter_mem_30_out_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ filter_mem_29_out sc_out sc_lv 8 signal 25 } 
	{ filter_mem_29_out_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ filter_mem_28_out sc_out sc_lv 8 signal 26 } 
	{ filter_mem_28_out_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ filter_mem_27_out sc_out sc_lv 8 signal 27 } 
	{ filter_mem_27_out_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ filter_mem_26_out sc_out sc_lv 8 signal 28 } 
	{ filter_mem_26_out_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ filter_mem_25_out sc_out sc_lv 8 signal 29 } 
	{ filter_mem_25_out_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ filter_mem_24_out sc_out sc_lv 8 signal 30 } 
	{ filter_mem_24_out_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ filter_mem_23_out sc_out sc_lv 8 signal 31 } 
	{ filter_mem_23_out_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ filter_mem_22_out sc_out sc_lv 8 signal 32 } 
	{ filter_mem_22_out_ap_vld sc_out sc_logic 1 outvld 32 } 
	{ filter_mem_21_out sc_out sc_lv 8 signal 33 } 
	{ filter_mem_21_out_ap_vld sc_out sc_logic 1 outvld 33 } 
	{ filter_mem_20_out sc_out sc_lv 8 signal 34 } 
	{ filter_mem_20_out_ap_vld sc_out sc_logic 1 outvld 34 } 
	{ filter_mem_19_out sc_out sc_lv 8 signal 35 } 
	{ filter_mem_19_out_ap_vld sc_out sc_logic 1 outvld 35 } 
	{ filter_mem_18_out sc_out sc_lv 8 signal 36 } 
	{ filter_mem_18_out_ap_vld sc_out sc_logic 1 outvld 36 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "filter2conv_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter2conv", "role": "dout" }} , 
 	{ "name": "filter2conv_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filter2conv", "role": "empty_n" }} , 
 	{ "name": "filter2conv_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "filter2conv", "role": "read" }} , 
 	{ "name": "filter2conv_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter2conv", "role": "num_data_valid" }} , 
 	{ "name": "filter2conv_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter2conv", "role": "fifo_cap" }} , 
 	{ "name": "filter_mem_17", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_17", "role": "default" }} , 
 	{ "name": "filter_mem_16", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_16", "role": "default" }} , 
 	{ "name": "filter_mem_15", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_15", "role": "default" }} , 
 	{ "name": "filter_mem_14", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_14", "role": "default" }} , 
 	{ "name": "filter_mem_13", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_13", "role": "default" }} , 
 	{ "name": "filter_mem_12", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_12", "role": "default" }} , 
 	{ "name": "filter_mem_11", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_11", "role": "default" }} , 
 	{ "name": "filter_mem_10", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_10", "role": "default" }} , 
 	{ "name": "filter_mem_9", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_9", "role": "default" }} , 
 	{ "name": "filter_mem_8", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_8", "role": "default" }} , 
 	{ "name": "filter_mem_7", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_7", "role": "default" }} , 
 	{ "name": "filter_mem_6", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_6", "role": "default" }} , 
 	{ "name": "filter_mem_5", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_5", "role": "default" }} , 
 	{ "name": "filter_mem_4", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_4", "role": "default" }} , 
 	{ "name": "filter_mem_3", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_3", "role": "default" }} , 
 	{ "name": "filter_mem_2", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_2", "role": "default" }} , 
 	{ "name": "filter_mem_1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_1", "role": "default" }} , 
 	{ "name": "filter_mem", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem", "role": "default" }} , 
 	{ "name": "filter_mem_35_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_35_out", "role": "default" }} , 
 	{ "name": "filter_mem_35_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_35_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_34_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_34_out", "role": "default" }} , 
 	{ "name": "filter_mem_34_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_34_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_33_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_33_out", "role": "default" }} , 
 	{ "name": "filter_mem_33_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_33_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_32_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_32_out", "role": "default" }} , 
 	{ "name": "filter_mem_32_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_32_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_31_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_31_out", "role": "default" }} , 
 	{ "name": "filter_mem_31_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_31_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_30_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_30_out", "role": "default" }} , 
 	{ "name": "filter_mem_30_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_30_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_29_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_29_out", "role": "default" }} , 
 	{ "name": "filter_mem_29_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_29_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_28_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_28_out", "role": "default" }} , 
 	{ "name": "filter_mem_28_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_28_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_27_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_27_out", "role": "default" }} , 
 	{ "name": "filter_mem_27_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_27_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_26_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_26_out", "role": "default" }} , 
 	{ "name": "filter_mem_26_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_26_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_25_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_25_out", "role": "default" }} , 
 	{ "name": "filter_mem_25_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_25_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_24_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_24_out", "role": "default" }} , 
 	{ "name": "filter_mem_24_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_24_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_23_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_23_out", "role": "default" }} , 
 	{ "name": "filter_mem_23_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_23_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_22_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_22_out", "role": "default" }} , 
 	{ "name": "filter_mem_22_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_22_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_21_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_21_out", "role": "default" }} , 
 	{ "name": "filter_mem_21_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_21_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_20_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_20_out", "role": "default" }} , 
 	{ "name": "filter_mem_20_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_20_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_19_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_19_out", "role": "default" }} , 
 	{ "name": "filter_mem_19_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_19_out", "role": "ap_vld" }} , 
 	{ "name": "filter_mem_18_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "filter_mem_18_out", "role": "default" }} , 
 	{ "name": "filter_mem_18_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filter_mem_18_out", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "conv_Pipeline_VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "20", "EstimateLatencyMax" : "20",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "filter_mem_17", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_16", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_15", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_14", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_13", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_12", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_11", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_10", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_9", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_8", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_7", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_6", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_5", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_4", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_3", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_2", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter_mem", "Type" : "None", "Direction" : "I"},
			{"Name" : "filter2conv", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "filter2conv_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "filter_mem_35_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_34_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_33_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_32_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_31_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_30_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_29_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_28_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_27_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_26_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_25_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_24_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_23_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_22_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_21_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_20_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_19_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filter_mem_18_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	conv_Pipeline_VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3 {
		filter_mem_17 {Type I LastRead 0 FirstWrite -1}
		filter_mem_16 {Type I LastRead 0 FirstWrite -1}
		filter_mem_15 {Type I LastRead 0 FirstWrite -1}
		filter_mem_14 {Type I LastRead 0 FirstWrite -1}
		filter_mem_13 {Type I LastRead 0 FirstWrite -1}
		filter_mem_12 {Type I LastRead 0 FirstWrite -1}
		filter_mem_11 {Type I LastRead 0 FirstWrite -1}
		filter_mem_10 {Type I LastRead 0 FirstWrite -1}
		filter_mem_9 {Type I LastRead 0 FirstWrite -1}
		filter_mem_8 {Type I LastRead 0 FirstWrite -1}
		filter_mem_7 {Type I LastRead 0 FirstWrite -1}
		filter_mem_6 {Type I LastRead 0 FirstWrite -1}
		filter_mem_5 {Type I LastRead 0 FirstWrite -1}
		filter_mem_4 {Type I LastRead 0 FirstWrite -1}
		filter_mem_3 {Type I LastRead 0 FirstWrite -1}
		filter_mem_2 {Type I LastRead 0 FirstWrite -1}
		filter_mem_1 {Type I LastRead 0 FirstWrite -1}
		filter_mem {Type I LastRead 0 FirstWrite -1}
		filter2conv {Type I LastRead 1 FirstWrite -1}
		filter_mem_35_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_34_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_33_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_32_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_31_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_30_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_29_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_28_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_27_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_26_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_25_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_24_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_23_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_22_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_21_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_20_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_19_out {Type O LastRead -1 FirstWrite 0}
		filter_mem_18_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "20", "Max" : "20"}
	, {"Name" : "Interval", "Min" : "20", "Max" : "20"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	filter_mem_17 { ap_none {  { filter_mem_17 in_data 0 8 } } }
	filter_mem_16 { ap_none {  { filter_mem_16 in_data 0 8 } } }
	filter_mem_15 { ap_none {  { filter_mem_15 in_data 0 8 } } }
	filter_mem_14 { ap_none {  { filter_mem_14 in_data 0 8 } } }
	filter_mem_13 { ap_none {  { filter_mem_13 in_data 0 8 } } }
	filter_mem_12 { ap_none {  { filter_mem_12 in_data 0 8 } } }
	filter_mem_11 { ap_none {  { filter_mem_11 in_data 0 8 } } }
	filter_mem_10 { ap_none {  { filter_mem_10 in_data 0 8 } } }
	filter_mem_9 { ap_none {  { filter_mem_9 in_data 0 8 } } }
	filter_mem_8 { ap_none {  { filter_mem_8 in_data 0 8 } } }
	filter_mem_7 { ap_none {  { filter_mem_7 in_data 0 8 } } }
	filter_mem_6 { ap_none {  { filter_mem_6 in_data 0 8 } } }
	filter_mem_5 { ap_none {  { filter_mem_5 in_data 0 8 } } }
	filter_mem_4 { ap_none {  { filter_mem_4 in_data 0 8 } } }
	filter_mem_3 { ap_none {  { filter_mem_3 in_data 0 8 } } }
	filter_mem_2 { ap_none {  { filter_mem_2 in_data 0 8 } } }
	filter_mem_1 { ap_none {  { filter_mem_1 in_data 0 8 } } }
	filter_mem { ap_none {  { filter_mem in_data 0 8 } } }
	filter2conv { ap_fifo {  { filter2conv_dout fifo_data_in 0 8 }  { filter2conv_empty_n fifo_status 0 1 }  { filter2conv_read fifo_port_we 1 1 }  { filter2conv_num_data_valid fifo_status_num_data_valid 0 8 }  { filter2conv_fifo_cap fifo_update 0 8 } } }
	filter_mem_35_out { ap_vld {  { filter_mem_35_out out_data 1 8 }  { filter_mem_35_out_ap_vld out_vld 1 1 } } }
	filter_mem_34_out { ap_vld {  { filter_mem_34_out out_data 1 8 }  { filter_mem_34_out_ap_vld out_vld 1 1 } } }
	filter_mem_33_out { ap_vld {  { filter_mem_33_out out_data 1 8 }  { filter_mem_33_out_ap_vld out_vld 1 1 } } }
	filter_mem_32_out { ap_vld {  { filter_mem_32_out out_data 1 8 }  { filter_mem_32_out_ap_vld out_vld 1 1 } } }
	filter_mem_31_out { ap_vld {  { filter_mem_31_out out_data 1 8 }  { filter_mem_31_out_ap_vld out_vld 1 1 } } }
	filter_mem_30_out { ap_vld {  { filter_mem_30_out out_data 1 8 }  { filter_mem_30_out_ap_vld out_vld 1 1 } } }
	filter_mem_29_out { ap_vld {  { filter_mem_29_out out_data 1 8 }  { filter_mem_29_out_ap_vld out_vld 1 1 } } }
	filter_mem_28_out { ap_vld {  { filter_mem_28_out out_data 1 8 }  { filter_mem_28_out_ap_vld out_vld 1 1 } } }
	filter_mem_27_out { ap_vld {  { filter_mem_27_out out_data 1 8 }  { filter_mem_27_out_ap_vld out_vld 1 1 } } }
	filter_mem_26_out { ap_vld {  { filter_mem_26_out out_data 1 8 }  { filter_mem_26_out_ap_vld out_vld 1 1 } } }
	filter_mem_25_out { ap_vld {  { filter_mem_25_out out_data 1 8 }  { filter_mem_25_out_ap_vld out_vld 1 1 } } }
	filter_mem_24_out { ap_vld {  { filter_mem_24_out out_data 1 8 }  { filter_mem_24_out_ap_vld out_vld 1 1 } } }
	filter_mem_23_out { ap_vld {  { filter_mem_23_out out_data 1 8 }  { filter_mem_23_out_ap_vld out_vld 1 1 } } }
	filter_mem_22_out { ap_vld {  { filter_mem_22_out out_data 1 8 }  { filter_mem_22_out_ap_vld out_vld 1 1 } } }
	filter_mem_21_out { ap_vld {  { filter_mem_21_out out_data 1 8 }  { filter_mem_21_out_ap_vld out_vld 1 1 } } }
	filter_mem_20_out { ap_vld {  { filter_mem_20_out out_data 1 8 }  { filter_mem_20_out_ap_vld out_vld 1 1 } } }
	filter_mem_19_out { ap_vld {  { filter_mem_19_out out_data 1 8 }  { filter_mem_19_out_ap_vld out_vld 1 1 } } }
	filter_mem_18_out { ap_vld {  { filter_mem_18_out out_data 1 8 }  { filter_mem_18_out_ap_vld out_vld 1 1 } } }
}
