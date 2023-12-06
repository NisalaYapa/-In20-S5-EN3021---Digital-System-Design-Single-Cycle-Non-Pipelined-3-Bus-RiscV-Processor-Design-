module PCCounter #(parameter Width = 32) 
	(input clk, 
	 input PCen,
	 input [Width-1:0] PC1,
	 output reg [Width-1:0] PC);

	always@(posedge clk)
		begin
			if(PCen == 0)  //Disable Program counter
			PC <= PC;
		else 
			PC <= PC1;    // Enabling program counter
		end
endmodule
