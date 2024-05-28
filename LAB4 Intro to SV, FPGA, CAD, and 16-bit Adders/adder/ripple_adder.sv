module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    logic c0, c1, c2;
    full_adder_4bit fa0(.x(A[3:0]), .y(B[3:0]), .cin(1'b0), .s(Sum[3:0]), .cout(c0));
    full_adder_4bit fa1(.x(A[7:4]), .y(B[7:4]), .cin(c0), .s(Sum[7:4]), .cout(c1));
    full_adder_4bit fa2(.x(A[11:8]), .y(B[11:8]), .cin(c1), .s(Sum[11:8]), .cout(c2));
    full_adder_4bit fa3(.x(A[15:12]), .y(B[15:12]), .cin(c2), .s(Sum[15:12]), .cout(CO));

     
endmodule




// helper modules

module full_adder_4bit
(
    input   logic[3:0]     x,
    input   logic[3:0]     y,
    input   logic          cin,
    output  logic[3:0]     s,
    output  logic          cout
);
    
        /* TODO
        *
        * Insert code here to implement a 4-bit adder.
        * Your code should be completly combinational (don't use always_ff or always_latch).
        * Feel free to create sub-modules or other files. */
    
    logic c0, c1, c2;
    full_adder fa0(x[0], y[0], cin, s[0], c0);
    full_adder fa1(x[1], y[1], c0, s[1], c1);
    full_adder fa2(x[2], y[2], c1, s[2], c2);
    full_adder fa3(x[3], y[3], c2, s[3], cout);
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
