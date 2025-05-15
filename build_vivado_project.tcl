# Vivado TCL build script invoked from the Makefile

package require Vivado
create_project -part xczu7ev-ffvc1156-2-e -in_memory
read_vhdl -vhdl2008 [glob ../*.vhd]
read_xdc [glob ../*.xdc]

set top [lindex [find_top] 0]
synth_design -top ${top} -debug_log -assert -verbose
opt_design -debug_log -verbose
place_design -debug_log -timing_summary -verbose
route_design -debug_log -tns_cleanup -verbose

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]
write_bitstream -force -file ${top}.bit -verbose
write_debug_probes -force ${top}.ltx
write_checkpoint -force build.dcp
