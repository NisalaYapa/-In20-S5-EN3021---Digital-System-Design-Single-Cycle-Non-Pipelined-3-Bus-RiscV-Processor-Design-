module Multiplier (
	 input wire clk,
    input wire [31:0] operand1,
    input wire [31:0] operand2,
    input wire mul,
    output reg [31:0] result
);
    reg [31:0] shift_reg;    // Register to hold the shift output
    reg [31:0] operand1_reg; // Register to hold operand1
    reg [31:0] operand2_reg; // Register to hold operand2
    reg [5:0]  counter;
	 reg enable;
	 
	 initial begin
	   enable = 1;
		counter = 5'b0;
		shift_reg = 32'b0;
		result = 32'b0;
	
	 end

    always @(negedge clk) begin
        if (mul && enable) begin
            operand1_reg <= operand1;
            operand2_reg <= operand2;
            enable <= 0;
        end
        
        if (mul && !(enable)) begin
            // Shift operand2 left by 1 bit in each iteration
            shift_reg <= {operand2_reg[30:0], 1'b0};
            operand2_reg <= shift_reg;
            
            // Add operand1 to result if the LSB of operand1 is 1
            if (operand1_reg[0]) begin
                result <= result + operand2_reg;
            end
            
            // Right shift operand1 in each iteration
            operand1_reg <= operand1_reg >> 1;
            
            // Increment the counter
            counter <= counter + 1;
        end
    end
endmodule
   

