//Copyright (C)2014-2020 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.3.02Beta
//Part Number: GW1N-LV1QN48C6/I5
//Created Time: Thu Aug 13 03:22:14 2020

module pll (clkout, lock, clkin);

output clkout;
output lock;
input clkin;

wire clkoutp_o;
wire clkoutd_o;
wire clkoutd3_o;
wire gw_gnd;

assign gw_gnd = 1'b0;

rPLL rpll_inst (
    .CLKOUT(clkout),
    .LOCK(lock),
    .CLKOUTP(clkoutp_o),
    .CLKOUTD(clkoutd_o),
    .CLKOUTD3(clkoutd3_o),
    .RESET(gw_gnd),
    .RESET_P(gw_gnd),
    .CLKIN(clkin),
    .CLKFB(gw_gnd),
    .FBDSEL({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd}),
    .IDSEL({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd}),
    .ODSEL({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd}),
    .PSDA({gw_gnd,gw_gnd,gw_gnd,gw_gnd}),
    .DUTYDA({gw_gnd,gw_gnd,gw_gnd,gw_gnd}),
    .FDLY({gw_gnd,gw_gnd,gw_gnd,gw_gnd})
);

defparam rpll_inst.FCLKIN = "6.144";
defparam rpll_inst.DYN_IDIV_SEL = "false";
defparam rpll_inst.IDIV_SEL = 0;
defparam rpll_inst.DYN_FBDIV_SEL = "false";
defparam rpll_inst.FBDIV_SEL = 7;
defparam rpll_inst.DYN_ODIV_SEL = "false";
defparam rpll_inst.ODIV_SEL = 16;
defparam rpll_inst.PSDA_SEL = "0000";
defparam rpll_inst.DYN_DA_EN = "true";
defparam rpll_inst.DUTYDA_SEL = "1000";
defparam rpll_inst.CLKOUT_FT_DIR = 1'b1;
defparam rpll_inst.CLKOUTP_FT_DIR = 1'b1;
defparam rpll_inst.CLKOUT_DLY_STEP = 0;
defparam rpll_inst.CLKOUTP_DLY_STEP = 0;
defparam rpll_inst.CLKFB_SEL = "internal";
defparam rpll_inst.CLKOUT_BYPASS = "false";
defparam rpll_inst.CLKOUTP_BYPASS = "false";
defparam rpll_inst.CLKOUTD_BYPASS = "false";
defparam rpll_inst.DYN_SDIV_SEL = 2;
defparam rpll_inst.CLKOUTD_SRC = "CLKOUT";
defparam rpll_inst.CLKOUTD3_SRC = "CLKOUT";
defparam rpll_inst.DEVICE = "GW1N-1";

endmodule //pll

module rPLL (CLKOUT, CLKOUTP, CLKOUTD, CLKOUTD3, LOCK, CLKIN, CLKFB, FBDSEL, IDSEL, ODSEL, DUTYDA, PSDA, FDLY, RESET, RESET_P);
input CLKIN;
input CLKFB;
input RESET;
input RESET_P;
input [5:0] FBDSEL;
input [5:0] IDSEL;
input [5:0] ODSEL;
input [3:0] PSDA,FDLY;
input [3:0] DUTYDA;
output CLKOUT;
output LOCK;
output CLKOUTP;
output CLKOUTD;
output CLKOUTD3;

parameter FCLKIN = "100.0";
parameter DYN_IDIV_SEL= "false";
parameter IDIV_SEL = 0;
parameter DYN_FBDIV_SEL= "false";
parameter FBDIV_SEL = 0;
parameter DYN_ODIV_SEL= "false";
parameter ODIV_SEL = 8;
parameter PSDA_SEL= "0000";
parameter DYN_DA_EN = "false";
parameter DUTYDA_SEL= "1000";
parameter CLKOUT_FT_DIR = 1'b1;
parameter CLKOUTP_FT_DIR = 1'b1;
parameter CLKOUT_DLY_STEP = 0;
parameter CLKOUTP_DLY_STEP = 0;
parameter CLKFB_SEL = "internal";
parameter CLKOUT_BYPASS = "false";
parameter CLKOUTP_BYPASS = "false";
parameter CLKOUTD_BYPASS = "false";
parameter DYN_SDIV_SEL = 2;
parameter CLKOUTD_SRC = "CLKOUT";
parameter CLKOUTD3_SRC = "CLKOUT";
parameter DEVICE = "GW1N-2";

endmodule
