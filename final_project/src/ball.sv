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

// module  ball ( input         Clk,                // 50 MHz clock
//                              Reset,              // Active-high reset signal
//                              frame_clk,          // The clock indicating a new frame (~60Hz)
//                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
// 					input [7:0]	  keycode,
//                output logic  is_ball             // Whether current pixel belongs to ball or background
//               );
    
//     parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
//     parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
//     parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis 0
//     parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis 639
//     parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis 0
//     parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis 479
//     parameter [9:0] Ball_X_Step = 10'd1;      // Step size on the X axis
//     parameter [9:0] Ball_Y_Step = 10'd1;      // Step size on the Y axis
//     parameter [9:0] Ball_Size = 10'd40;        // Ball size
    
//     logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
//     logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    
//     //////// Do not modify the always_ff blocks. ////////
//     // Detect rising edge of frame_clk
//     logic frame_clk_delayed, frame_clk_rising_edge;


//     logic [12:0] frame_clk_rising_edge_count=13'b0;

//     always_ff @ (posedge Clk) begin
//         frame_clk_delayed <= frame_clk;
//         frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
        
//     end

//     always_ff @ (posedge frame_clk_rising_edge) begin
//         frame_clk_rising_edge_count+=1'b1;
//     end
//     // Update registers
//     always_ff @ (posedge Clk)
//     begin
//         if (Reset)
//         begin
//             Ball_X_Pos <= Ball_X_Center;
//             Ball_Y_Pos <= Ball_Y_Center;
//             Ball_X_Motion <= 10'd0;
//             Ball_Y_Motion <= Ball_Y_Step;
//         end
//         else
//         begin
//             Ball_X_Pos <= Ball_X_Pos_in;
//             Ball_Y_Pos <= Ball_Y_Pos_in;
//             Ball_X_Motion <= Ball_X_Motion_in;
//             Ball_Y_Motion <= Ball_Y_Motion_in;
//         end
//     end
//     //////// Do not modify the always_ff blocks. ////////
    
//     // You need to modify always_comb block.
//     always_comb
//     begin
//         // By default, keep motion and position unchanged
//         Ball_X_Pos_in = Ball_X_Pos;
//         Ball_Y_Pos_in = Ball_Y_Pos;
//         Ball_X_Motion_in = Ball_X_Motion;
//         Ball_Y_Motion_in = Ball_Y_Motion;
        
//         // Update position and motion only at rising edge of frame clock
//         if(frame_clk_rising_edge_count[4:0]==5'b10000 && frame_clk_rising_edge) 
//         begin
//             Ball_Y_Motion_in=10'd40;
//             Ball_X_Motion_in=10'd0;
//             if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//                 Ball_Y_Motion_in = 0;  
//             else
//                 case(keycode)
//                 // W
//                 10'd26:
//                     begin
//                     //Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
//                     //Ball_X_Motion_in = 1'b0;
//                     end
//                 // S
//                 10'd22:
//                     begin
//                     Ball_Y_Motion_in = 10'd18;
//                     Ball_X_Motion_in = 1'b0;
//                     end

//                 // A
//                 10'd4:
//                     begin
//                     Ball_X_Motion_in = (~(10'd9)+1'b1);
//                     Ball_Y_Motion_in = 1'b0;
//                     end

//                 // D
//                 10'd7:
//                     begin
//                     Ball_X_Motion_in = 10'd9;
//                     Ball_Y_Motion_in = 1'b0;
//                     end

//                 endcase


//             // Be careful when using comparators with "logic" datatype because compiler treats 
//             //   both sides of the operator as UNSIGNED numbers.
//             // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
//             // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
//             // if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//             //     Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
//             // if ( Ball_Y_Pos + Ball_Size>= Ball_Y_Max  )  // Ball is at the bottom edge, BOUNCE!
//             //     Ball_Y_Motion_in = 1'b0;
//             // // TODO: Add other boundary detections and handle keypress here.
//             // if(Ball_X_Pos + Ball_Size >= Ball_X_Max) // Ball is at the right edge, BOUNCE!
//             //     Ball_X_Motion_in = 1'b0;
//             // else if (Ball_X_Pos <= Ball_X_Min + Ball_Size) // Ball is at the left edge, BOUNCE!
//             //     Ball_X_Motion_in = 1'b0;
        
        
        
//             // Update the ball's position with its motion
//             Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
//             Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
//         end
//     end
        
//         /**************************************************************************************
//             ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
//             Hidden Question #2/2:
//                Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
//               Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
//               What is the difference between writing
//                 "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
//                 "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
//               How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
//               Give an answer in your Post-Lab.
//         **************************************************************************************/

    
//     // Compute whether the pixel corresponds to ball or background
//     /* Since the multiplicants are required to be signed, we have to first cast them
//        from logic to int (signed by default) before they are multiplied. */
//     int DistX, DistY, Size;
//     assign DistX = DrawX - Ball_X_Pos;
//     assign DistY = DrawY - Ball_Y_Pos;
//     assign Size = Ball_Size;
//     always_comb begin
//         if ( DistX*DistX<=Size*Size && DistY*DistY<=Size*Size)
//             is_ball = 1'b1;
//         else
//             is_ball = 1'b0;
//         /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
//            the single line is quite powerful descriptively, it causes the synthesis tool to use up three
//            of the 12 available multipliers on the chip! */
//     end
    
// endmodule
// https://prod.liveshare.vsengsaas.visualstudio.com/join?69649CD7D382CB16FC24EDA1F395EB43779A
module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]	  keycode,
               output logic  is_ball             // Whether current pixel belongs to ball or background
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

    wire [5:0] block_x_try_rotation [24:0];
    wire [5:0] block_y_try_rotation [24:0];

    logic [1:0] left_right_shift;
    logic [1:0] up_down_shift;

    logic clear_memory;
    logic enable_update_moving_block_ground;
    logic enable_rotation;

    choose_block block1(.Clk(Clk),.block_type(block_type),.enable_choose(enable_choose),.block_x(block_x_try_choose),.block_y(block_y_try_choose));
    //up_down_shift_block up_down_shift_block1(.block_x(block_x),.block_y(block_y),.up_down_shift(up_down_shift),.block_try_x(block_x),.block_try_y(block_y));
    memory_block_on_moving_block_ground memory_block_on_moving_block_ground1(.Clk(Clk),.write_enable(enable_update_moving_block_ground),.block_x(block_x),.block_y(block_y),.moving_block_ground(mbg_wire));



    //////////////
    logic enable_update_score_ground;
    reg [39:0] score_ground1 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire1 [59:0];       // Wire for inout connection
    reg [39:0] score_ground2 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire2 [59:0];       // Wire for inout connection
    reg [39:0] score_ground3 [59:0];  // Memory of moving blocks, 30 rows each 20 bits wide
    wire [39:0] score_ground_wire3 [59:0];       // Wire for inout connection
    logic [5:0] init_x_1, init_y_1, init_x_2, init_y_2, init_x_3, init_y_3;
    logic [5:0] block_x_1 [33:0], block_y_1 [33:0], block_x_2 [33:0], block_y_2 [33:0], block_x_3 [33:0], block_y_3 [33:0];

    assign init_x_1 = 6'd10;
    assign init_y_1 = 6'd20;
    assign init_x_2 = 6'd18;
    assign init_y_2 = 6'd20;
    assign init_x_3 = 6'd26;
    assign init_y_3 = 6'd20;

    logic [5:0] num1, num2, num3;
    assign num1 = 6'd3;
    assign num2 = 6'd8;
    assign num3 = 6'd5;

    memory_num_on_score_ground memory_block_on_score_ground1(.Clk(Clk),.block_x(block_x_1),.block_y(block_y_1),.score_ground(score_ground_wire1));
    memory_num_on_score_ground memory_block_on_score_ground2(.Clk(Clk),.block_x(block_x_2),.block_y(block_y_2),.score_ground(score_ground_wire2));
    memory_num_on_score_ground memory_block_on_score_ground3(.Clk(Clk),.block_x(block_x_3),.block_y(block_y_3),.score_ground(score_ground_wire3));
    /////////////
    //memory_three_score three_score(.Clk(Clk),.score_ground(score_ground_wire));

    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk

    // rotation_block rotation_block1(.block_x(block_x),.block_y(block_y),.enable_rotation(enable_rotation),.block_try_x(block_x_try_rotation),.block_try_y(block_y_try_rotation));

    logic frame_clk_delayed, frame_clk_rising_edge;


    logic [19:0] frame_clk_rising_edge_count=20'b0;

    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
        
    end

    always_ff @ (posedge frame_clk_rising_edge) begin
        frame_clk_rising_edge_count+=1'b1;
    end


    // Update registers
    always_ff @ (posedge Clk)
    begin
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



        if (enable_update_moving_block_ground) begin
            for (int i = 0; i < 30; i++) begin
                moving_block_ground[i] <= mbg_wire[i];
            end
        end

        ///////
        if (enable_update_score_ground) begin
            for (int i = 0; i < 60; i++) begin
                score_ground1[i] <= score_ground_wire1[i];
            end
        end
        if (enable_update_score_ground) begin
            for (int i = 0; i < 60; i++) begin
                score_ground2[i] <= score_ground_wire2[i];
            end
        end
        if (enable_update_score_ground) begin
            for (int i = 0; i < 60; i++) begin
                score_ground3[i] <= score_ground_wire3[i];
            end
        end
        /////

        if (enable_choose) begin
            for (int i=0; i<25; i=i+1) begin
                block_x[i]=block_x_try_choose[i];
                block_y[i]=block_y_try_choose[i];
            end
        end
        // else if(enable_rotation) begin
        //     for (int i=0; i<25; i=i+1) begin
        //         block_x[i]=block_x_try_rotation[i];
        //         block_y[i]=block_y_try_rotation[i];
        //     end
        // end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        enable_update_moving_block_ground=1'b1;
        enable_update_score_ground=1'b1;
        
        // Update position and motion only at rising edge of frame clock
        if(frame_clk_rising_edge_count[4:0]==5'b10000 && frame_clk_rising_edge) 
        begin
            //up_down_shift=2'b00;
            //enable_rotation=1'b0;
            enable_choose=1'b1;
        end
        else begin
            //up_down_shift=2'b00;
            //enable_rotation=1'b1;
            enable_choose=1'b0;
        end
    end

    logic  is_ball0, is_ball1, is_ball2, is_ball3;
    draw_ground draw_moving_block_ground(.frame_clk(frame_clk),.DrawX(DrawX),.DrawY(DrawY),.moving_block_ground(moving_block_ground),.is_ball(is_ball0));
    draw_score draw_score_ground1(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground1),.is_ball(is_ball1));
    draw_score draw_score_ground2(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground2),.is_ball(is_ball2));
    draw_score draw_score_ground3(.frame_clk(frame_clk),.DrawX_in(DrawX),.DrawY_in(DrawY),.score_ground(score_ground3),.is_ball(is_ball3));

endmodule

module rotation_block(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input logic enable_rotation,
    output reg [5:0] block_try_x [24:0],
    output reg [5:0] block_try_y [24:0]
);
    // Rotation center coordinates adjusted for possible 0.5 increment
    logic signed [7:0] rotation_center_X, rotation_center_Y;
    always_comb begin
        rotation_center_X = block_x[0];  // Multiply by 2 to handle 0.5 step
        rotation_center_Y = block_y[0];  // Multiply by 2 to handle 0.5 step
    end

    always_ff @(posedge enable_rotation) begin
        block_try_x[0] <= block_x[0];  // Keep the rotation center the same
        block_try_y[0] <= block_y[0];
        
        for (int i = 1; i < 25; i = i + 1) begin
            if (block_x[i] < 20 && block_y[i] < 30) begin
                // Apply rotation transformation formula for 90 degrees CW
                block_try_x[i] <= (rotation_center_X - (block_y[i] << 1) + rotation_center_Y ) >> 1;  // Convert back from scaled values
                block_try_y[i] <= (rotation_center_Y - rotation_center_X + (block_x[i] << 1)) >> 1;  // Convert back from scaled values
            end else begin
                block_try_x[i] <= 6'b111111;  // Invalid block
                block_try_y[i] <= 6'b111111;
            end
        end
    end
endmodule


module draw_ground(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX, DrawY,            // Current pixel coordinates
    input [19:0] moving_block_ground[29:0],  // Memory of moving blocks, 30 rows each 20 bits wide
    output logic is_ball                 // Output signal if the pixel is part of a ball
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
        block_index_x = (HALF_SCREEN_WIDTH- DrawX -1) / PIXELS_PER_BLOCK;  // Determine which block in the x direction
        block_index_y = (SCREEN_HEIGHT - DrawY - 1) / PIXELS_PER_BLOCK;  // Reverse Y direction

        // Ensure each block is visually distinct by checking if the pixel is not on the block's border
        if (DrawX < 320 && block_index_y < 30 && block_index_x < BLOCKS_PER_ROW) begin
            if (DrawX % PIXELS_PER_BLOCK != 0 && DrawX % PIXELS_PER_BLOCK != 15 &&
                (SCREEN_HEIGHT - DrawY - 1) % PIXELS_PER_BLOCK != 0 &&
                (SCREEN_HEIGHT - DrawY - 1) % PIXELS_PER_BLOCK != 15) begin
                is_ball = moving_block_ground[block_index_y][block_index_x];  // Map the bit to is_ball output
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

module draw_score(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX_in, DrawY_in,            // Current pixel coordinates
    input [39:0] score_ground[59:0],  // Memory of moving blocks, 30 rows each 20 bits wide
    output logic is_ball                 // Output signal if the pixel is part of a ball
);

    // Constants for dimensions
    localparam PIXELS_PER_BLOCK = 8;
    localparam BLOCKS_PER_ROW = 40;      // Number of blocks per row
    localparam BLOCKS_PER_COL = 60;      // Number of blocks per col
    localparam SCREEN_HEIGHT = 480;
    localparam HALF_SCREEN_WIDTH = 320;

    logic [9:0] DrawX, DrawY;            // Current pixel coordinates

    // Compute the block index based on DrawX and DrawY
    logic [4:0] block_index_x;   // 20 blocks (0-19) across the X direction, fitting within 320 pixels (16 pixels each)
    logic [4:0] block_index_y;   // 30 blocks (0-29) down the Y direction

    // Assign block indices based on the current pixel coordinates
    always_comb begin
        DrawX = DrawX_in -320;
        DrawY = DrawY_in;
        block_index_x = (HALF_SCREEN_WIDTH- DrawX -1) / PIXELS_PER_BLOCK;  // Determine which block in the x direction
        block_index_y = (SCREEN_HEIGHT - DrawY - 1) / PIXELS_PER_BLOCK;  // Reverse Y direction

        // Ensure each block is visually distinct by checking if the pixel is not on the block's border
        if (DrawX < 320 && block_index_y < BLOCKS_PER_COL && block_index_x < BLOCKS_PER_ROW) begin

            is_ball = score_ground[block_index_y][block_index_x];  // Map the bit to is_ball output

        end else begin
            is_ball = 0;  // Outside the specified area, not part of the ball
        end
    end
endmodule

// module memory_three_score(
//     input Clk,
//     inout [39:0] score_ground [59:0] // Memory array of moving blocks, as inout to handle internal writes and external reads
// );
//     logic [5:0] init_x_1, init_y_1, init_x_2, init_y_2, init_x_3, init_y_3;
//     logic [5:0] block_x_1 [33:0], block_y_1 [33:0], block_x_2 [33:0], block_y_2 [33:0], block_x_3 [33:0], block_y_3 [33:0];

//     assign init_x_1 = 6'd10;
//     assign init_y_1 = 6'd20;
//     assign init_x_2 = 6'd18;
//     assign init_y_2 = 6'd20;
//     assign init_x_3 = 6'd26;
//     assign init_y_3 = 6'd20;

//     logic [5:0] num1, num2, num3;
//     assign num1 = 6'd3;
//     assign num2 = 6'd8;
//     assign num3 = 6'd5;

//     wire [39:0] score_ground1 [59:0], score_ground2 [59:0], score_ground3 [59:0];

//     choose_num_score score_block_1(.Clk(Clk),.block_type(num1),.init_x(init_x_1),.init_y(init_y_1),.block_x(block_x_1),.block_y(block_y_1));
//     choose_num_score score_block_2(.Clk(Clk),.block_type(num2),.init_x(init_x_2),.init_y(init_y_2),.block_x(block_x_2),.block_y(block_y_2));
//     choose_num_score score_block_3(.Clk(Clk),.block_type(num3),.init_x(init_x_3),.init_y(init_y_3),.block_x(block_x_3),.block_y(block_y_3));

//     memory_num_on_score_ground memory_block_on_score_ground1(.Clk(Clk),.block_x(block_x_1),.block_y(block_y_1),.score_ground(score_ground1));
//     memory_num_on_score_ground memory_block_on_score_ground2(.Clk(Clk),.block_x(block_x_2),.block_y(block_y_2),.score_ground(score_ground2));
//     memory_num_on_score_ground memory_block_on_score_ground3(.Clk(Clk),.block_x(block_x_3),.block_y(block_y_3),.score_ground(score_ground3));

//     always_ff @(posedge Clk) begin
//         for (int i = 0; i < 60; i = i + 1) begin
//             score_ground[i] <= 40'b0;
//         end

//         for (int i = 0; i < 60; i = i + 1) begin
//             score_ground[i] <= score_ground1[i] | score_ground2[i] | score_ground3[i];
//         end
//     end

// endmodule

module memory_num_on_score_ground(
    input Clk,
    input [5:0] block_x [33:0],                // Array of X coordinates for blocks
    input [5:0] block_y [33:0],                // Array of Y coordinates for blocks
    inout reg [39:0] score_ground [59:0] // Memory array of moving blocks, as inout to handle internal writes and external reads
);
    integer i;

    // Writing to the memory based on the coordinates provided
    always_ff @(posedge Clk) begin

        for (i = 0; i < 60; i = i + 1) begin
            score_ground[i] <= 40'b0;
        end

        // Update the memory with new block positions
        for (i = 0; i < 34; i = i + 1) begin
            if (block_x[i] < 40 && block_y[i] < 60 && block_x[i]!= 6'b111111 && block_y[i] != 6'b111111) begin  // Check if coordinates are within the bounds
                score_ground[block_y[i]][block_x[i]] <= 1'b1;  // Set the specific bit to 1
            end
        end
    end
    // If external access or handling is needed, additional logic can be added here
endmodule

module choose_num_score(
    input Clk,
    input [5:0] block_type,  // The type of block to be chosen
    input [5:0] init_x,  // The initial x coordinate of the block
    input [5:0] init_y,  // The initial y coordinate of the block
    output [5:0] block_x [33:0],  // X coordinates of the block
    output [5:0] block_y [33:0]  // Y coordinates of the block
);
    // The choose_block module in Verilog is designed to select a block based on the input block_type. 
    // It uses a case statement to determine the block type and assign the corresponding block coordinates 
    // to the block_x and block_y output arrays.

    logic  left_bottom_edge, right_bottom_edge, left_top_edge, right_top_edge;
    logic  bottom_edge, middle_edge, top_edge;
    logic  left_bottom_point, right_bottom_point, left_top_point, right_top_point, left_middle_point, right_middle_point;
    
    always_comb begin
        case (block_type)
            // Block type 0: number 0
            6'b000000:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    left_bottom_edge=1'b1;
                    right_bottom_edge=1'b1;
                    left_top_edge=1'b1;
                    right_top_edge=1'b1;
                    bottom_edge=1'b1;                   
                    top_edge=1'b1;

                    middle_edge=1'b0;
                end
            // Block type 1: number 1
            6'b000001:
                begin
                    right_bottom_point=1'b1;
                    right_top_point=1'b1;
                    right_middle_point=1'b1;

                    right_bottom_edge=1'b1;
                    right_top_edge=1'b1;

                    left_bottom_point=1'b0;
                    left_top_point=1'b0;
                    left_middle_point=1'b0;

                    bottom_edge=1'b0;
                    middle_edge=1'b0;
                    top_edge=1'b0;
                    left_bottom_edge=1'b0;
                    left_top_edge=1'b0;

                    
                end
            // Block type 2: number 2
            6'b000010:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    left_bottom_edge=1'b1;
                    right_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;

                    right_bottom_edge=1'b0;
                    left_top_edge=1'b0;
                end
            // Block type 3: number 3
            6'b000011:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    right_bottom_edge=1'b1;
                    right_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;

                    left_bottom_edge=1'b0;
                    left_top_edge=1'b0;
                end
             // Block type 4: number 4
            6'b000100:
                begin
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    left_top_edge=1'b1;
                    right_top_edge=1'b1;
                    right_bottom_edge=1'b1;
                    middle_edge=1'b1;

                    left_bottom_point=1'b0;

                    bottom_edge=1'b0;
                    top_edge=1'b0;
                    left_bottom_edge=1'b0;
                end
             // Block type 5: number 5
            6'b000101:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    right_bottom_edge=1'b1;
                    left_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;

                    left_bottom_edge=1'b0;
                    right_top_edge=1'b0;
                end
             // Block type 6: number 6
            6'b000110:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    left_bottom_edge=1'b1;
                    right_bottom_edge=1'b1;
                    left_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;

                    right_top_edge=1'b0;
                end
             // Block type 7: number 7
            6'b000111:
                begin
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    right_middle_point=1'b1;

                    right_bottom_edge=1'b1;
                    right_top_edge=1'b1;
                    top_edge=1'b1;

                    left_bottom_point=1'b0;
                    left_middle_point=1'b0;

                    left_bottom_edge=1'b0;
                    left_top_edge=1'b0;
                    bottom_edge=1'b0;
                    middle_edge=1'b0;
                end
             // Block type 8: number 8
            6'b001000:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    left_bottom_edge=1'b1;
                    right_bottom_edge=1'b1;
                    left_top_edge=1'b1;
                    right_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;
                end
             // Block type 9: number 9
            6'b001001:
                begin
                    left_bottom_point=1'b1;
                    right_bottom_point=1'b1;
                    left_top_point=1'b1;
                    right_top_point=1'b1;
                    left_middle_point=1'b1;
                    right_middle_point=1'b1;

                    right_bottom_edge=1'b1;
                    left_top_edge=1'b1;
                    right_top_edge=1'b1;
                    bottom_edge=1'b1;
                    middle_edge=1'b1;
                    top_edge=1'b1;

                    left_bottom_edge=1'b0;
                end
        endcase
    end

    always_ff @(posedge Clk) begin
        if (left_bottom_point) begin
            block_x[0]<=init_x;
            block_y[0]<=init_y;
        end
        else begin
            block_x[0]<=6'b111111;
            block_y[0]<=6'b111111;
        end
        if (right_bottom_point) begin
            block_x[1]<=init_x+5;
            block_y[1]<=init_y;
        end
        else begin
            block_x[1]<=6'b111111;
            block_y[1]<=6'b111111;
        end
        if (left_top_point) begin
            block_x[2]<=init_x;
            block_y[2]<=init_y+10;
        end
        else begin
            block_x[2]<=6'b111111;
            block_y[2]<=6'b111111;
        end
        if (right_top_point) begin
            block_x[3]<=init_x+5;
            block_y[3]<=init_y+10;
        end
        else begin
            block_x[3]<=6'b111111;
            block_y[3]<=6'b111111;
        end
        if (left_middle_point) begin
            block_x[4]<=init_x;
            block_y[4]<=init_y+5;
        end
        else begin
            block_x[4]<=6'b111111;
            block_y[4]<=6'b111111;
        end
        if (right_middle_point) begin
            block_x[5]<=init_x+5;
            block_y[5]<=init_y+5;
        end
        else begin
            block_x[5]<=6'b111111;
            block_y[5]<=6'b111111;
        end

        if (left_bottom_edge) begin
            block_x[6]<=init_x;
            block_y[6]<=init_y+1;
            block_x[7]<=init_x;
            block_y[7]<=init_y+2;
            block_x[8]<=init_x;
            block_y[8]<=init_y+3;
            block_x[9]<=init_x;
            block_y[9]<=init_y+4;
        end
        else begin
            block_x[6]<=6'b111111;
            block_y[6]<=6'b111111;
            block_x[7]<=6'b111111;
            block_y[7]<=6'b111111;
            block_x[8]<=6'b111111;
            block_y[8]<=6'b111111;
            block_x[9]<=6'b111111;
            block_y[9]<=6'b111111;
        end
        if (right_bottom_edge) begin
            block_x[10]<=init_x+5;
            block_y[10]<=init_y+1;
            block_x[11]<=init_x+5;
            block_y[11]<=init_y+2;
            block_x[12]<=init_x+5;
            block_y[12]<=init_y+3;
            block_x[13]<=init_x+5;
            block_y[13]<=init_y+4;
        end
        else begin
            block_x[10]<=6'b111111;
            block_y[10]<=6'b111111;
            block_x[11]<=6'b111111;
            block_y[11]<=6'b111111;
            block_x[12]<=6'b111111;
            block_y[12]<=6'b111111;
            block_x[13]<=6'b111111;
            block_y[13]<=6'b111111;
        end
        if (left_top_edge) begin
            block_x[14]<=init_x;
            block_y[14]<=init_y+6;
            block_x[15]<=init_x;
            block_y[15]<=init_y+7;
            block_x[16]<=init_x;
            block_y[16]<=init_y+8;
            block_x[17]<=init_x;
            block_y[17]<=init_y+9;
        end
        else begin
            block_x[14]<=6'b111111;
            block_y[14]<=6'b111111;
            block_x[15]<=6'b111111;
            block_y[15]<=6'b111111;
            block_x[16]<=6'b111111;
            block_y[16]<=6'b111111;
            block_x[17]<=6'b111111;
            block_y[17]<=6'b111111;
        end
        if (right_top_edge) begin
            block_x[18]<=init_x+5;
            block_y[18]<=init_y+6;
            block_x[19]<=init_x+5;
            block_y[19]<=init_y+7;
            block_x[20]<=init_x+5;
            block_y[20]<=init_y+8;
            block_x[21]<=init_x+5;
            block_y[21]<=init_y+9;
        end
        else begin
            block_x[18]<=6'b111111;
            block_y[18]<=6'b111111;
            block_x[19]<=6'b111111;
            block_y[19]<=6'b111111;
            block_x[20]<=6'b111111;
            block_y[20]<=6'b111111;
            block_x[21]<=6'b111111;
            block_y[21]<=6'b111111;
        end
        if (bottom_edge) begin
            block_x[22]<=init_x+1;
            block_y[22]<=init_y;
            block_x[23]<=init_x+2;
            block_y[23]<=init_y;
            block_x[24]<=init_x+3;
            block_y[24]<=init_y;
            block_x[25]<=init_x+4;
            block_y[25]<=init_y;
        end
        else begin
            block_x[22]<=6'b111111;
            block_y[22]<=6'b111111;
            block_x[23]<=6'b111111;
            block_y[23]<=6'b111111;
            block_x[24]<=6'b111111;
            block_y[24]<=6'b111111;
            block_x[25]<=6'b111111;
            block_y[25]<=6'b111111;
        end
        if (middle_edge) begin
            block_x[26]<=init_x+1;
            block_y[26]<=init_y+5;
            block_x[27]<=init_x+2;
            block_y[27]<=init_y+5;
            block_x[28]<=init_x+3;
            block_y[28]<=init_y+5;
            block_x[29]<=init_x+4;
            block_y[29]<=init_y+5;
        end
        else begin
            block_x[26]<=6'b111111;
            block_y[26]<=6'b111111;
            block_x[27]<=6'b111111;
            block_y[27]<=6'b111111;
            block_x[28]<=6'b111111;
            block_y[28]<=6'b111111;
            block_x[29]<=6'b111111;
            block_y[29]<=6'b111111;
        end
        if (top_edge) begin
            block_x[30]<=init_x+1;
            block_y[30]<=init_y+10;
            block_x[31]<=init_x+2;
            block_y[31]<=init_y+10;
            block_x[32]<=init_x+3;
            block_y[32]<=init_y+10;
            block_x[33]<=init_x+4;
            block_y[33]<=init_y+10;
        end
        else begin
            block_x[30]<=6'b111111;
            block_y[30]<=6'b111111;
            block_x[31]<=6'b111111;
            block_y[31]<=6'b111111;
            block_x[32]<=6'b111111;
            block_y[32]<=6'b111111;
            block_x[33]<=6'b111111;
            block_y[33]<=6'b111111;
        end
    end
endmodule

module left_right_shift_block(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input logic [1:0] left_right_shift, // 00:none 01:right 10:left
    output [5:0] block_try_x [24:0],
    output [5:0] block_try_y [24:0]
);
    always_ff @(posedge left_right_shift) begin

        // the first block is the center of the block, first bit represent 0.5 
        if (left_right_shift==2'b10) begin
            block_try_x[0]=block_x[0]+2;
            block_try_y[0]=block_y[0];
        end
        else if (left_right_shift==2'b01) begin
            block_try_x[0]=block_x[0]-2;
            block_try_y[0]=block_y[0];
        end
        else begin
            block_try_x[0]=block_x[0];
            block_try_y[0]=block_y[0];
        end

        for (int i=1; i<25; i=i+1) begin
            if (left_right_shift==2'b10) begin
                block_try_x[i]=block_x[i]+1;
                block_try_y[i]=block_y[i];
            end
            else if (left_right_shift==2'b01) begin
                block_try_x[i]=block_x[i]-1;
                block_try_y[i]=block_y[i];
            end
            else begin
                block_try_x[i]=block_x[i];
                block_try_y[i]=block_y[i];
            end

            // if out of bound, raise the flag
            // if (block_try_x[i]>19) begin
            //     block_try_x[i]=0;
            // end
            // else if (block_try_x[i]>63) begin
            //     block_try_x[0]=6'b111111;
            //     block_try_x[i]=6'b111111;
            // end
        end
    end
endmodule

module up_down_shift_block(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input logic [1:0] up_down_shift, // 00:none 01:down 10:up
    output [5:0] block_try_x [24:0],
    output [5:0] block_try_y [24:0]
);
    always_ff @(posedge up_down_shift) begin

        // the first block is the center of the block, first bit represent 0.5 
        if (up_down_shift==2'b10) begin
            block_try_x[0]=block_x[0];
            block_try_y[0]=block_y[0]+2;
        end
        else if (up_down_shift==2'b01) begin
            block_try_x[0]=block_x[0];
            block_try_y[0]=block_y[0]-2;
        end
        else begin
            block_try_x[0]=block_x[0];
            block_try_y[0]=block_y[0];
        end

        for (int i=1; i<25; i=i+1) begin
            if (up_down_shift==2'b10) begin
                block_try_x[i]=block_x[i];
                block_try_y[i]=block_y[i]+1;
            end
            else if (up_down_shift==2'b01) begin
                block_try_x[i]=block_x[i];
                block_try_y[i]=block_y[i]-1;
            end
            else begin
                block_try_x[i]=block_x[i];
                block_try_y[i]=block_y[i];
            end

            // if out of bound, raise the flag
            // if (block_try_y[i]>29) begin
            //     block_try_y[i]=0;
            // end
            // else if (block_try_y[i]>63) begin
            //     block_try_y[0]=6'b111111;
            //     block_try_y[i]=6'b111111;
            // end
        end
    end
endmodule


module clean_moving_block_ground(
    
    input logic         enable_clean,
    output reg [19:0]    moving_block_ground [29:0]  // Memory of stored blocks, containing 30 rows each 20 bits wide
);
    //The clean_moving_block_ground module in Verilog is designed to clear the memory array of moving blocks 
    //based on the input of an enable signal. It uses a for loop to iterate through each row of the memory array 
    //and set all elements to 0 when the enable signal is active.
    always_ff @(posedge enable_clean) begin
        for (int i = 0; i < 30; i = i + 1) begin
            moving_block_ground[i] <= 20'h00000;  // Clear memory array
        end
    end
endmodule



module block_memory_check_conflict(
    input reg [19:0]    moving_block_ground [29:0],  // Memory of stored blocks, containing 30 rows each 20 bits wide
    input reg [19:0]    block_memory [29:0],  // Memory of stored blocks, containing 30 elements each 20 bits wide
    output logic        conflict  // Output conflict flag
);

    always_comb begin
        conflict = 1'b0;  // Default to no conflict
        for (int i = 0; i < 30; i = i + 1) begin
            // Check for bit overlap between moving and stored blocks at corresponding rows
            if (moving_block_ground[i] & block_memory[i]) begin
                conflict = 1'b1;  // Conflict detected, set conflict flag
            end
        end
    end
endmodule


module block_memory_enable_memory(
    input Clk,  // 50 MHz clock
    input reg [19:0]    moving_block_ground [29:0],  // Memory of stored blocks, containing 30 rows each 20 bits wide
    input logic         memory_enable,
    output reg [19:0]   block_memory [29:0] // 30 row, each block has 20 bits
    );
    //The block_memory_enable_memory module in Verilog is designed to update a memory array 
    //based on the input from a moving block array under the control of a 50 MHz clock. 
    //It uses an enable signal to conditionally merge the moving block data 
    //with the existing memory data using bitwise OR operations.
    always_ff @(posedge memory_enable) begin
        if (memory_enable) begin
            for (int i = 0; i < 30; i = i + 1) begin
                block_memory[i] = block_memory[i] | moving_block_ground[i];  // Merge moving block data with memory data
            end
        end
    end
endmodule

// This module scans the memory for full rows (all 1s) and deletes them by shifting the remaining rows up.
// It keeps track of the number of deleted rows using the delete_rows_num output.
module block_memory_delete_lines(
    input Clk,  // 50 MHz clock
    output logic [2:0]  delete_rows_num, 
    output reg [19:0]   block_memory [29:0] // 30 row, each block has 20 bits
    );
    logic [6:0] order=7'b0000000;
    logic shift_enable;
    block_memory_shift_lines block_memory_shift_lines(Clk, order, block_memory);  // Shift memory rows up
    always_comb begin
        delete_rows_num = 3'b000;  // Default to no rows to delete
        for (int i = 29; i >=0; i = i - 1) begin
            shift_enable = 1'b0;
            if (block_memory[i] == 20'hFFFFF) begin
                order=i;
                shift_enable = 1'b1;  // Enable row shift
                delete_rows_num = delete_rows_num + 1'b1;  // Increment delete row counter
            end
        end
    end

endmodule

// This module shifts all rows above the specified start row (shift_start_row) up by one row.
// It clears the last row of the memory after shifting.
module block_memory_shift_lines(
    input Clk,  // 50 MHz clock
    input logic [6:0]  shift_start_row,
    input logic shift_enable,
    output reg [19:0]   block_memory [29:0] // 30 row, each block has 20 bits
    );

    always_comb begin
        if (shift_enable)  begin// Check if shift is enabled
            for (int i = shift_start_row; i < 29; i = i + 1) begin
                block_memory[i] = block_memory[i + 1];  // Shift memory rows up
            block_memory[29] = 20'h00000;  // Clear last memory row
            end
        end
    end
endmodule


//module block_memory(
//    input reg [19:0]    moving_block [3:0],
//    input logic [5:0]   moving_block_lowesr_level,
//    input logic         memory_this_block,
//    output logic        conflict,
//    output logic        delete_row,
//    output reg [19:0]   block_memory [29:0]; // 30 row, each block has 20 bits
//    );
//
//endmodule

