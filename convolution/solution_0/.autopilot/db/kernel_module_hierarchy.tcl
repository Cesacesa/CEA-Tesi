set ModuleHierarchy {[{
"Name" : "top_wrapper","ID" : "0","Type" : "sequential",
"SubLoops" : [
	{"Name" : "VITIS_LOOP_92_1","ID" : "1","Type" : "no",
	"SubInsts" : [
	{"Name" : "dataflow_in_loop_VITIS_LOOP_92_1_1_U0","ID" : "2","Type" : "dataflow",
			"SubInsts" : [
			{"Name" : "entry_proc_U0","ID" : "3","Type" : "sequential"},
			{"Name" : "dataflow_in_loop_VITIS_LOOP_92_1_1_Loop_VITIS_LOOP_99_2_proc_U0","ID" : "4","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_99_2","ID" : "5","Type" : "pipeline"},]},
			{"Name" : "load_input_U0","ID" : "6","Type" : "sequential",
				"SubInsts" : [
				{"Name" : "grp_load_input_Pipeline_load_input_loop_VITIS_LOOP_9_1_fu_1860","ID" : "7","Type" : "sequential",
					"SubLoops" : [
					{"Name" : "load_input_loop_VITIS_LOOP_9_1","ID" : "8","Type" : "pipeline"},]},]},
			{"Name" : "conv_2_13_13_3_3_2_11_11_1_1_5_1_5_5_2_3_U0","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "L6","ID" : "10","Type" : "no",
				"SubInsts" : [
				{"Name" : "grp_conv_Pipeline_VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3_fu_5588","ID" : "11","Type" : "sequential",
						"SubLoops" : [
						{"Name" : "VITIS_LOOP_41_1_VITIS_LOOP_42_2_VITIS_LOOP_43_3","ID" : "12","Type" : "pipeline"},]},
				{"Name" : "grp_conv_2_13_13_3_3_2_11_11_1_1_5_1_5_5_2_3_Pipeline_L5_L4_L3_fu_5630","ID" : "13","Type" : "sequential",
						"SubLoops" : [
						{"Name" : "L5_L4_L3","ID" : "14","Type" : "pipeline"},]},]},]},
			{"Name" : "out_conv2mem_2_13_13_3_3_2_11_11_1_162_1_1_5_5_2_3_U0","ID" : "15","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_37_1","ID" : "16","Type" : "no",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_38_2","ID" : "17","Type" : "no",
					"SubLoops" : [
					{"Name" : "VITIS_LOOP_40_3","ID" : "18","Type" : "no",
						"SubInsts" : [
						{"Name" : "grp_out_conv2mem_Pipeline_VITIS_LOOP_41_4_fu_3757","ID" : "19","Type" : "sequential",
								"SubLoops" : [
								{"Name" : "VITIS_LOOP_41_4","ID" : "20","Type" : "pipeline"},]},]},]},]},]},]},]},]
}]}