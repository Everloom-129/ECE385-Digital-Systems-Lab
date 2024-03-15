module reg_8
(
    input   logic   Clk, Reset, Left_shift_In, Load_d, Shift_function,
    input   logic[7:0] Data_in,

    output   logic  Left_shift_Out,
    output  logic[7:0] Data_out
);
    always_ff @(posedge Clk or posedge Reset) 
    begin
        if (Reset)
            Data_out <= 8'b0;
        else if (Load_d)
            Data_out <= Data_in;
        else if (Shift_function)
            Data_out <= {Left_shift_In, Data_out[7:1]};
        
    end
    assign Left_shift_Out = Data_out[0];

endmodule


module dreg(
    input logic Clk, Reset, Load_d, Data_in,
    output logic Data_out
);
    always_ff @(posedge Clk or posedge Reset) 
    begin
        if (Reset)
            Data_out <= 1'b0;
        else if (Load_d)
            Data_out <= Data_in;
        else
            Data_out <= Data_out;
    end
endmodule

