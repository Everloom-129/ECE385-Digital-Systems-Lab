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
    output  logic           X,         // Sign.  Goes to the green LED to the left of the hex displays.
    output  logic[6:0]      AhexU,      // Hex drivers display both inputs to the adder.
    output  logic[6:0]      AhexL,
    output  logic[6:0]      BhexU,
    output  logic[6:0]      BhexL,
    output  logic[7:0]      Aval,
    output  logic[7:0]      Bval
);

    /* Declare Internal Registers */
    logic[15:0]     A;  // use this as an input to your multi
    logic[15:0]     B;  // use this as an input to your multi
    logic[15:0]     Sum; 
    logic BShift_out, Ld_B, ClearA, Shift_En, Add, Sub; // Declare these signals

    /* Declare Internal Wires
     * Wheather an internal logic signal becomes a register or wire depends
     * on if it is written inside an always_ff or always_comb block respectivly */
    logic[15:0]     Sum_comb;
    logic[6:0]      Ahex0_comb;
    logic[6:0]      Ahex1_comb;
    logic[6:0]      Ahex2_comb;
    logic[6:0]      Ahex3_comb;
    logic[6:0]      Bhex0_comb;
    logic[6:0]      Bhex1_comb;
    logic[6:0]      Bhex2_comb;
    logic[6:0]      Bhex3_comb;
    

    /* Behavior of registers A, B, Sum, and CO */
    always_ff @(posedge Clk) begin
        
        if (!Reset) begin
            // if reset is pressed, clear the adder's input registers
            A <= 8'h0000;
            B <= 8'h0000;
            Sum <= 'h0000; // todo 
            X <= 1'b0; //todo 
        end else if (!ClearA_LoadB) begin
            // If ClearA_LoadB is pressed, copy switches to register B
            A <= 8'h0000;
            B <= S;
        end else begin
            // otherwise, continuously copy switches to register A
            A <= S;
        end
        
        // transfer sum and carry-out from adder to output register
        // every clock cycle that Run is pressed
        if (!Run) begin
            Sum <= Sum_comb;
        end
            // else, Sum and CO maintain their previous values
        
    end
    
    /* Decoders for HEX drivers and output registers
     * Note that the hex drivers are calculated one cycle after Sum so
     * that they have minimal interfere with timing (fmax) analysis.
     * The human eye can't see this one-cycle latency so it's OK. */
    always_ff @(posedge Clk) begin
        
        AhexU <= Ahex0_comb;
        AhexL <= Ahex1_comb;

        BhexU <= Bhex0_comb;
        BhexL <= Bhex1_comb;

    end
    
 
     reg_8   reg_A(
        .Clk(Clk),
        .Reset(Reset_A),
        .Left_shift_In(AShift_In),
        .Load_d(Ld_A),
        .Shift_function(Shift_En),
        .Data_in(A),
        .Left_shift_Out(AShift_Out),
        .Data_out(newA)

    );

     reg_8   reg_B(
        .Clk(Clk),
        .Reset(~Reset),
        .Left_shift_In(BShift_In),	
        .Load_d(Ld_B),
        .Shift_function(Shift_En),
        .Data_in(S),
        .Left_shift_Out(BShift_out),
        .Data_out(newB)
    );


// connect
    control     control_unit(
        .Clk(Clk),
        .Reset(~Reset),
        .ClearA_LoadB(~ClearA_LoadB),
        .Run(~Run),
        .M(BShift_out),
        .Clr_LD(Ld_B),
        .ClearA(ClearA),
        .Shift(Shift_En),
        .Add(Add),
        .Sub(Sub)   
    );



    HexDriver HexAL
    (
        .In0(A[3:0]),   // This connects the 4 least significant bits of 
                        // register A to the input of a hex driver named Ahex0_inst
        .Out0(Ahex0_comb)
    );
    
    HexDriver HexAH
    (
        .In0(A[7:4]),
        .Out0(Ahex1_comb)
    );
    

    
    HexDriver HexBL
    (
        .In0(B[3:0]),
        .Out0(Bhex0_comb)
    );
    
    HexDriver HexBH
    (
        .In0(B[7:4]),
        .Out0(Bhex1_comb)
    );
    
endmodule
