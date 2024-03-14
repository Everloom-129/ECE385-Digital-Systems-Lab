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


    // state wait run
    logic control_signal_run;
    dreg_control run_control(.Clk(Clk), .Reset(Reset), .Run(Run),.Data_out(control_signal_run) );


    // state wait load
    logic control_signal_load;
    if (control_signal_run && ClearA_LoadB)
        Clr_LD = 1;
    else
        Clr_LD = 0;

    dreg_control run_control(.Clk(Clk), .Reset(Reset), .Run(Clr_LD),.Data_out(control_signal_load) );

    // state wait load finished
    logic control_signal_count;
    dreg_control run_control(.Clk(Clk), .Reset(Reset), .Run(control_signal_load),.Data_out(control_signal_count) );


    //count when control_signal_count is high
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
    always_ff @(posedge Clk or posedge Reset) 
    begin
        if (Reset)
            Data_out <= 1'b0;
        else if (Run)
            Data_out <= 1'b1;
        else
            Data_out <= Data_out;
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

// Counter outputs
logic[4:0] count;
logic time_15, wait_flag;


// Instantiate the 5-bit counter
counter_5_bits counter(.Clk(Clk), .Reset(Reset), .count(count), .time_15(time_15), .wait_flag(wait_flag));

always_comb begin
    // Default values
    Clr_LD = 0;
    ClearA = 0;
    Shift = 0;
    Add = 0;
    Sub = 0;

    if (!Run) {
        // Handle not running or wait state
        ClearA = 1;

    } else if (count == 5'b01110) {
        // Handle count == 14
        if (M) 
            Sub = 1;
    
    } else if (count[0] == 1) {
        // Handle odd counts (Shift)
        Shift = 1;
        
    } else {
        // Handle even counts (Add, excluding count == 0 which is handled above)
        if (M) 
            Add = 1;
    }
end

endmodule



