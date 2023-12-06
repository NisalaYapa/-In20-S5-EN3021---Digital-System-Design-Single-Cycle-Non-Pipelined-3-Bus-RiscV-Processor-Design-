/*module DataMemory #(parameter Width = 32)
	(input clk,
	input MemWrite,
	input MemRead,
	input [Width-1:0] address,
	input [Width-1:0]WriteData,
	output reg [Width-1:0] ReadData);
	reg [Width-1:0] mem1[511:0];
	integer i;
	initial
		begin
		  for (i = 0; i <= 511; i = i + 1) begin
			 mem1[i] = i; // Assign the current value of 'i' to the memory address
		  end
		end
	always @(*)
		begin
			if(MemRead == 1'b1)
			ReadData <= mem1[address];
			else if(MemWrite == 1'b1)
			mem1[address] = WriteData;
		end
endmodule */

module DataMemory #(parameter Width = 32)
	(input clk,
	input MemWrite,
	input MemRead,
	input [Width-1:0] address,
	input [Width-1:0]WriteData,
	output reg [Width-1:0] ReadData);
	reg [Width-1:0] mem1[511:0];
	integer i;
//	initial
//		begin
//		  for (i = 0; i <= 511; i = i + 1) begin
//			 mem1[i] = i; // Assign the current value of 'i' to the memory address
//		  end
//		end
	always @(*)
		begin
			if(MemRead == 1'b1)
			ReadData <= mem1[address];
			else if(MemWrite == 1'b1)
			mem1[address] = WriteData;
		end
endmodule