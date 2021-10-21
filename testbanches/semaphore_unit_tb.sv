`timescale 1ns/1ps

module semaphore_unit_tb ();
    logic clk;

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    logic reset, en, next, red, yellow, green, done;

    initial begin
        reset = 1;
        en = 1;
        next = 0;
        @(posedge clk);
        reset = 0;

        forever begin
            for (int i = 0; i < 4; i++) begin
                @(posedge clk);
                @(posedge clk);
                next = 1;
                @(posedge clk);
                next = 0;
                @(posedge clk);
            end
            @(posedge clk);
        end
    end

    semaphore_unit u_s(.*);
endmodule