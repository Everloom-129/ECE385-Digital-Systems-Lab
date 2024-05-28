### 俄罗斯方块消除整行的逻辑

为了实现俄罗斯方块的整行消除功能，我们需要在每一帧检测是否有完整的一行，然后将这些行删除并将上面的所有行下移。以下是实现此逻辑的思路和代码示例：

#### 步骤：

1. **检测完整行**：
    - 遍历所有行，检查每行是否已被完全填满。
  
2. **消除完整行并下移上面的行**：
    - 对于每个被填满的行，将其上面的所有行下移一行。

3. **更新背景图层**：
    - 在消除行后更新背景图层以反映新的块位置。

### 代码实现

#### 更新`ball.sv`

我们需要添加一个新的模块 `line_clear`，并在 `ball` 模块中调用它：

```systemverilog
module ball (
    input Clk,                          // 50 MHz clock
    input Reset,                        // Active-high reset signal
    input frame_clk,                    // The clock indicating a new frame (~60Hz)
    input [9:0] DrawX, DrawY,           // Current pixel coordinates
    input [7:0] keycode,
    output logic [4:0] is_ball          // Whether current pixel belongs to ball or background
);

    reg [19:0] block_memory [29:0];      // Memory of stored blocks, containing 30 elements each 20 bits wide
    reg [19:0] moving_block_ground [29:0];  // Memory of moving blocks, containing 30 rows each 20 bits wide
    wire [19:0] mbg_wire [29:0];         // Wire for inout connection

    logic [5:0] block_type;
    logic enable_choose;
    reg [5:0] block_x [24:0];
    reg [5:0] block_y [24:0];

    wire [5:0] block_x_try_choose [24:0];
    wire [5:0] block_y_try_choose [24:0];

    logic [1:0] left_right_shift;
    logic [1:0] up_down_shift;

    logic clear_memory;
    logic enable_update_moving_block_ground;
    
    // ... (rest of your ball module code) ...

    // Add the line_clear module
    logic enable_line_clear;
    logic [19:0] cleared_moving_block_ground [29:0];
    
    line_clear line_clear1(
        .Clk(Clk),
        .Reset(Reset),
        .enable_clear(enable_line_clear),
        .moving_block_ground(moving_block_ground),
        .cleared_moving_block_ground(cleared_moving_block_ground)
    );
    
    // Update moving_block_ground after line clear
    always_ff @(posedge Clk) begin
        if (enable_line_clear) begin
            for (int i = 0; i < 30; i++) begin
                moving_block_ground[i] <= cleared_moving_block_ground[i];
            end
        end
    end
    
    // ... (rest of your always_ff blocks and logic) ...
endmodule
```

#### `line_clear`模块

```systemverilog
module line_clear (
    input logic Clk,
    input logic Reset,
    input logic enable_clear,
    input [19:0] moving_block_ground [29:0],  // Memory of moving blocks
    output logic [19:0] cleared_moving_block_ground [29:0] // Cleared memory of moving blocks
);

    always_ff @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            for (int i = 0; i < 30; i++) begin
                cleared_moving_block_ground[i] <= 20'h00000;
            end
        end else if (enable_clear) begin
            int i, j, k;
            // Copy moving_block_ground to cleared_moving_block_ground
            for (i = 0; i < 30; i++) begin
                cleared_moving_block_ground[i] <= moving_block_ground[i];
            end

            // Check each row for full lines
            for (i = 0; i < 30; i++) begin
                if (moving_block_ground[i] == 20'hFFFFF) begin  // Line is full
                    // Move all rows above down by one
                    for (j = i; j > 0; j--) begin
                        cleared_moving_block_ground[j] <= moving_block_ground[j-1];
                    end
                    cleared_moving_block_ground[0] <= 20'h00000; // Top row is now empty
                end
            end
        end
    end

endmodule
```

### 总结

通过以上步骤，我们实现了俄罗斯方块的整行消除功能。当一行被填满时，`line_clear` 模块会检测到并消除该行，然后将其上面的所有行下移一行，并更新背景图层。这种方法确保了消除整行的操作在FPGA的时序内快速完成。