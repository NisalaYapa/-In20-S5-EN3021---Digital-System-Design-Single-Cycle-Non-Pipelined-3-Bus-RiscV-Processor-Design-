`timescale 1ns / 100ps

module tb_architecture;
	reg clk;

  architecture uut (
    .clk(clk) 
	);

  // Clock generation
  always begin
    #5 clk = ~clk; 
  end

  // Reset generation
  initial begin
    clk = 0;
    #20; 
	 #1000 $finish;
  end

endmodule
