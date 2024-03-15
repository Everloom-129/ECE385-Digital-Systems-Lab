module control(
    input logic Clk,
    input logic Reset,
    input logic ClearA_LoadB,
    input logic Run,
    input logic M,

    output logic Clr_LD,
    output logic ClearA,
    output logic Shift,
    output logic Add,
    output logic Sub
);

    logic control_signal_run, control_signal_load, control_signal_count;

    // state wait run
    dreg_control run_control_1(.Clk(Clk), .Reset(Reset), .Run(Run), .Data_out(control_signal_run));

    // state wait load
    dreg_control load_control(.Clk(Clk), .Reset(Reset), .Run(Clr_LD), .Data_out(control_signal_load));

    // state wait load finished
    dreg_control count_control(.Clk(Clk), .Reset(Reset), .Run(control_signal_load), .Data_out(control_signal_count));

    always_ff @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            Clr_LD <= 0;
        end else if (control_signal_run && ClearA_LoadB) begin
            Clr_LD <= 1;
        end else begin
            Clr_LD <= 0;
        end
    end

    // count when control_signal_count is high
    control_with_counter main_control(
        .Clk(Clk),
        .Reset(Reset),
        .Run(control_signal_count), 
        .M(M),
        .ClearA(ClearA),
        .Shift(Shift),
        .Add(Add),
        .Sub(Sub)
    );

endmodule

module dreg_control(
    input logic Clk, Reset, Run,
    output logic Data_out
);
    always_ff @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            Data_out <= 1'b0;
        end else if (Run) begin
            Data_out <= 1'b1;
        end
    end
endmodule

module control_with_counter(
    input logic Clk,
    input logic Reset,
    input logic Run,
    input logic M,
    output logic ClearA,
    output logic Shift,
    output logic Add,
    output logic Sub
);

    logic[4:0] count;
    logic time_15, wait_flag;

    counter_5_bits counter(.Clk(Clk), .Reset(Reset), .count(count), .time_15(time_15), .wait_flag(wait_flag));

    always_comb begin
        // Default values
        ClearA = 0;
        Shift = 0;
        Add = 0;
        Sub = 0;

        if (!Run) begin
            ClearA = 1;
        end else if (count == 5'b01110) begin
            if (M) begin
                Sub = 1;
            end
        end else if (count[0] == 1) begin
            Shift = 1;
        end else begin
            if (M) begin
                Add = 1;
            end
        end
    end
endmodule
