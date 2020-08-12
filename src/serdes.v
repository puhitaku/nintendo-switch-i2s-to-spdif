module serdes (
    input bclk,
    input lrclk,
    input sdata,
    input rstn,
    output reg [31:0]frame,
    output reg wr
);

reg [15:0] subfr_l;
reg [15:0] subfr_r;

reg [7:0]count;

reg last_ch;
reg chan_flag;

always @(posedge bclk) begin
    if (~rstn) begin
        subfr_l <= 16'h0;
        subfr_r <= 16'h0;
        count <= 8'h0;
        frame <= 32'h0;
        last_ch <= lrclk;
    end
    else begin
        if (wr) begin
            wr <= 0;
        end

        if (chan_flag) begin
            // we've got a subframe
            if (lrclk == 0) begin
                // R -> L; time to enqueue a frame
                frame <= {subfr_r[15:0], subfr_l[15:0]};
                wr <= 1;
            end
        end

        if (last_ch == lrclk) begin
            chan_flag <= 0;
            count <= count + 8'h1;

            if (count < 8'd16) begin
                if (lrclk == 0) begin
                    subfr_l <= {subfr_l[14:0], sdata};
                end
                else begin
                    subfr_r <= {subfr_r[14:0], sdata};
                end
            end
        end
        else begin
            chan_flag <= 1;
            count <= 8'd0;

            if (count < 8'd16) begin
                if (lrclk == 0) begin
                    subfr_r <= {subfr_r[14:0], sdata};
                end
                else begin
                    subfr_l <= {subfr_l[14:0], sdata};
                end
            end
        end

        last_ch <= lrclk;
    end
end
endmodule
