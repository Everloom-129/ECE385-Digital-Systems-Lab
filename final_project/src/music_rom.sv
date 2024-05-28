/*
 * music_rom.sv
 * Author: kennylimz@github, ZJUI ECE385 SP2020
 * Source: https://github.com/kennylimz/ECE385_Tetris
 * Description: load the rom music 'Tetris' into the audio_interface.vhd
 * Modify: Jie Wang
 */


module music_rom (input logic  Clk,
				  input logic  [16:0]Add,
				  output logic [16:0]music_content);
				  
	logic [16:0] music_memory [0:83464]; // Length is 83465 line
	initial 
	begin 
		$readmemh("resource/Tetris.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
			music_content <= music_memory[Add];
		end
endmodule
