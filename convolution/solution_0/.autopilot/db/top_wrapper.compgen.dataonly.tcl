# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
interrupt {
}
}
dict set axilite_register_dict control $port_control


set port_control_r {
filter_val { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
memory { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
}
dict set axilite_register_dict control_r $port_control_r


set port_gmem3 {
memory_in { 
	dir I
	width 45
	depth 2250
	mode ap_memory
	offset 32768
	offset_end 65535
	core_op ram_1p
	core_impl auto
	core_latency 1
	byte_write 0
}
}
dict set axilite_register_dict gmem3 $port_gmem3


