module dflipflop(q, d, clk, ena, clr);
    input d, clk, ena, clr;

    output q;
    reg q;

    initial
    begin
        q = 1'b0;
    end

    always @(posedge clk) begin
        if (q == 1'bx) begin
            q <= 1'b0;
        end else if (clr) begin
            q <= 1'b0;
        end else if (ena) begin
            q <= d;
        end
    end
endmodule
