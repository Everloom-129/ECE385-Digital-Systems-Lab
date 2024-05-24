module game_logic (
    input logic clk,             // System clock
    input logic reset,           // System reset signal
    input logic [7:0] keycode, // Signals from the PS/2 keyboard

    output logic [199:0] grid_state, // Current state of the game grid (20x10 grid)
    output logic [15:0] score        // Current game score
);

    // Define states for FSM
    typedef enum logic [2:0] {
        INIT,
        IDLE,
        MOVE,
        ROTATE,
        COLLISION_CHECK,
        LINE_CLEAR,
        GAME_OVER
    } state_t;

    state_t current_state, next_state;

    // Game grid and tetromino variables
    logic [199:0] game_grid; // 20x10 grid represented as a 200-bit vector
    logic [3:0] current_piece; // Current tetromino piece
    logic [6:0] piece_position; // Position of the tetromino piece (7-bit for 128 possible positions)
    
    // Score variable
    logic [15:0] game_score;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= INIT;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always_comb begin
        // Default values
        next_state = current_state;
        grid_state = game_grid;
        score = game_score;
        
        case (current_state)
            INIT: begin
                // Initialize game state
                game_grid = 0;
                game_score = 0;
                current_piece = generate_new_piece();
                piece_position = initial_position();
                next_state = IDLE;
            end

            IDLE: begin
                // Wait for user input
                if (key_input != 0) begin
                    next_state = MOVE;
                end
            end

            MOVE: begin
                // Update position of the active tetromino
                if (key_input == LEFT) begin
                    // Move left logic
                end else if (key_input == RIGHT) begin
                    // Move right logic
                end else if (key_input == DOWN) begin
                    // Soft drop logic
                end else if (key_input == SPACE) begin
                    // Hard drop logic
                end
                next_state = COLLISION_CHECK;
            end

            ROTATE: begin
                // Rotate the active tetromino
                // Rotation logic
                next_state = COLLISION_CHECK;
            end

            COLLISION_CHECK: begin
                // Check for collisions
                if (collision_detected()) begin
                    next_state = LINE_CLEAR;
                end else begin
                    next_state = IDLE;
                end
            end

            LINE_CLEAR: begin
                // Clear completed lines and update score
                clear_lines();
                update_score();
                current_piece = generate_new_piece();
                piece_position = initial_position();
                next_state = IDLE;
            end

            GAME_OVER: begin
                // End the game
                // Game over logic
            end
        endcase
    end

    // Function to generate a new tetromino piece
    function logic [3:0] generate_new_piece();
        // Tetromino generation logic
    endfunction

    // Function to get the initial position of the piece
    function logic [6:0] initial_position();
        // Initial position logic
    endfunction

    // Function to detect collision
    function logic collision_detected();
        // Collision detection logic
    endfunction

    // Task to clear lines
    task clear_lines();
        // Line clearing logic
    endtask

    // Task to update score
    task update_score();
        // Score updating logic
    endtask

endmodule

module tetris_game (
    input         Clk,                // 50 MHz clock
    input         Reset,              // Active-high reset signal
    input         frame_clk,          // The clock indicating a new frame (~60Hz)
    input [9:0]   DrawX, DrawY,       // Current pixel coordinates
    input [7:0]   keycode,
    output logic [4:0] is_ball        // Whether current pixel belongs to ball or background
);

    // 定义信号
    reg [19:0] moving_block_ground [29:0];
    reg [19:0] block_memory [29:0];
    logic [2:0] delete_rows_num;
    logic [6:0] shift_start_row;
    logic enable_clean, memory_enable, shift_enable;
    logic conflict;

    // 模块实例化
    clean_moving_block_ground clean_block(
        .enable_clean(enable_clean),
        .moving_block_ground(moving_block_ground)
    );

    block_memory_check_conflict check_conflict(
        .moving_block_ground(moving_block_ground),
        .block_memory(block_memory),
        .conflict(conflict)
    );

    block_memory_enable_memory enable_memory(
        .Clk(Clk),
        .moving_block_ground(moving_block_ground),
        .memory_enable(memory_enable),
        .block_memory(block_memory)
    );

    block_memory_delete_lines delete_lines(
        .Clk(Clk),
        .delete_rows_num(delete_rows_num),
        .block_memory(block_memory)
    );

    block_memory_shift_lines shift_lines(
        .Clk(Clk),
        .shift_start_row(shift_start_row),
        .shift_enable(shift_enable),
        .block_memory(block_memory)
    );

    // 游戏逻辑
    always_ff @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // 重置逻辑
            for (int i = 0; i < 30; i = i + 1) begin
                block_memory[i] <= 20'h00000;
                moving_block_ground[i] <= 20'h00000;
            end
            enable_clean <= 1'b0;
            memory_enable <= 1'b0;
            shift_enable <= 1'b0;
        end else begin
            // 游戏逻辑，包括移动块和消行
            if (/* 某个条件，例如检测到行满 */) begin
                delete_lines;  // 调用删除行模块
                shift_lines;   // 调用行移位模块
            end

            // 其他逻辑，例如检测冲突，更新内存等
            check_conflict;
            enable_memory;
        end
    end

    // (省略其他模块实例化及逻辑)

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

// module rotation_block(
//     input [5:0] block_x [24:0],
//     input [5:0] block_y [24:0],
//     input logic enable_rotation,
//     output reg [5:0] block_try_x [24:0],
//     output reg [5:0] block_try_y [24:0]
// );
//     // Rotation center coordinates adjusted for possible 0.5 increment
//     logic signed [7:0] rotation_center_X, rotation_center_Y;
//     always_comb begin
//         rotation_center_X = block_x[0];  // Multiply by 2 to handle 0.5 step
//         rotation_center_Y = block_y[0];  // Multiply by 2 to handle 0.5 step
//     end

//     always_ff @(posedge enable_rotation) begin
//         block_try_x[0] <= block_x[0];  // Keep the rotation center the same
//         block_try_y[0] <= block_y[0];
        
//         for (int i = 1; i < 25; i = i + 1) begin
//             if (block_x[i] < 20 && block_y[i] < 30) begin
//                 // Apply rotation transformation formula for 90 degrees CW
//                 block_try_x[i] <= (rotation_center_X - (block_y[i] *2) + rotation_center_Y ) /2 ;  // Convert back from scaled values
//                 block_try_y[i] <= (rotation_center_Y - rotation_center_X + (block_x[i] *2)) /2 ;  // Convert back from scaled values
//             end else begin
//                 block_try_x[i] <= 6'b111111;  // Invalid block
//                 block_try_y[i] <= 6'b111111;
//             end
//         end
//     end
// endmodule