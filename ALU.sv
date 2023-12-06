module ALU #(parameter Width = 32)(
    input [3:0] controlsignal,
    input [Width-1:0] A1, A2,
    output reg [Width-1:0] Y,
    output zero
);
    always @(*)
    begin
        case (controlsignal)
            4'b0000: Y = A1 & A2; 				// and
            4'b0001: Y = A1 | A2; 				// or
            4'b0010: Y = A1 + A2; 				// add
            4'b0110: Y = A1 - A2; 				// sub
            4'b0011: Y = A1 << A2; 				// sll
            4'b0100: Y = (A1 < A2) ? 1 : 0; 	// slt (Set on Less Than)
            4'b0101: Y = (A1 < A2) ? 1 : 0; 	// sltu (Set on Less Than Unsigned)
            4'b0111: Y = A1 ^ A2; 				// xor
            4'b1000: Y = A1 >> A2; 				// sra (Arithmetic Right Shift)
            4'b1001: Y = (A1 < A2) ? 1 : 0; 	// srl (Logical Right Shift)
            4'b1010: Y = (A1 >>> A2); 			// srl (Logical Right Shift)
            4'b1100: Y = (A1 == A2) ? 1 : 0; // beq (Branch Equal)
            4'b1101: Y = (A1 != A2) ? 1 : 0; // bne (Branch Not Equal)
            4'b1110: Y = (A1 < A2) ? 1 : 0; 	// blt (Branch Less Than)
            4'b1111: Y = (A1 >= A2) ? 1 : 0; // bge (Branch Greater or Equal)
				4'b1011: Y = A2; 						// Forward without processing
            default: Y = {Width{1'bx}}; 		// Unknown operation
        endcase
        
    end
	 assign zero = (Y == 0) ? 1 : 0;
endmodule

