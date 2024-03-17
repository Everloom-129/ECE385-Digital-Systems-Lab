# BUG Log Adder 

## Full
passed

## Ripple 
```
 Reading D:/intelFPGA_lite/18.1/modelsim_ase/tcl/vsim/pref.tcl
# do lab4_adders_toplevel_run_msim_rtl_verilog.do
# if {[file exists rtl_work]} {
# 	vdel -lib rtl_work -all
# }
# vlib rtl_work
# vmap work rtl_work
# Model Technology ModelSim - Intel FPGA Edition vmap 10.5b Lib Mapping Utility 2016.10 Oct  5 2016
# vmap work rtl_work 
# Copying D:/intelFPGA_lite/18.1/modelsim_ase/win32aloem/../modelsim.ini to modelsim.ini
# Modifying modelsim.ini
# 
# vlog -sv -work work +incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder {D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/HexDriver.sv}
# Model Technology ModelSim - Intel FPGA Edition vlog 10.5b Compiler 2016.10 Oct  5 2016
# Start time: 17:34:27 on Mar 08,2024
# vlog -reportprogress 300 -sv -work work "+incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder" D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/HexDriver.sv 
# -- Compiling module HexDriver
# 
# Top level modules:
# 	HexDriver
# End time: 17:34:27 on Mar 08,2024, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0
# vlog -sv -work work +incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder {D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/carry_lookahead_adder.sv}
# Model Technology ModelSim - Intel FPGA Edition vlog 10.5b Compiler 2016.10 Oct  5 2016
# Start time: 17:34:27 on Mar 08,2024
# vlog -reportprogress 300 -sv -work work "+incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder" D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/carry_lookahead_adder.sv 
# -- Compiling module carry_lookahead_adder
# -- Compiling module compute_4bit_PG_GG
# -- Compiling module carry_lookahead_adder_4bit
# -- Compiling module carry_lookahead_adder_4bit_helper_compute_carry
# 
# Top level modules:
# 	carry_lookahead_adder
# End time: 17:34:27 on Mar 08,2024, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0
# vlog -sv -work work +incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder {D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/lab4_adders_toplevel.sv}
# Model Technology ModelSim - Intel FPGA Edition vlog 10.5b Compiler 2016.10 Oct  5 2016
# Start time: 17:34:27 on Mar 08,2024
# vlog -reportprogress 300 -sv -work work "+incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder" D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/lab4_adders_toplevel.sv 
# -- Compiling module lab4_adders_toplevel
# 
# Top level modules:
# 	lab4_adders_toplevel
# End time: 17:34:27 on Mar 08,2024, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0
# 
# vlog -sv -work work +incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder {D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/testbench_adder.sv}
# Model Technology ModelSim - Intel FPGA Edition vlog 10.5b Compiler 2016.10 Oct  5 2016
# Start time: 17:34:27 on Mar 08,2024
# vlog -reportprogress 300 -sv -work work "+incdir+D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder" D:/intelFPGA_lite/ECE385-Digital-Systems-Lab/LAB4/adder/testbench_adder.sv 
# -- Compiling module testbench_adder
# 
# Top level modules:
# 	testbench_adder
# End time: 17:34:27 on Mar 08,2024, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0
# 
# vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_adder
# vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs=""+acc"" testbench_adder 
# Start time: 17:34:27 on Mar 08,2024
# Loading sv_std.std
# Loading work.testbench_adder
# Loading work.lab4_adders_toplevel
# Loading work.carry_lookahead_adder
# Loading work.compute_4bit_PG_GG
# Loading work.carry_lookahead_adder_4bit_helper_compute_carry
# Loading work.carry_lookahead_adder_4bit
# Loading work.HexDriver
# 
# add wave *
# view structure
# .main_pane.structure.interior.cs.body.struct
# view signals
# .main_pane.objects.interior.cs.body.tree
# run 1000 ns
# Test 1 failed
#           1 error(s) detected. Try again!
```

## carry_select_adder
passed