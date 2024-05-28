module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    logic [3:0] PG, GG;
    compute_4bit_PG_GG get_PG_GG_0(.P(A[3:0]), .G(B[3:0]), .PG(PG[0]), .GG(GG[0]));
    compute_4bit_PG_GG get_PG_GG_1(.P(A[7:4]), .G(B[7:4]), .PG(PG[1]), .GG(GG[1]));
    compute_4bit_PG_GG get_PG_GG_2(.P(A[11:8]), .G(B[11:8]), .PG(PG[2]), .GG(GG[2]));
    compute_4bit_PG_GG get_PG_GG_3(.P(A[15:12]), .G(B[15:12]), .PG(PG[3]), .GG(GG[3]));

    logic [3:0] C_4;
    carry_lookahead_adder_4bit_helper_compute_carry get_c_4(.P(PG), .G(GG), .C_in(1'b0), .C(C_4));

    logic [3:0] rubbish;
    carry_lookahead_adder_4bit get_sum_0(.A(A[3:0]), .B(B[3:0]), .C_in(1'b0), .Sum(Sum[3:0]), .CO(rubbish[0]));
    carry_lookahead_adder_4bit get_sum_1(.A(A[7:4]), .B(B[7:4]), .C_in(C_4[0]), .Sum(Sum[7:4]), .CO(rubbish[1]));
    carry_lookahead_adder_4bit get_sum_2(.A(A[11:8]), .B(B[11:8]), .C_in(C_4[1]), .Sum(Sum[11:8]), .CO(rubbish[2]));
    carry_lookahead_adder_4bit get_sum_3(.A(A[15:12]), .B(B[15:12]), .C_in(C_4[2]), .Sum(Sum[15:12]), .CO(rubbish[3]));

    assign CO = C_4[3];


endmodule



module compute_4bit_PG_GG
(
    input   logic[3:0]     P,
    input   logic[3:0]     G,
    output  logic         PG,
    output  logic         GG
);

    assign PG = P[0] & P[1] & P[2] & P[3];
    assign GG = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]);

endmodule



module carry_lookahead_adder_4bit
(
    input   logic[3:0]     A,
    input   logic[3:0]     B,
    input   logic          C_in,
    output  logic[3:0]     Sum,
    output  logic          CO
);

    logic [3:0] G, P, C;

    assign G=A&B;
    assign P=A^B;

    carry_lookahead_adder_4bit_helper_compute_carry get_c(.P(P), .G(G), .C_in(C_in), .C(C));

    assign Sum[0] = P[0] ^ C_in;
    assign Sum[1] = P[1] ^ C[0];
    assign Sum[2] = P[2] ^ C[1];
    assign Sum[3] = P[3] ^ C[2];
    assign CO = C[3];

endmodule



module carry_lookahead_adder_4bit_helper_compute_carry
(
    input   logic[3:0]     P,
    input   logic[3:0]     G,
    input   logic          C_in,
    output  logic[3:0]     C
);

    assign C[0]=G[0] | (P[0] & C_in);
    assign C[1]=G[1] | (P[1] & C[0]);
    assign C[2]=G[2] | (P[2] & C[1]);
    assign C[3]=G[3] | (P[3] & C[2]);

endmodule
