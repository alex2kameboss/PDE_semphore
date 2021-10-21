module n_bit_counter #(
    parameter N = 2
) (
    input   logic   clk,
    input   logic   reset,
    input   logic   start,
    output  logic   done
);
    enum bit {Wait, Go} state, nextState;

    logic [N-1 : 0] cnt, nextCnt;
    logic cntDone;
    logic internalReset;

    always_ff @( posedge clk ) begin
        if (reset) begin
            state <= Wait;
        end
        else begin
            state <= nextState;
        end
    end

    always_comb begin
        nextState = state;
        internalReset = 0;
        unique case (state)
            Wait : if (start) begin
                nextState = Go;
            end 
            Go: if (cntDone) begin
                nextState = Wait;
                internalReset = 1;
            end
        endcase
    end

    always_ff @( posedge clk ) begin
        if (reset || internalReset) begin
            cnt <= 0;
        end
        else begin
            cnt <= nextCnt;
        end
    end

    always_comb begin
        nextCnt = cnt;
        if (state == Go) begin
            {cntDone, nextCnt} = cnt + 1'b1;
        end
    end

    assign done = cntDone & (state == Go);

endmodule