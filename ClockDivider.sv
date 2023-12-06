module ClockDivider (
    input wire clk_50MHz,  // Assuming 50MHz clock from DE2 115 FPGA board
    output [27:0] segments1 ,    // Output 1Hz clock signal
	 output [27:0] segments2 , 
	 input wire sw1
);

reg [24:0] count = 0;
reg clk_1Hz;

always @(posedge clk_50MHz) begin
    if (count == 30000000) begin // For a 50MHz clock, 50,000,000 cycles per second, so divide by 50,000,000 to get 1Hz
        clk_1Hz <= ~clk_1Hz;    // Toggle the output every 25,000,000 cycles (1Hz)
        count <= 0;
    end else begin
        count <= count + 1;
    end
end
 architecture uut ( clk_1Hz, sw1, segments1, segments2);
	

endmodule