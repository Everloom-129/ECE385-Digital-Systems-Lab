//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input        [4:0]   is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    localparam BG_SIZE = 19200; 
    localparam BG_ROW  = 160;
    
    logic [15:0] idx;

        logic [7:0] R_bg [0:BG_SIZE];
        logic [7:0] G_bg [0:BG_SIZE];
        logic [7:0] B_bg [0:BG_SIZE];

    initial begin
        $readmemh("resource/ZJUIR.txt",R_bg);
        $readmemh("resource/ZJUIG.txt",G_bg);
        $readmemh("resource/ZJUIB.txt",B_bg);
    end
    
    assign idx   = (DrawY / 4) *  BG_ROW + (DrawX/4);

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    // Assign color based on is_ball signal
    always_comb
    begin
        if (is_ball == 5'b00001) 
        begin
            // White ball
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end
        else if (is_ball == 5'b00010)
        begin
            // Red ball
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
        end
        else if (is_ball == 5'b00011)
        begin
            // Green ball
            Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
        end 
        else if (is_ball == 5'b00100)
        begin
        
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'hff;
        end
        else 
        begin
        // Background with nice color gradient
            // Red = 8'h3f; 
            // Green =8'h7f - {1'b0, DrawX[9:3]}; //8'h00;
            // Blue = 8'h7f - {1'b0, DrawX[9:3]};
        // self-defined background
            Red = R_bg[idx];
            Green = G_bg[idx];
            Blue = B_bg[idx];
        end
    end 
    
endmodule
