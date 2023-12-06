module Registerfile #(parameter Width = 32)(
	input clk,
	input RegWrite,
	input [4:0] R1, 
	input [4:0] R2, 
	input [4:0] W1,
	input [Width-1:0] WD1,
	output [Width-1:0] RD1,
	output [Width-1:0] RD2);

	integer i;   // Count register locations for initialization
	reg [Width-1:0] Register [Width-1:0]; // 32 registers with 32 bits

	initial
		begin
			for( i = 0; i<32; i = i+1)   //Initialize all the registers with their address to esily identify
				begin
					Register[i] = i;
				end

		end 
	always @(posedge clk)
		begin
			if(RegWrite)  // Write to registers
				Register[W1] <= WD1;
		end
		
	assign RD1 = (R1 != 0) ? Register[R1] : 0;
	assign RD2 = (R2 != 0) ? Register[R2] : 0;

endmodule
