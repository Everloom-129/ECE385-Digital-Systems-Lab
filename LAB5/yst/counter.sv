module counter_5_bits(
    input logic Clk, Reset,
    output logic[4:0] count,
    output logic time_15,
    output logic wait_flag
);

logic[4:0] next_count;

full_adder FA0(.x(count[0]), .y(1'b1), .cin(1'b0), .s(next_count[0]), .cout(cout0));
full_adder FA1(.x(count[1]), .y(1'b0), .cin(cout0), .s(next_count[1]), .cout(cout1));
full_adder FA2(.x(count[2]), .y(1'b0), .cin(cout1), .s(next_count[2]), .cout(cout2));
full_adder FA3(.x(count[3]), .y(1'b0), .cin(cout2), .s(next_count[3]), .cout(cout3));
full_adder FA4(.x(count[4]), .y(1'b0), .cin(cout3), .s(next_count[4]), .cout(cout4));


assign time_15 = (count == 5'b01110); 
assign wait_flag = (count >= 5'b10000); 

always_ff @(posedge Clk or posedge Reset) 
    begin

        if (Reset) 
            count <= 5'b0;

        else if (!wait_flag)
            count <= next_count; 
            
    end

endmodule
