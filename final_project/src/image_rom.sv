// 读取黑白图片，没有彩色多通道图层，VGA里不好用
module image_rom (
    input logic [9:0] address,
    output logic [23:0] data  // 假设每个像素为24位（8位红色、8位绿色、8位蓝色）
);
    logic [23:0] rom [0:3008]; // 假设图像大小为32x32，存储1024个像素，每个像素24位

    initial begin
        $readmemh("./resource/flower64.txt", rom);  // 从转换工具生成的Hex文件加载数据
    end

    assign data = rom[address];
endmodule
