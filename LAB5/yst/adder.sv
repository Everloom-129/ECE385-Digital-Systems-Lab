module adder_8bits_with_Subtract(
    input logic[7:0] a, 
    input logic[7:0] b, 
    input logic subtract, 
    output logic[8:0] result, 
    output logic carry_out  
);
    logic[7:0] b_adjusted;
    logic b_cin; 

    assign b_adjusted = b ^ {8{subtract}};
    assign b_cin = subtract; 

    full_adder_8bits apply_add(a, b_adjusted, b_cin, result[7:0], carry_out);

    assign a7 = a[7];
    assign b7 = b[7];

    full_adder fa8(a7, b7, b_cin, result[8], carry_out);

endmodule




module full_adder_8bits(
    input logic[7:0] a, 
    input logic[7:0] b, 
    input logic cin, 
    output logic[7:0] s, 
    output logic cout 
);
    logic[7:0] s_int;
    logic[7:0] cout_int; 

    full_adder fa0(a[0], b[0], cin, s_int[0], cout_int[0]);
    full_adder fa1(a[1], b[1], cout_int[0], s_int[1], cout_int[1]);
    full_adder fa2(a[2], b[2], cout_int[1], s_int[2], cout_int[2]);
    full_adder fa3(a[3], b[3], cout_int[2], s_int[3], cout_int[3]);
    full_adder fa4(a[4], b[4], cout_int[3], s_int[4], cout_int[4]);
    full_adder fa5(a[5], b[5], cout_int[4], s_int[5], cout_int[5]);
    full_adder fa6(a[6], b[6], cout_int[5], s_int[6], cout_int[6]);
    full_adder fa7(a[7], b[7], cout_int[6], s_int[7], cout_int[7]);


    assign s = s_int;
    assign cout = cout_int[7];

endmodule



module full_adder
(
    input   logic       x,
    input   logic       y,
    input   logic       cin,
    output  logic       s,
    output  logic       cout
);

    assign s = x ^ y ^ cin;
    assign cout = (x & y) | (x & cin) | (y & cin);

endmodule

    