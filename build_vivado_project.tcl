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

report_methodology -no_waivers -file methodology.txt
report_utilization -quiet -hierarchical -hierarchical_depth 2 -file utilization_report.txt
report_param -file param_report.txt -verbose
report_io -file io_report.txt -verbose
xilinx::designutils::report_failfast -detailed_reports impl -file failfast_report.txt -quiet
report_design_analysis -show_all -complexity -file design_analysis_complexity_report.txt
report_design_analysis -show_all -congestion -file design_analysis_congestion_report.txt
report_drc -file drc_report.txt
report_drc -ruledeck methodology_checks -file drc_report_methodology.txt
report_drc -ruledeck timing_checks -file drc_report_timing.txt
report_debug_core -full_path -file debug_core.txt
report_timing_summary -slack_lesser_than 0 -file timing_summary.txt -max_paths 99

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]
write_bitstream -force -file ${top}.bit -verbose
write_debug_probes -force ${top}.ltx
write_checkpoint -force build.dcp
