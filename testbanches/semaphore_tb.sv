`timescale 1ns/1ps

module semaphore_tb ();
    logic clk;
    
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    logic reset;
    logic [2:0] Ai, As, Ci, Cs;

    my_semaphore u_sem(.*);

    initial begin
        reset = 1;
        @(posedge clk);
        reset = 0;
    end



endmodule