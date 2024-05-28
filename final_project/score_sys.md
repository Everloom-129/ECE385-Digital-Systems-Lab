# Score system, migrating from the ball.sv into score.sv

module draw_score(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX_in, DrawY_in,      // Current pixel coordinates
    input [39:0] score_ground[59:0],     // Memory of moving blocks, 30 rows each 20 bits wide
    input [4:0] is_ball_color,
    output logic [4:0] is_ball           // Output signal if the pixel is part of a ball
);
    // This module calculates whether a given pixel is part of a ball based on the current pixel coordinates and the memory of moving blocks.
end module

module memory_num_on_score_ground(
    input Clk,
    input [5:0] block_x [33:0],                // Array of X coordinates for blocks
    input [5:0] block_y [33:0],                // Array of Y coordinates for blocks
    inout reg [39:0] score_ground [59:0]       // Memory array of moving blocks, as inout to handle internal writes and external reads
);
    // This module updates the memory with new block positions based on the coordinates provided.
end module

module choose_num_score(
    input Clk,
    input [5:0] block_type,           // The type of block to be chosen
    input [5:0] init_x,               // The initial x coordinate of the block
    input [5:0] init_y,               // The initial y coordinate of the block
    output [5:0] block_x [33:0],      // X coordinates of the block
    output [5:0] block_y [33:0]       // Y coordinates of the block
);
    // This module selects a block based on the input block_type and assigns the corresponding coordinates to the block_x and block_y output arrays.
end module
