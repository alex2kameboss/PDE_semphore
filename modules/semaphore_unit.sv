module semaphore_unit (
    input   logic   clk,
    input   logic   reset,
    input   logic   en,
    input   logic   next,
    output  logic   red,
    output  logic   yellow,
    output  logic   green,
    output  logic   done
);
    logic [1:0] state, nextState;

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
        done = 0;
        if (en && next) begin
            {done, nextState} = state + 1'b1;
        end
    end

    assign red = (state == 2'b00);
    assign yellow = (state == 2'b01) | (state == 2'b11);
    assign green = (state == 2'b10);

endmodule