> [!NOTE]
> According to Xilinx, this issue will be [fixed in release 2025.2 of Vivado](https://adaptivesupport.amd.com/s/feed/0D5KZ00000pCG9c0AG?language=en_US).

This repository contains a minimal, reproducible example (MRE) demonstrating what I believe to be a flaw in the VHDL synthesizer causing an unexpected error during synthesis.

# Environment

- Vivado version 2024.2 for Linux

# Instructions

- Edit the `shell_vhdl_time_const_calc.vhd` file and select the statement declaring the `T_CLK_74_25_MHZ` constant (lines 31 to 33).
- Launch the synthesis using the makefile

```shell
make
```

# Results

| Vivado Version | `time := 1000 ns / 100` | `time := 1000 ns / 100.0` | `time := 1000 ns / 74.25` | `1000 * 1000 ns / 74250` |
| -------------- | ----------------------- | ------------------------- | ------------------------- | ------------------------ |
| 2024.2         | Pass ✅                 | Fail ❌                   | Fail ❌                  | Pass ✅                   |
| 2024.1         | Pass ✅                 | Fail ❌                   | Fail ❌                  | Pass ✅                   |
| 2021.2         | Pass ✅                 | Fail ❌                   | Fail ❌                  | Pass ✅                   |

## Error Message

Vivado 2024.2

```
ERROR: [Synth 8-11323] assigned value '4634995664936239104' out of range [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:39]
```

Vivado 2024.1

```
ERROR: [Synth 8-11323] assigned value '4634995664936239104' out of range [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:39]
```

Vivado 2021.2
```
ERROR: [Synth 8-3512] assigned value '0' out of range [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:39]
```

## Log File

```
#-----------------------------------------------------------
# Vivado v2024.2 (64-bit)
# SW Build 5239630 on Fri Nov 08 22:34:34 MST 2024
# IP Build 5239520 on Sun Nov 10 16:12:51 MST 2024
# SharedData Build 5239561 on Fri Nov 08 14:39:27 MST 2024
# Start of session at: Thu May 15 11:47:44 2025
# Process ID         : 126715
# Current directory  : /home/mm/Documents/vivado-vhdl-time-const-calc/run
# Command line       : vivado -quiet -nojournal -notrace -mode batch -source ../build_vivado_project.tcl
# Log file           : /home/mm/Documents/vivado-vhdl-time-const-calc/run/vivado.log
# Journal file       :
# Running On         : fedora
# Platform           : Fedora
# Operating System   : Fedora release 42 (Adams)
# Processor Detail   : AMD Ryzen Threadripper PRO 7955WX 16-Cores
# CPU Frequency      : 2201.000 MHz
# CPU Physical cores : 16
# CPU Logical cores  : 32
# Host memory        : 269347 MB
# Swap memory        : 8589 MB
# Total Virtual      : 277937 MB
# Available Virtual  : 226615 MB
#-----------------------------------------------------------
Command: synth_design -top shell_vhdl_time_const_calc -debug_log -assert -verbose
Starting synth_design
Using part: xczu7ev-ffvc1156-2-e
Attempting to get a license for feature 'Synthesis' and/or device 'xczu7ev'
INFO: [Common 17-349] Got license for feature 'Synthesis' and/or device 'xczu7ev'
INFO: [Device 21-403] Loading part xczu7ev-ffvc1156-2-e
INFO: [Synth 8-7079] Multithreading enabled for synth_design using a maximum of 7 processes.
INFO: [Synth 8-7078] Launching helper process for spawning children vivado processes
INFO: [Synth 8-7075] Helper process launched with PID 126790
---------------------------------------------------------------------------------
Starting RTL Elaboration : Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 2780.152 ; gain = 140.691 ; free physical = 148873 ; free virtual = 214289
---------------------------------------------------------------------------------
INFO: [Synth 8-638] synthesizing module 'shell_vhdl_time_const_calc' [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:30]
ERROR: [Synth 8-11323] assigned value '4634995664936239104' out of range [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:39]
ERROR: [Synth 8-285] failed synthesizing module 'shell_vhdl_time_const_calc' [/home/mm/Documents/vivado-vhdl-time-const-calc/shell_vhdl_time_const_calc.vhd:30]
---------------------------------------------------------------------------------
Finished RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 2853.121 ; gain = 213.660 ; free physical = 148818 ; free virtual = 214234
---------------------------------------------------------------------------------
RTL Elaboration failed
INFO: [Common 17-83] Releasing license: Synthesis
7 Infos, 0 Warnings, 0 Critical Warnings and 3 Errors encountered.
synth_design failed
ERROR: [Common 17-69] Command failed: Synthesis failed - please see the console or run log file for details
```

# References

- [Physical type TIME is broken in synthesis of Vivado 2015.4](https://support.xilinx.com/s/question/0D52E00007FSYv5SAH/physical-type-time-is-broken-in-synthesis-of-vivado-20154)
- [AR#57964 (updated in 2021 but appears to be from circa 2016)](https://adaptivesupport.amd.com/s/article/57964?language=en_US)
- [Relevant section in the UG901](https://docs.amd.com/r/en-US/ug901-vivado-synthesis/VHDL-Constructs-Support-Status)

> **VHDL Physical Types** (page 212)
>
> TIME | Supported, but only in functions for constant calculations.
