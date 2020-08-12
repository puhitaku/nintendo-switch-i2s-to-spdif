module top (
    input bclk,
    input lrclk,
    input sdata,
    output out,
    output out_led
);

assign out_led = out;

// serdes <-> fifo
wire [31:0]frame_in;
wire wr;

// fifo <-> spdif
wire [31:0]frame_out;
wire frame_req;
wire ready;

// pll
wire spdif_clk;
wire lock;

pll pll (
    .clkin(bclk),

    .clkout(spdif_clk),
    .lock(lock)
);

serdes serdes (
    .bclk(bclk),
    .lrclk(lrclk),
    .sdata(sdata),
    .rstn(lock),

    .frame(frame_in),
    .wr(wr)
);

fifo fifo (
    .Data(frame_in),
    .Reset(~lock),
    .WrClk(bclk),
    .RdClk(frame_req),
    .WrEn(wr),
    .RdEn(1'b1),

    .Q(frame_out),
    .Almost_Full(ready)
);

spdif spdif (
    .clk_i(spdif_clk),
    .rst_i(~lock || ~ready),
    .audio_clk_i(bclk),
    .sample_i(frame_out),

    .sample_req_o(frame_req),
    .spdif_o(out)
);

endmodule
