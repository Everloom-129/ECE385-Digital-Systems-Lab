module color_mapper (
    input [4:0] is_ball,            // Whether current pixel belongs to ball 
    input [9:0] DrawX_in, DrawY_in, // Current pixel coordinates
    output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
);

    logic [7:0] Red, Green, Blue;
    logic [15:0] idx, ece385_idx;

    // 已有背景图像数据
    logic [7:0] R_bg [0:3008];
    logic [7:0] G_bg [0:3008];
    logic [7:0] B_bg [0:3008];

    // 新增 ece385 icon 图像数据
    logic [7:0] R_ece385 [0:1023];
    logic [7:0] G_ece385 [0:1023];
    logic [7:0] B_ece385 [0:1023];

    initial begin
        $readmemh("resource/flower64R.txt", R_bg);
        $readmemh("resource/flower64G.txt", G_bg);
        $readmemh("resource/flower64B.txt", B_bg);
        $readmemh("resource/ece385R.txt", R_ece385);
        $readmemh("resource/ece385G.txt", G_ece385);
        $readmemh("resource/ece385B.txt", B_ece385);
    end

    // 计算背景图像索引
    assign idx = (DrawY_in / 4) * 64 + (DrawX_in / 4);

    // 计算 ece385 icon 的索引
    // 右下角显示，假设 ece385 icon 尺寸为 32x32
    always_comb begin
        if ((DrawX_in >= 608) && (DrawY_in >= 448)) begin  // 右下角偏移量
            ece385_idx = (DrawY_in - 448) * 32 + (DrawX_in - 608);
        end else begin
            ece385_idx = 0;
        end
    end

    // 选择颜色数据
    always_comb begin
        if ((DrawX_in >= 608) && (DrawY_in >= 448) && (ece385_idx < 1024)) begin
            Red = R_ece385[ece385_idx];
            Green = G_ece385[ece385_idx];
            Blue = B_ece385[ece385_idx];
        end else begin
            Red = R_bg[idx];
            Green = G_bg[idx];
            Blue = B_bg[idx];
        end
    end

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

    // 根据 is_ball 信号分配颜色
    always_comb begin
        if (is_ball == 5'b00001) begin
            // White ball
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end else if (is_ball == 5'b00010) begin
            // Red ball
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
        end else if (is_ball == 5'b00011) begin
            // Green ball
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
        end else if (is_ball == 5'b00100) begin
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'hff;
        end else begin
            // 背景图像数据
            if ((DrawX_in >= 608) && (DrawY_in >= 448) && (ece385_idx < 1024)) begin
                Red = R_ece385[ece385_idx];
                Green = G_ece385[ece385_idx];
                Blue = B_ece385[ece385_idx];
            end else begin
                Red = R_bg[idx];
                Green = G_bg[idx];
                Blue = B_bg[idx];
            end
        end
    end
endmodule
