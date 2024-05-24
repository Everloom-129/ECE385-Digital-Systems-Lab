module draw_icon (
    input logic frame_clk,               // Frame clock signal
    input [9:0] DrawX_in, DrawY_in,      // Current pixel coordinates
    output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
);

    // Constants for dimensions
    localparam ICON_WIDTH = 32;
    localparam ICON_HEIGHT = 32;
    localparam SCREEN_WIDTH = 640;
    localparam SCREEN_HEIGHT = 480;

    // Image data arrays
    logic [7:0] R_icon [0:1023];
    logic [7:0] G_icon [0:1023];
    logic [7:0] B_icon [0:1023];

    // Load image data from files
    initial begin
        $readmemh("resource/ece385R.txt", R_icon);
        $readmemh("resource/ece385G.txt", G_icon);
        $readmemh("resource/ece385B.txt", B_icon);
    end

    // Calculate index for image data
    logic [15:0] idx;

    // Compute the index and determine if the current pixel is within the icon area
    always_ff begin
        if ((DrawX_in >= SCREEN_WIDTH - ICON_WIDTH) && (DrawY_in >= SCREEN_HEIGHT - ICON_HEIGHT)) begin
            idx = (DrawY_in - (SCREEN_HEIGHT - ICON_HEIGHT)) * ICON_WIDTH + (DrawX_in - (SCREEN_WIDTH - ICON_WIDTH));
            VGA_R = R_icon[idx];
            VGA_G = G_icon[idx];
            VGA_B = B_icon[idx];
        end else begin
            VGA_R = 8'h0;
            VGA_G = 8'h0;
            VGA_B = 8'h0;
        end
    end

endmodule
