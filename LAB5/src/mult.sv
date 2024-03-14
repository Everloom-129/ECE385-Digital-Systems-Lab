module mult
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


