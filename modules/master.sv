module master (
    input   logic   clk,
    input   logic   reset,
    input   logic   next,
    output  logic   [3:0] sel
);
    logic[1:0] state, nextState;

    always_ff @( posedge clk ) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            state <= nextState;
        end
    end

    always_comb begin
        nextState = state;
        if (next) begin
            nextState = state + 1'b1;
        end
    end

    always_comb begin
        sel = 0;
        unique case (state)
            2'b00: sel[0] = 1; 
            2'b01: sel[1] = 1;
            2'b10: sel[2] = 1;
            2'b11: sel[3] = 1;
        endcase
    end

endmodule