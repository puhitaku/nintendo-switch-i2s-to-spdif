//Copyright (C)2014-2020 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.3.02 Beta
//Created Time: 2020-08-13 03:17:14
create_clock -name bclk -period 162.76 -waveform {0 81.38} [get_ports {bclk}]
create_generated_clock -name spdif_clk -source [get_ports {bclk}] -master_clock bclk -multiply_by 8 [get_nets {spdif_clk}]
