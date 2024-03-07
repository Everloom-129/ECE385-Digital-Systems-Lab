module lab4_adders_toplevel(
    input logic Clk,
    input logic Reset,
    input logic Load_B,
    input logic Run,
    input logic [15:0] SW,
    output logic CO,
    output logic [15:0] Sum,
    output logic [6:0] Ahex0, Ahex1, Ahex2, Ahex3, 
    output logic [6:0] Bhex0, Bhex1, Bhex2, Bhex3
);

    // 内部信号
    logic [15:0] A, B;
    logic [3:0] PG, GG; // 组传播和生成信号
    logic [3:0] carry_out; // 每4位部分的进位输出

    // 实例化四个四位超前进位加法器单元
    four_bit_cla cla0 (
        .A(SW[3:0]),
        .B(B[3:0]),
        .Cin(Reset),  // 对于最低4位，Cin由Reset控制
        .Sum(Sum[3:0]),
        .Cout(carry_out[0]),
        .PG(PG[0]),
        .GG(GG[0])
    );

    // 其余的CLA单元类似实例化，注意Cin连接到上一级的Cout
    // ...

    // 用于显示的十六进制转换模块（需要额外实现）
    hex_display h0 (.binary(SW[3:0]), .hex(Ahex0));
    hex_display h1 (.binary(SW[7:4]), .hex(Ahex1));
    hex_display h2 (.binary(SW[11:8]), .hex(Ahex2));
    hex_display h3 (.binary(SW[15:12]), .hex(Ahex3));
    // B寄存器的显示同理
    // ...

    // 控制逻辑
    always_ff @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // 重置逻辑
            A <= 0;
            B <= 0;
        end else if (Load_B) begin
            // 载入B寄存器的逻辑
            B <= SW;
        end else if (Run) begin
            // 运行加法器的逻辑
            A <= SW;
            // 执行加法操作，这可能需要进一步的控制逻辑
        end
    end

    // 更新Sum和CO的逻辑（可能需要额外的控制逻辑来处理溢出等）
    // ...

endmodule

module four_bit_cla(
    input logic [3:0] A,
    input logic [3:0] B,
    input logic Cin,
    output logic [3:0] Sum,
    output logic Cout,
    output logic PG,
    output logic GG
);
    // 超前进位加法器的内部逻辑
    // ...

endmodule

module hex_display(
    input logic [3:0] binary,
    output logic [6:0] hex
);
    // 二进制到七段显示的转换逻辑
    // ...

endmodule
