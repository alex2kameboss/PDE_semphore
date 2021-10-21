module my_semaphore (
    input   logic   clk,
    input   logic   reset,
    output  logic   [2:0] Ai,
    output  logic   [2:0] As,
    output  logic   [2:0] Ci,
    output  logic   [2:0] Cs
);
    logic [3:0] sel, done;
    logic masterNext;
    logic semaphoresNext, cnt0, cnt1;
    logic longCntStart, shortCntStart;

    assign masterNext = |done;
    assign semaphoresNext = cnt0 | cnt1;
    assign longCntStart = (sel[0] & (Ai[0] | Ai[2])) | 
                            (sel[1] & (As[0] | As[2])) | 
                            (sel[2] & (Ci[0] | Ci[2])) | 
                            (sel[3] & (Cs[0] | Cs[2]));
    assign shortCntStart = (sel[0] & Ai[1]) | 
                            (sel[1] & As[1]) | 
                            (sel[2] & Ci[1]) | 
                            (sel[3] & Cs[1]);

    semaphore_unit  u_Ai (.clk(clk),
                            .reset(reset),
                            .en(sel[0]),
                            .next(semaphoresNext),
                            .red(Ai[0]),
                            .yellow(Ai[1]),
                            .green(Ai[2]),
                            .done(done[0])),
                    u_As (.clk(clk),
                            .reset(reset),
                            .en(sel[1]),
                            .next(semaphoresNext),
                            .red(As[0]),
                            .yellow(As[1]),
                            .green(As[2]),
                            .done(done[1])),
                    u_Ci (.clk(clk),
                            .reset(reset),
                            .en(sel[2]),
                            .next(semaphoresNext),
                            .red(Ci[0]),
                            .yellow(Ci[1]),
                            .green(Ci[2]),
                            .done(done[2])),
                    u_Cs (.clk(clk),
                            .reset(reset),
                            .en(sel[3]),
                            .next(semaphoresNext),
                            .red(Cs[0]),
                            .yellow(Cs[1]),
                            .green(Cs[2]),
                            .done(done[3]));

    n_bit_counter   u_4cnt (.clk(clk),
                            .reset(reset),
                            .start(shortCntStart),
                            .done(cnt0));
    n_bit_counter #(.N(3)) u_8cnt (.clk(clk),
                                    .reset(reset),
                                    .start(longCntStart),
                                    .done(cnt1));

    master u_master (.clk(clk),
                        .reset(reset),
                        .next(masterNext),
                        .sel(sel));
endmodule