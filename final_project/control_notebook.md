# control system
This part of the tetris game is control kernel. It is developed from the ball.sv from lab8.

Now, the ball is turned into some sort of 'object', it can be a block or a score value on the VGA screen.

I need you help me analyze how to control my tetris game, making it clearer for debug.


```systemverilog


module ball(
    input Clk,                          // 50 MHz clock
    input Reset,                        // Active-high reset signal
    input frame_clk,                    // The clock indicating a new frame (~60Hz)
    input [9:0] DrawX, DrawY,           // Current pixel coordinates
    input [7:0] keycode,
    output logic [4:0] is_ball          // Whether current pixel belongs to object or background
);
    // This module handles the logic for detecting whether a current pixel belongs to a ball(object like block ) or the background. It utilizes block memory for storing moving blocks and score information, handles user input for controlling the ball, and updates positions accordingly.
end module

module PulseGenerator(
    input logic clk,                    // Clock signal
    input logic button,                 // Button input signal
    input logic [1:0] control_command,  // Control command input
    output logic pulse_out,             // Output pulse signal
    output logic [1:0] command_out      // Output control command
);
    // This module generates a pulse signal based on button input and stores control commands until the next button press.
end module

module keypress_generator(
    input clk,                          // Clock signal
    input reset,                        // Reset signal
    output reg [9:0] keypress           // Keypress output
);
    // This module simulates keypresses at regular intervals, outputting a sequence of predefined keycodes.
end module

module allow_control_check(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input logic enable_check_conflict,
    output logic conflict
);
    // This module checks for conflicts in block positions, ensuring they are within specified bounds.
end module

module timer(
    input wire clk,
    input wire Reset,
    output reg enable_choose,
    output reg enable_control
);
    // This module generates signals to enable choosing and controlling blocks based on a timer.
end module

module control_logic_control(
    input logic clk,                    // Clock signal
    input logic reset,                  // Reset signal
    input logic ask_control,            // Request control signal
    input logic finish_control,         // Finish control signal
    output logic enable_control         // Enable control signal
);
    // This module manages control logic, enabling or disabling control signals based on input conditions.
end module

module control_block(
    input [5:0] block_x [24:0],
    input [5:0] block_y [24:0],
    input [1:0] control_command,        // Control command
    input logic ask_control,
    output [5:0] block_try_x [24:0],
    output [5:0] block_try_y [24:0]
);
    // This module handles control commands for blocks, adjusting their positions based on user input.
end module

module draw_ground(
    input logic frame_clk,              // Frame clock signal
    input [9:0] DrawX, DrawY,           // Current pixel coordinates
    input [19:0] moving_block_ground[29:0],  // Memory of moving blocks
    input [4:0] is_ball_color,
    output logic [4:0] is_ball          // Output signal if the pixel is part of a ball
);
    // This module draws the moving blocks on the screen, determining if a given pixel is part of a ball.
end module

module memory_block_on_moving_block_ground(
    input Clk,
    input logic write_enable,           // Enable signal for writing to the memory
    input [5:0] block_x [24:0],         // Array of X coordinates for blocks
    input [5:0] block_y [24:0],         // Array of Y coordinates for blocks
    inout reg [19:0] moving_block_ground [29:0] // Memory array of moving blocks
);
    // This module writes block positions into memory based on provided coordinates.
end module

module choose_block(
    input Clk,
    input [5:0] block_type,             // The type of block to be chosen
    input logic enable_choose,          // Enable signal for block selection
    output [5:0] block_x [24:0],        // X coordinates of the block
    output [5:0] block_y [24:0]         // Y coordinates of the block
);
    // This module selects a block based on the input block_type and assigns the corresponding coordinates to the block_x and block_y output arrays.
end module

```



## Notice






我还没写俄罗斯方块消去整行的办法，教我如何写这个逻辑，让我的在FPGA时序内可以比较快的从背景墙里消除多余方块



module draw_ground(
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX, DrawY,            // Current pixel coordinates
    input [19:0] moving_block_ground[29:0],  // Memory of moving blocks, 30 rows each 20 bits wide
    input [4:0] is_ball_color,
    output logic [4:0]  is_ball                // Output signal if the pixel is part of a ball
);

    

endmodule


重点在于这个背景图层
