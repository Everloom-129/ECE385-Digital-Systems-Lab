/*  Date Created: Mon Jan 25 2015.
 *  Written to correspond with the spring 2016 lab manual.
 *
 *  ECE 385 Lab 5 (8-Bit Multiplier) code.  This is the top level entity which
 *  connects an adder circuit to LEDs and buttons on the device.  
 *  
 *  Jie Wang 03/14/2024 
 *  declares some registers on the inputs and outputs of the adder to help
 *  generate timing information (fmax) and multiplex the DE115's 16 switches
 *  onto the adder's 32 inputs.
 *

/* Module declaration.  Everything within the parentheses()
 * is a port between this module and the outside world */
 
module lab5_toplevel
(
    input   logic           Clk,        // 50MHz clock is only used to get timing estimate data
    input   logic           Reset,      // From push-button 0.  Remember the button is active low (0 when pressed)
    input   logic           ClearA_LoadB, // From push-button 1
    input   logic           Run,        // From push-button 3.
    input   logic[7:0]      S,          // From slider switches
    
    // all outputs are registered
    output  logic           X,          // Sign.  Goes to the green LED to the left of the hex displays.
    output  logic[6:0]      AhexU,      // Hex drivers display both inputs to the adder.
    output  logic[6:0]      AhexL,
    output  logic[6:0]      BhexU,
    output  logic[6:0]      BhexL,
    output  logic[7:0]      Aval,
    output  logic[7:0]      Bval
);

    /* Declare Internal Registers */
    logic[7:0]     A;  // use this as an input to your multi
    logic[7:0]     B;  // use this as an input to your multi
    logic[8:0]     add_out;

	logic Reset_SH, ClearA_LoadB_SH, Run_SH;
    logic Reset_A, Ld_A, Ld_B, Shift_En, Clear_XA, outA, outB, Sub, x_val;
   
    assign Aval = A;
    assign Bval = B;
    assign x_val = X;

    assign Reset_A = Reset_SH | Clear_XA;
   

    /* Behavior of registers A, B and sign X */
    // TODO : check the reset logic 
    
    always_ff @(posedge Clk) begin
        
        if (!Reset) begin
            // if reset is pressed, clear the adder's input registers
            A <= 8'h0000;
            B <= 8'h0000;
            X <= 1'b0; 
        end else if (!ClearA_LoadB) begin
            // If ClearA_LoadB is pressed, copy switches to register B
            A <= 8'h0000;
            B <= S;
        end else begin
            // otherwise, continuously copy switches to register A
            A <= S;
           
        end
   
    end
    
    register_unit_8 

    adder_sub adder_8bit(
        .a(A),
        .b(B),
        .subtract,
        .result()
    );


// connect
    control     control_unit(
        .Clk(Clk),
        .Reset(Reset),
        .ClearA_LoadB(ClearA_LoadB),
        .Run(~Run),
        .M(BShift_out),
        .Clr_LD(Ld_B),
        .ClearA(ClearA),
        .Shift(Shift_En),
        .Add(Add),
        .Sub(Sub)   
    );

    HexDriver HexAL (.In0(A[3:0]), .Out0(AhexL));  // Lower nibble of A
    HexDriver HexAU (.In0(A[7:4]), .Out0(AhexU));  // Upper nibble of A
    HexDriver HexBL (.In0(B[3:0]), .Out0(BhexL));  // Lower nibble of B
    HexDriver HexBU (.In0(B[7:4]), .Out0(BhexU));  // Upper nibble of B

	  sync button_sync[3:0] (Clk, {~Reset, ~LoadA, ~LoadB, ~Execute}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
	  sync Din_sync[7:0] (Clk, Din, Din_S); // 8 bit
	  sync F_sync[2:0] (Clk, F, F_S);
	  sync R_sync[1:0] (Clk, R, R_S);
	  
    
endmodule
