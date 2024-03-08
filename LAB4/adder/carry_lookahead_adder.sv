module carry_lookahead_adder (
    input  logic [15:0] A,
    input  logic [15:0] B,
    input  logic        Cin,
    output logic [15:0] Sum,
    output logic        CO
);

  /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

  logic C4, C8, C12;
  logic [3:0] Pg, Gg;

  // Carry signals
  assign C4 = Gg[0] | (Pg[0] & Cin);
  assign C8 = Gg[1] | (Pg[1] & Gg[0]) | (Pg[1] & Pg[0] & Cin);
  assign C12 = Gg[2] | (Pg[2] & Gg[1]) | (Pg[2] & Pg[1] & Gg[0]) | (Pg[2] & Pg[1] & Pg[0] & Cin);
  assign CO  = Gg[3] | (Pg[3] & Gg[2]) | (Pg[3] & Pg[2] & Gg[1]) | (Pg[3] & Pg[2] & Pg[1] & Gg[0]) | (Pg[3] & Pg[2] & Pg[1] & Pg[0] & Cin);


  four_cla cla4_0 (
      .A  (A[3:0]),
      .B  (B[3:0]),
      .Cin(Cin),
      .Sum(Sum[3:0]),
      .Pg (Pg[0]),
      .Gg (Gg[0])
  );
  four_cla cla4_1 (
      .A  (A[7:4]),
      .B  (B[7:4]),
      .Cin(C4),
      .Sum(Sum[7:4]),
      .Pg (Pg[1]),
      .Gg (Gg[1])
  );
  four_cla cla4_2 (
      .A  (A[11:8]),
      .B  (B[11:8]),
      .Cin(C8),
      .Sum(Sum[11:8]),
      .Pg (Pg[2]),
      .Gg (Gg[2])
  );
  four_cla cla4_3 (
      .A  (A[15:12]),
      .B  (B[15:12]),
      .Cin(C12),
      .Sum(Sum[15:12]),
      .Pg (Pg[3]),
      .Gg (Gg[3])
  );

endmodule



module four_cla (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic       Cin,
    output logic [3:0] Sum,
    output logic       Cout,
    output logic       Pg,
    output logic       Gg
);

  logic [3:0] P, G;  // Propagate and Generate
  logic [4:0] C;  // Carry

  assign P = A | B;  // propagating only if A or B is high
  assign G = A & B;  // generating if both A and B are high

  // Carry signals
  assign C[0] = Cin;
  assign C[1] = G[0] | (P[0] & Cin);
  assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
  assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
  assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);


  assign Sum = A ^ B ^ C[3:0];
  assign Cout = C[4];
  assign Pg = P[0] & P[1] & P[2] & P[3];
  assign Gg = G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];

endmodule
