// music_rom.sv
// Cited from ...
// modify: Jie Wang

module music_rom (input logic  Clk,
				  input logic  [16:0]Add,
				  output logic [16:0]music_content);
				  
	logic [16:0] music_memory [0:83464];
	initial 
	begin 
		$readmemh("Tetris.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
			music_content <= music_memory[Add];
		end
endmodule
