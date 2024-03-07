module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    logic [3:0] C4;
    assign C4[0]=1'b0;

    full_adder_4bit adder0(.x(A[3:0]), .y(B[3:0]), .cin(C4[0]), .s(Sum[3:0]), .cout(C4[1]));
    carry_select_adder_4bit_unit adder1(.A(A[7:4]), .B(B[7:4]), .C_in(C4[1]), .Sum(Sum[7:4]), .CO(C4[2]));
    carry_select_adder_4bit_unit adder2(.A(A[11:8]), .B(B[11:8]), .C_in(C4[2]), .Sum(Sum[11:8]), .CO(C4[3]));
    carry_select_adder_4bit_unit adder3(.A(A[15:12]), .B(B[15:12]), .C_in(C4[3]), .Sum(Sum[15:12]), .CO(CO));
     
endmodule



module carry_select_adder_4bit_unit
(
    input   logic[3:0]     A,
    input   logic[3:0]     B,
    input   logic          C_in,
    output  logic[3:0]     Sum,
    output  logic          CO
);

    logic [3:0] Sum0, Sum1;
    logic CO0, CO1;

    full_adder_4bit adder0(.x(A), .y(B), .cin(1'b0), .s(Sum0), .cout(CO0));
    full_adder_4bit adder1(.x(A), .y(B), .cin(1'b1), .s(Sum1), .cout(CO1));

    assign {CO, Sum} = C_in ? {CO1, Sum1} : {CO0, Sum0};

endmodule
