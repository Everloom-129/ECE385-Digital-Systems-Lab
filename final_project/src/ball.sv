//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------

module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]	  keycode,
               output logic [4:0] is_ball             // Whether current pixel belongs to ball or background
              );
    
    // parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    // parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
    // parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis 0
    // parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis 639
    // parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis 0
    // parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis 479

    reg [19:0] block_memory [29:0];  // Memory of stored blocks, containing 30 elements each 20 bits wide
    reg [19:0] moving_block_ground [29:0];  // Memory of moving blocks, containing 30 rows each 20 bits wide
    wire [19:0] mbg_wire [29:0];       // Wire for inout connection

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
    

    choose_block block1(.Clk(Clk),.block_type(block_type),.enable_choose(enable_choose),.block_x(block_x_try_choose),.block_y(block_y_try_choose));
    //up_down_shift_block up_down_shift_block1(.block_x(block_x),.block_y(block_y),.up_down_shift(up_down_shift),.block_try_x(block_x),.block_try_y(block_y));
    memory_block_on_moving_block_ground memory_block_on_moving_block_ground1(.Clk(Clk),.write_enable(enable_update_moving_block_ground),.block_x(block_x),.block_y(block_y),.moving_block_ground(mbg_wire));

    ///////
    logic [4:0] is_ball0_color_order, is_ball1_color_order, is_ball2_color_order, is_ball3_color_order;
    assign is_ball0_color_order = 5'b00001;
    assign is_ball1_color_order = 5'b00010;
    assign is_ball2_color_order = 5'b00011;
    assign is_ball3_color_order = 5'b00100;

    ///////

    //////////////
    logic enable_update_score_ground;
    reg [39:0] score_ground1 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire1 [59:0];       // Wire for inout connection
    reg [39:0] score_ground2 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire2 [59:0];       // Wire for inout connection
    reg [39:0] score_ground3 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire3 [59:0];       // Wire for inout connection
    logic [5:0] init_x_1, init_y_1, init_x_2, init_y_2, init_x_3, init_y_3;
    reg [5:0] block_x_1 [33:0], block_y_1 [33:0], block_x_2 [33:0], block_y_2 [33:0], block_x_3 [33:0], block_y_3 [33:0];
    wire [5:0] block_x_1_try_choose [33:0], block_y_1_try_choose [33:0], block_x_2_try_choose [33:0], block_y_2_try_choose [33:0], block_x_3_try_choose [33:0], block_y_3_try_choose [33:0];

    assign init_x_1 = 6'd10;
    assign init_y_1 = 6'd20;
    assign init_x_2 = 6'd18;
    assign init_y_2 = 6'd20;
    assign init_x_3 = 6'd26;
    assign init_y_3 = 6'd20;

    logic [5:0] num1, num2, num3;
    //assign num1 = 6'd0;
    assign num2 = 6'd8;
    assign num3 = 6'd5;

    choose_num_score score_block_1(.Clk(Clk),.block_type(num1),.init_x(init_x_1),.init_y(init_y_1),.block_x(block_x_1_try_choose),.block_y(block_y_1_try_choose));
    choose_num_score score_block_2(.Clk(Clk),.block_type(num2),.init_x(init_x_2),.init_y(init_y_2),.block_x(block_x_2_try_choose),.block_y(block_y_2_try_choose));
    choose_num_score score_block_3(.Clk(Clk),.block_type(num3),.init_x(init_x_3),.init_y(init_y_3),.block_x(block_x_3_try_choose),.block_y(block_y_3_try_choose));
    memory_num_on_score_ground memory_block_on_score_ground1(.Clk(Clk),.block_x(block_x_1),.block_y(block_y_1),.score_ground(score_ground_wire1));
    memory_num_on_score_ground memory_block_on_score_ground2(.Clk(Clk),.block_x(block_x_2),.block_y(block_y_2),.score_ground(score_ground_wire2));
    memory_num_on_score_ground memory_block_on_score_ground3(.Clk(Clk),.block_x(block_x_3),.block_y(block_y_3),.score_ground(score_ground_wire3));


    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk

    wire [5:0] block_x_try_rotation [24:0];
    wire [5:0] block_y_try_rotation [24:0];
    reg  [5:0] reg_block_x_try_rotation [24:0];
    reg  [5:0] reg_block_y_try_rotation [24:0];
    logic enable_rotation;
    logic enable_control;
    logic [1:0] control_command;
    //rotation_block rotation_block1(.block_x(block_x),.block_y(block_y),.enable_rotation(one_second_rising_edge),.block_try_x(block_x_try_rotation),.block_try_y(block_y_try_rotation));

    logic ask_control;
    always_comb
    begin
        case(keypress)
            // W rotation
            10'd26:
                begin
                    control_command = 2'b00;
                    ask_control=1'b1;
                end
            // S down
            10'd22:
                begin
                    control_command = 2'b11;
                    ask_control=1'b1;
                end

            // A left
            10'd4:
                begin
                    control_command = 2'b10;
                    ask_control=1'b1;
                end

            // D right
            10'd7:
                begin
                    control_command = 2'b01;
                    ask_control=1'b1;
                end
            default:
                begin
                    control_command = 2'b00;
                    ask_control=1'b0;
                end
        endcase
    end

    logic disable_control;

    // always_comb begin
    //     enable_control = 1'b0; // Default value
    //     if (ask_control) begin
    //         enable_control = 1'b1;
    //     end
    // end


//                 endcase 
    logic conflict;
    logic enable_check_conflict;
    logic enable_control_hold_on;
    logic [1:0] control_command_hold_on;
    
    ControlModule controlModule(.clk(Clk),.ask_control(ask_control),.control_command(control_command),.frame_clk_rising_edge(frame_clk_rising_edge),.enable_control_hold_on(enable_control_hold_on),.output_control_command(control_command_hold_on));
    control_block control_block1(.block_x(block_x),.block_y(block_y),.control_command(control_command_hold_on),.ask_control(enable_control_hold_on),.block_try_x(reg_block_x_try_rotation),.block_try_y(reg_block_y_try_rotation), .conflict(conflict));
    //allow_control_check allow_control_check1(.block_x(reg_block_x_try_rotation),.block_y(reg_block_y_try_rotation),.conflict(conflict),.enable_check_conflict(frame_clk_rising_edge));
    timer timer1(.clk(one_second_rising_edge),.Reset(Reset),.enable_choose(enable_choose),.enable_control(enable_control));

    logic [9:0] keypress;
    keypress_generator keypress_generator1(.clk(frame_clk_rising_edge),.reset(Reset),.keypress(keypress));


    logic frame_clk_delayed, frame_clk_rising_edge;


    logic [19:0] frame_clk_rising_edge_count=20'b0;

    logic one_second_rising_edge; // 输出信号，表示一秒钟的时钟边缘
    logic zpo_rising_edge; // 输出信号，表示0.1秒钟的时钟边缘
    reg [5:0] edge_count = 0;     // 6-bit 计数器足以计数至 50

    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);

        // 当检测到 frame_clk 的上升沿时
        if (frame_clk_rising_edge) begin
            edge_count <= edge_count + 1; // 增加计数器
            // 当计数器达到 50 时
            if (edge_count == 50) begin
                one_second_rising_edge <= 1'b1; // 设置 one_second_rising_edge 为高
                edge_count <= 0;               // 重置计数器
            end 
            else begin
                one_second_rising_edge <= 1'b0; // 其他情况保持 one_second_rising_edge 为低
            end

            if (edge_count == 5) begin
                zpo_rising_edge <= 1'b1; // 设置 zpo_rising_edge 为高
            end 
            else begin
                zpo_rising_edge <= 1'b0; // 其他情况保持 zpo_rising_edge 为低
            end
        end else begin
            one_second_rising_edge <= 1'b0; // 如果没有 frame_clk 上升沿，确保输出保持低
            zpo_rising_edge <= 1'b0; // 如果没有 frame_clk 上升沿，确保输出保持低
        end
    end

    always_ff @ (posedge frame_clk_rising_edge) begin
        frame_clk_rising_edge_count+=1'b1;
    end

    always_ff @ (posedge one_second_rising_edge) begin
        if (Reset) begin
            num1 = 6'd0;
            //enable_rotation=1'b0;
        end
        else begin 
            num1 = 6'd3;
            //enable_rotation=1'b1;
        end
    end

    logic finish_control;
    always_ff @(posedge zpo_rising_edge) begin
        if (Reset) begin
            // Reset逻辑
            //finish_control <= 1'b1;

        end else begin
            

            if (enable_choose) begin
                for (int i = 0; i < 25; i = i + 1) begin
                    block_x[i] <= block_x_try_choose[i];
                    block_y[i] <= block_y_try_choose[i];
                end
                //finish_control <= 1'b0;
            end else if (enable_control) begin
                if (conflict==0) begin
                    for (int i=0; i<25; i=i+1) begin
                        block_x[i] = reg_block_x_try_rotation[i];
                        block_y[i] = reg_block_y_try_rotation[i];
                    end
                end

                // // 先进行越界检测
                // logic valid = 1; // 假设所有块都没有越界
                // for (int i = 0; i < 25; i = i + 1) begin
                //     if (block_x_try_rotation[i] != 6'b111111 && block_y_try_rotation[i] != 6'b111111) begin
                //         if (block_x_try_rotation[i] > 19 || block_y_try_rotation[i] > 29) begin
                //             valid = 0; // 发现越界块
                //             break; // 退出循环
                //         end
                //     end
                // end
                
                // // 如果没有越界块，则更新块位置
                // if (valid) begin
                //     for (int i = 0; i < 25; i = i + 1) begin
                //         block_x[i] = block_x_try_rotation[i];
                //         block_y[i] = block_y_try_rotation[i];
                //     end
                // end

                // finish_control = 1'b1;
            end
            else begin
                //finish_control <= 1'b0;
            end
        end
    end


    // Update registers
    always_ff @ (posedge Clk)
    begin
        // for (int i=0; i<25; i=i+1) 
        // begin
        //     reg_block_x_try_rotation[i] = block_x_try_rotation[i];
        //     reg_block_x_try_rotation[i] = block_y_try_rotation[i];
        // end
        is_ball <= is_ball0 | is_ball1 | is_ball2 | is_ball3;
        if (Reset) begin
            // block_type<=6'b000000;
            for (int i = 0; i < 30; i = i + 1) begin
                moving_block_ground[i] <= 20'h00000;  // Clear memory array
            end
            //////
            for (int i =0; i<60; i=i+1) begin
                score_ground1[i] <= 40'h00000000;  // Clear memory array
            end
            for (int i =0; i<60; i=i+1) begin
                score_ground2[i] <= 40'h00000000;  // Clear memory array
            end
            for (int i =0; i<60; i=i+1) begin
                score_ground3[i] <= 40'h00000000;  // Clear memory array
            end
            //////////
        end
        else begin
            block_type<=6'b000000; 
        end




        // if (conflict) begin
        //     enable_control=1'b0;
        // end
        // else if (ask_control) 
        // begin
        //     enable_control=1'b1;
        // end
        // // else if (keycode==0) begin
        // //     enable_control=1'b0;
        // // end
        // else 
        // begin
        //     enable_control=1'b0;
        // end



        if (enable_update_moving_block_ground) begin
            for (int i = 5; i < 30; i++) begin
                moving_block_ground[i] <= mbg_wire[i];
            end
            if (conflict) begin
                moving_block_ground[0] <= 20'h11111;
            end
            else begin
                moving_block_ground[0] <= 20'h00000;
            end
            if (enable_control) begin
                moving_block_ground[1] <= 20'h11111;
            end
            else begin
                moving_block_ground[1] <= 20'h00000;
            end
            if (ask_control) begin
                moving_block_ground[2] <= 20'h11111;
            end
            else begin
                moving_block_ground[2] <= 20'h00000;
            end
            if (finish_control) begin
                moving_block_ground[3] <= 20'h11111;
            end
            else begin
                moving_block_ground[3] <= 20'h00000;
            end
            // show block_x[1], block_y[1]
            moving_block_ground[4] = {block_x[4], block_y[4], 8'b000000};
            
        end

        ///////
        for (int i = 0; i < 60; i++) begin
            score_ground1[i] <= score_ground_wire1[i];
            score_ground2[i] <= score_ground_wire2[i];
            score_ground3[i] <= score_ground_wire3[i];
        end
        for (int i=0; i<34; i=i+1) begin
                block_x_1[i]<=block_x_1_try_choose[i];
                block_y_1[i]<=block_y_1_try_choose[i];
                block_x_2[i]<=block_x_2_try_choose[i];
                block_y_2[i]<=block_y_2_try_choose[i];
                block_x_3[i]<=block_x_3_try_choose[i];
                block_y_3[i]<=block_y_3_try_choose[i];
        end
        /////


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        enable_update_moving_block_ground=1'b1;
        enable_update_score_ground=1'b1;
        
        // // Update position and motion only at rising edge of frame clock
        // if(frame_clk_rising_edge_count[11:0]==12'h001 && frame_clk_rising_edge) 
        // begin
        //     //up_down_shift=2'b00;
        //     //enable_rotation=1'b0;
        //     enable_choose=1'b1;
        // end
        // else begin
        //     //up_down_shift=2'b00;
        //     //enable_rotation=1'b1;
        //     enable_choose=1'b0;
        // end
    end


    logic [4:0] is_ball0, is_ball1, is_ball2, is_ball3;
    draw_ground draw_moving_block_ground(.frame_clk(frame_clk),.DrawX(DrawX),.DrawY(DrawY),.moving_block_ground(moving_block_ground),.is_ball_color(is_ball0_color_order),.is_ball(is_ball0));
    draw_score draw_score_ground1(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground1),.is_ball_color(is_ball1_color_order),.is_ball(is_ball1));
    draw_score draw_score_ground2(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground2),.is_ball_color(is_ball2_color_order),.is_ball(is_ball2));
    draw_score draw_score_ground3(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground3),.is_ball_color(is_ball3_color_order),.is_ball(is_ball3));
    draw_icon draw_ece385_icon(
        .frame_clk(frame_clk),
        .DrawX_in(DrawX),
        .DrawY_in(DrawY),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B)
    );
endmodule

module ControlModule(
    input clk,
    input ask_control,
    input [1:0] control_command,
    input frame_clk_rising_edge,
    output reg enable_control_hold_on,
    output reg [1:0] output_control_command
);

    reg [1:0] stored_command;
    reg last_ask_control;
    reg frame_clk_rising_edge_last;

    // 初始状态
    initial begin
        enable_control_hold_on = 0;
        last_ask_control = 0;
        frame_clk_rising_edge_last = 0;
        stored_command = 0;
        output_control_command = 0;
    end

    // 主逻辑
    always @(posedge clk) begin
        // 检测ask_control的上升沿
        if (ask_control && !last_ask_control) begin
            stored_command <= control_command; // 锁存控制命令
            enable_control_hold_on <= 1;        // 激活enable信号
        end
        last_ask_control <= ask_control; // 更新last_ask_control

        // 输出控制命令
        output_control_command <= stored_command;

        // 在frame_clk_rising_edge的下一个上升沿后停止enable_control_hold_on
        if (frame_clk_rising_edge && !frame_clk_rising_edge_last) begin
            if (enable_control_hold_on) begin
                enable_control_hold_on <= 0;
            end
        end
        frame_clk_rising_edge_last <= frame_clk_rising_edge;
    end

endmodule


module keypress_generator(
    input clk,    // 时钟信号
    input reset,  // 复位信号
    output reg [9:0] keypress  // 按键输出，10位宽
);

// 假设系统时钟频率为50MHz
localparam CLOCK_FREQ = 50_000_000;
// 每秒钟的时钟周期数
localparam COUNTER_MAX = 20;
// 按键列表
logic [9:0] KEYS [10:0];
// 计数器
reg [25:0] counter = 0;
// 列表索引
reg [3:0] index = 0; // 更新索引位宽以匹配KEYS数组的大小
// 状态机状态
reg generating = 1;

assign KEYS[0] = 10'd4;
assign KEYS[1] = 10'd4;
assign KEYS[2] = 10'd4;
assign KEYS[3] = 10'd4;
assign KEYS[4] = 10'd4;
assign KEYS[5] = 10'd4;
assign KEYS[6] = 10'd4;
assign KEYS[7] = 10'd4;
assign KEYS[8] = 10'd4;
assign KEYS[9] = 10'd4;
assign KEYS[10] = 10'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // 复位逻辑
        counter <= 0;
        index <= 0;
        generating <= 1;
        keypress <= 0;
    end else if (generating) begin
        if (counter < COUNTER_MAX) begin
            counter <= counter + 1;
            keypress <= 0;
        end else begin
            counter <= 0;
            // 更新按键输出
            keypress <= KEYS[index];
            // 更新索引，如果到达列表末尾则停止
            if (index < 10) begin
                index <= index + 1;
            end else begin
                generating <= 1;  // 停止生成按键
            end
        end
    end 
    else begin
        // 等待启动信号
        keypress <= 0;
    end
end

endmodule

module allow_control_check(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input logic enable_check_conflict,
    output logic conflict
);

    // 初始化conflict为0，表示没有冲突
    initial begin
        conflict = 0;
    end

    always_ff @ (posedge enable_check_conflict) begin
        conflict = 0; // 默认没有冲突
        for (int i = 1; i < 25; i = i + 1) begin
            // 检查坐标是否有效（不是6'b111111）
            if (block_x[i] != 6'b111111 && block_y[i] != 6'b111111) begin
                // 检查x和y坐标是否在指定范围内
                if (!(block_x[i] <= 19 && block_y[i] <= 29)) begin
                    conflict = 1; // 发现冲突
                    break; // 一旦发现冲突，就跳出循环
                end
            end
        end

    end

endmodule

module timer(
    input wire clk,
    input wire Reset,
    output reg enable_choose,
    output reg enable_control
    //output [1:0] control_command

);

reg [5:0] counter;  // 用于计数的寄存器，足够计数几秒

always_ff @(posedge clk or posedge Reset) begin
    if (Reset) begin
        counter <= 6'd0;  // 重置时计数器归零
        enable_choose <= 1'b0;  // 重置时enable_choose设为0
        
    end else begin
        if (counter == 6'd1) begin
            counter <= counter + 6'd1;  // 增加计数器
            enable_choose <= 1'b1;  // 在第一秒时enable_choose设为1
            // control_command <= 2'b00;  // 转
        end
        else begin
            enable_choose <= 1'b0;  // 在第一秒之后enable_choose设为0
            if (counter < 6'd63) begin  // 确保计数器不会溢出
                counter <= counter + 6'd1;
            end
            enable_control <= 1'b1;
        end
    end
end

endmodule


module control_logic_control(
    input logic clk,             // 时钟信号
    input logic reset,           // 同步复位信号
    input logic ask_control,     // 请求控制信号
    input logic finish_control,  // 完成控制信号
    output logic enable_control  // 使能控制信号
);

    // 用于检测上升沿的寄存器
    logic ask_control_prev;
    logic finish_control_prev;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // 同步复位逻辑
            enable_control <= 1'b0;
            ask_control_prev <= 1'b0;
            finish_control_prev <= 1'b0;
        end else begin
            // 更新前一个状态
            ask_control_prev <= ask_control;
            finish_control_prev <= finish_control;

            // 检测ask_control的上升沿
            if (ask_control && !ask_control_prev) begin
                enable_control <= 1'b1;
            end
            // 检测finish_control的上升沿
            else if (finish_control && !finish_control_prev) begin
                enable_control <= 1'b0;
            end
        end
    end

endmodule

module control_block(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input [1:0] control_command, // 00: rotation 01: right 10: left 11: down
    input logic ask_control,
    output [5:0] block_try_x [24:0],
    output [5:0] block_try_y [24:0],
    output conflict
);
    // Rotation center coordinates adjusted for possible 0.5 increment
    logic signed [7:0] rotation_center_X, rotation_center_Y;


    always_ff @(posedge ask_control) begin
        case
            (control_command)
            2'b00: begin
                block_try_x[0] <= block_x[0];  // Keep the rotation center the same
                block_try_y[0] <= block_y[0];
                rotation_center_X = block_x[0];  // Multiply by 2 to handle 0.5 step
                rotation_center_Y = block_y[0];  // Multiply by 2 to handle 0.5 step

                conflict <= 0;
                for (int i = 1; i < 25; i = i + 1) begin
                    if (((rotation_center_X - (block_y[i] *2) + rotation_center_Y ) /2)<0 || ((rotation_center_Y - rotation_center_X + (block_x[i] *2)) /2)<0 || ((rotation_center_X - (block_y[i] *2) + rotation_center_Y ) /2)>19 || ((rotation_center_Y - rotation_center_X + (block_x[i] *2)) /2)>39) begin
                        conflict <= 1;
                    end
                    
                    if (block_x[i] < 20 && block_y[i] < 30) begin
                        // Apply rotation transformation formula for 90 degrees CW
                        block_try_x[i] <= (rotation_center_X - (block_y[i] *2) + rotation_center_Y ) /2 ;  // Convert back from scaled values
                        block_try_y[i] <= (rotation_center_Y - rotation_center_X + (block_x[i] *2)) /2 ;  // Convert back from scaled values
                    end else begin
                        block_try_x[i] <= 6'b111111;  // Invalid block
                        block_try_y[i] <= 6'b111111;
                    end
                end
            end
            2'b01: begin
                block_try_x[0] <= block_x[0]+2;  // Keep the rotation center the same
                block_try_y[0] <= block_y[0];
                conflict <= 0;
                for (int i = 1; i < 25; i = i + 1) begin
                    if (block_x[i] == 19)
                        conflict <= 1;
                    if (block_x[i] <= 19) begin
                        block_try_x[i] <= block_x[i] + 1;
                        block_try_y[i] <= block_y[i];
                    end else begin
                        block_try_x[i] <= 6'b111111;  // Invalid block
                        block_try_y[i] <= 6'b111111;
                    end
                end
            end
            2'b10: begin
                block_try_x[0] <= block_x[0]-2;  // Keep the rotation center the same
                block_try_y[0] <= block_y[0];
                conflict <= 0;
                for (int i = 1; i < 25; i = i + 1) begin
                    if (block_x[i] == 0)
                        conflict <= 1;
                    if (block_x[i] >= 0) begin
                        block_try_x[i] <= block_x[i] - 1;
                        block_try_y[i] <= block_y[i];
                    end else begin
                        block_try_x[i] <= 6'b111111;  // Invalid block
                        block_try_y[i] <= 6'b111111;
                    end
                end
            end
            2'b11: begin
                block_try_x[0] <= block_x[0];  // Keep the rotation center the same
                block_try_y[0] <= block_y[0]-2;
                conflict <= 0;
                for (int i = 1; i < 25; i = i + 1) begin
                    if (block_y[i] == 0)
                        conflict <= 1;
                    if (block_y[i] >= 0) begin
                        block_try_x[i] <= block_x[i];
                        block_try_y[i] <= block_y[i] - 1;
                    end else begin
                        block_try_x[i] <= 6'b111111;  // Invalid block
                        block_try_y[i] <= 6'b111111;
                    end
                end
            end
        endcase
    end
endmodule



module draw_ground(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX, DrawY,            // Current pixel coordinates
    input [19:0] moving_block_ground[29:0],  // Memory of moving blocks, 30 rows each 20 bits wide
    input [4:0] is_ball_color,
    output logic [4:0]  is_ball                // Output signal if the pixel is part of a ball
);

    // Constants for dimensions
    localparam PIXELS_PER_BLOCK = 16;
    localparam BLOCKS_PER_ROW = 20;      // Number of blocks per row
    localparam SCREEN_HEIGHT = 480;
    localparam HALF_SCREEN_WIDTH = 320;

    // Compute the block index based on DrawX and DrawY
    logic [4:0] block_index_x;   // 20 blocks (0-19) across the X direction, fitting within 320 pixels (16 pixels each)
    logic [4:0] block_index_y;   // 30 blocks (0-29) down the Y direction

    // Assign block indices based on the current pixel coordinates
    always_comb begin
        block_index_x = (DrawX) / PIXELS_PER_BLOCK;  // Determine which block in the x direction
        block_index_y = (SCREEN_HEIGHT - DrawY - 1) / PIXELS_PER_BLOCK;  // Reverse Y direction

        // Ensure each block is visually distinct by checking if the pixel is not on the block's border
        if (DrawX < 320 && block_index_y < 30 && block_index_x < BLOCKS_PER_ROW) begin
            if (DrawX % PIXELS_PER_BLOCK != 0 && DrawX % PIXELS_PER_BLOCK != 15 &&
                (SCREEN_HEIGHT - DrawY - 1) % PIXELS_PER_BLOCK != 0 &&
                (SCREEN_HEIGHT - DrawY - 1) % PIXELS_PER_BLOCK != 15) begin
                // is_ball = moving_block_ground[block_index_y][block_index_x];  // Map the bit to is_ball output
                is_ball = moving_block_ground[block_index_y][block_index_x]*is_ball_color;  // Map the bit to is_ball output
            end else begin
                is_ball = 0;  // On the border, use background
                
            end
        end else begin
            is_ball = 0;  // Outside the specified area, not part of the ball
        end
    end

endmodule



// module memory_block_on_moving_block_ground(
//     input [5:0] block_x [24:0],
//     input [5:0] block_y [24:0],
//     output logic [19:0] moving_block_ground [29:0]
// );
//     always_comb begin
//         for (int i=1; i<25; i=i+1) begin
//             if (block_x[i]!=6'b111111)
//                 moving_block_ground[block_y[i]][block_x[i]]=1'b1;
//         end
//     end
// endmodule
module memory_block_on_moving_block_ground(
    input Clk,
    input logic write_enable,                  // Enable signal for writing to the memory
    input [5:0] block_x [24:0],                // Array of X coordinates for blocks
    input [5:0] block_y [24:0],                // Array of Y coordinates for blocks
    inout reg [19:0] moving_block_ground [29:0] // Memory array of moving blocks, as inout to handle internal writes and external reads
);
    integer i;

    // Writing to the memory based on the coordinates provided
    always_ff @(posedge Clk) begin
        if (write_enable) begin
            // Clear the memory first
            for (i = 0; i < 30; i = i + 1) begin
                moving_block_ground[i] <= 20'b0;
            end

            // Update the memory with new block positions
            for (i = 1; i < 25; i = i + 1) begin
                if (block_x[i] < 20 && block_y[i] < 30 && block_x[i]!= 6'b111111 && block_y[i] != 6'b111111) begin  // Check if coordinates are within the bounds
                    moving_block_ground[block_y[i]][block_x[i]] <= 1'b1;  // Set the specific bit to 1
                end
            end
        end
    end
    // If external access or handling is needed, additional logic can be added here
endmodule

module choose_block(
    input Clk,
    input [5:0] block_type,  // The type of block to be chosen
    input logic enable_choose,  // Enable signal for block selection
    output [5:0] block_x [24:0],  // X coordinates of the block
    output [5:0] block_y [24:0]  // Y coordinates of the block
);
    // The choose_block module in Verilog is designed to select a block based on the input block_type. 
    // It uses a case statement to determine the block type and assign the corresponding block coordinates 
    // to the block_x and block_y output arrays.
    
    always_ff @(posedge Clk) begin
        if (enable_choose) begin
            for (int i=0; i<25; i=i+1) begin
                block_x[i]=6'b111111;
                block_y[i]=6'b111111;
            end

            case (block_type)
                // Block type 0: I block
                6'b000000:
                    begin
                        block_x[0]<=6'd19;
                        block_y[0]<=6'd55;

                        block_x[1]<=6'd8;
                        block_y[1]<=6'd29;
                        block_x[2]<=6'd9;
                        block_y[2]<=6'd29;
                        block_x[3]<=6'd10;
                        block_y[3]<=6'd29;
                        block_x[4]<=6'd11;
                        block_y[4]<=6'd29;
                    end
                // Block type 1: L block
                6'b000001:
                    begin
                        block_x[0]<=6'd18;
                        block_y[0]<=6'd56;

                        block_x[1]<=6'd8;
                        block_y[1]<=6'd28;
                        block_x[2]<=6'd8;
                        block_y[2]<=6'd29;
                        block_x[3]<=6'd9;
                        block_y[3]<=6'd29;
                        block_x[4]<=6'd10;
                        block_y[4]<=6'd29;
                    end
                // Block type 2: z block
                6'b000010:
                    begin
                        block_x[0]<=6'd18;
                        block_y[0]<=6'd56;

                        block_x[1]<=6'd8;
                        block_y[1]<=6'd29;
                        block_x[2]<=6'd9;
                        block_y[2]<=6'd29;
                        block_x[3]<=6'd9;
                        block_y[3]<=6'd28;
                        block_x[4]<=6'd10;
                        block_y[4]<=6'd28;
                    end
                // Block type 3: O block
                6'b000011:
                    begin
                        block_x[0]<=6'd19;
                        block_y[0]<=6'd55;

                        block_x[1]<=6'd9;
                        block_y[1]<=6'd29;
                        block_x[2]<=6'd10;
                        block_y[2]<=6'd29;
                        block_x[3]<=6'd9;
                        block_y[3]<=6'd28;
                        block_x[4]<=6'd10;
                        block_y[4]<=6'd28;
                    end
                // Block type 4: S block
                // 6'b000100:
                //     begin
                //         block_x = '{6'b000000, 6'b000001, 6'b000001, 6'b000002, 6'b000000};
                //         block_y = '{6'b000000, 6'b000000, 6'b000001, 6'b000001, 6'b000001};
                //     end
            endcase
        end
    end
endmodule


