// Edit: 
// - Jie Wang 0308 
// - new module reg_8
// - input output size
// - Cite from lab 04



module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h0; // update to 8 bit
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] }; // 8 bit 
	    end
    end
	
    assign Shift_Out = Data_Out[0];

endmodule



module dreg(
    input logic Clk, Reset, Load_d, Data_in,
    output logic Data_out
);
    always_ff @(posedge Clk) 
    begin
        if (Reset)
            Data_out <= 1'b0;
        else if (Load_d)
            Data_out <= Data_in;
        else
            Data_out <= Data_out;
    end
endmodule

