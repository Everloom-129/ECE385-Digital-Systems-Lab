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

    /* Declare Internal Registers and Signals */
    logic[7:0] A, B, S_SH;  // use this as an input to your multi
    logic[8:0] result;

    logic Reset_SH, ClearA_LoadB_SH, Run_SH;
    logic Reset_A, opA, opB, Shift_En, Clear_A,Add, Sub, YST;

    assign M = opB;
    assign Aval = A;
    assign Bval = B;

    assign Reset_A = Reset_SH | Clear_A;

    /* Behavior of registers A, B and sign X */
    always_ff @(posedge Clk) begin
        // if (Reset_A) begin
        //     // if reset is pressed, clear the SIGN bit
        //     X <= 1'b0; 
        //     A <= 8'h00; // Clear A as well if needed
        //     B <= 8'h00; // Clear B as well if needed
        // end else if (!ClearA_LoadB) begin
        //     // If ClearA_LoadB is pressed, load S into register B
        //     A <= 8'h00; // Clear A if needed when loading B
        //     B <= S;
        // end else if (Ld_B) begin
        //     // Additional load behavior for B, similar to the xfp module
        //     B <= S;
        // end else begin
        //     // Continuously copy switches to register A
        //     A <= S;
        // end

        // Flip-flop behavior for X
        if (Reset_A) begin
            X <= 1'b0;
        end else if (Add) begin
            X <= result[8];
        end // No need for an 'else' part as X will retain its value
    end

   
    register_unit_8 reg_unit (
                        .Clk(Clk),
                        .Reset(Reset_A),
                        .A_In(X),
                        .B_In(opA),
                        .Ld_A(Add),
                        .Ld_B(Ld_B),
                        .Shift_En(Shift_En),

                        .D(result[7:0]),
                        .A_out(opA),
                        .B_out(opB),
                        .A(A),
                        .B(B) );

    adder_sub adder_8bit(
        .a(A),
        .b(B),
        .subtract(Sub),
        .result(result),
        .carry_out(YST)
    );


// connect
    control     control_unit(
        .Clk(Clk),
        .Reset(Reset),
        .ClearA_LoadB(ClearA_LoadB),
        .Run(~Run),
        .M(M),
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

	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH,Run_SH});
	  sync Din_sync[7:0] (Clk, S, S_SH); // 8 bit
	  
    
endmodule
