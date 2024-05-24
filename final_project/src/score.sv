// score.sv

module draw_score(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX_in, DrawY_in,            // Current pixel coordinates
    input [39:0] score_ground[59:0],  // Memory of moving blocks, 30 rows each 20 bits wide
    input [4:0] is_ball_color,
    output logic [4:0] is_ball                 // Output signal if the pixel is part of a ball
);

    // Constants for dimensions
    localparam PIXELS_PER_BLOCK = 8;
    localparam BLOCKS_PER_ROW = 40;      // Number of blocks per row
    localparam BLOCKS_PER_COL = 60;      // Number of blocks per col
    localparam SCREEN_HEIGHT = 480;
    localparam HALF_SCREEN_WIDTH = 320;

    logic [9:0] DrawX, DrawY;            // Current pixel coordinates

    // Compute the block index based on DrawX and DrawY
    logic [5:0] block_index_x;   // 20 blocks (0-19) across the X direction, fitting within 320 pixels (16 pixels each)
    logic [5:0] block_index_y;   // 30 blocks (0-29) down the Y direction

    // Assign block indices based on the current pixel coordinates
    always_comb begin
        DrawX = DrawX_in -320;
        DrawY = DrawY_in;
        block_index_x = (DrawX) / PIXELS_PER_BLOCK;  // Determine which block in the x direction
        block_index_y = (SCREEN_HEIGHT - DrawY - 1) / PIXELS_PER_BLOCK;  // Reverse Y direction

        // Ensure each block is visually distinct by checking if the pixel is not on the block's border
        if (block_index_x==0) 
            is_ball=1;
        else if (DrawX < 320 && block_index_y < BLOCKS_PER_COL && block_index_x < BLOCKS_PER_ROW) begin

            //is_ball = score_ground[block_index_y][block_index_x];  // Map the bit to is_ball output
            is_ball = score_ground[block_index_y][block_index_x]*is_ball_color;  // Map the bit to is_ball output
        end
        else begin
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

/*  
 *  Very long, for ascii number display
 */
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
    
    always_ff @(posedge Clk) begin
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

