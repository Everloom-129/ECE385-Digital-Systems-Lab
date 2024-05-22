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
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk

    rotation_block rotation_block1(.block_x(block_x),.block_y(block_y),.enable_rotation(enable_rotation),.block_try_x(block_x_try_rotation),.block_try_y(block_y_try_rotation));

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
        if (Reset) begin
            // block_type<=6'b000000;

            for (int i = 0; i < 30; i = i + 1) begin
                moving_block_ground[i] <= 20'h00000;  // Clear memory array
            end
        end
        else begin
            block_type<=6'b000000;
            
            
        end

        if (enable_update_moving_block_ground) begin
            for (int i = 0; i < 30; i++) begin
                moving_block_ground[i] <= mbg_wire[i];
            end
        end

        if (enable_choose) begin
            for (int i=0; i<25; i=i+1) begin
                block_x[i]=block_x_try_choose[i];
                block_y[i]=block_y_try_choose[i];
            end
        end
        else if(enable_rotation) begin
            for (int i=0; i<25; i=i+1) begin
                block_x[i]=block_x_try_rotation[i];
                block_y[i]=block_y_try_rotation[i];
            end
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        enable_update_moving_block_ground=1'b01;
        
        // Update position and motion only at rising edge of frame clock
        if(frame_clk_rising_edge_count[4:0]==5'b10000 && frame_clk_rising_edge) 
        begin
            up_down_shift=2'b00;
            enable_rotation=1'b0;
            enable_choose=1'b1;
        end
        else begin
            up_down_shift=2'b00;
            enable_rotation=1'b1;
            enable_choose=1'b0;
        end
    end


    draw_ground draw_moving_block_ground(.frame_clk(frame_clk),.DrawX(DrawX),.DrawY(DrawY),.moving_block_ground(moving_block_ground),.is_ball(is_ball));

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

