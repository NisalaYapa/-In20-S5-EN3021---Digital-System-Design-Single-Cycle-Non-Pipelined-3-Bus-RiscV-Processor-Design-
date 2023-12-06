module mainController(
	input [6:0] Opcode,
	output ALUSrc,
	output [1:0] MemtoReg,
	output RegWrite,
	output MemRead,
	output MemWrite,
	output Branch,
	output jump,
	output [1:0] Aluop,
	output MemCopy,
	output mul);
	reg [11:0] control;
	assign {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,jump,Aluop,MemCopy,mul} = control;    //Alusel for selecting rd2 or immediate output
	always @(*)
	begin
		case(Opcode)
		7'b0110011 : control <= 12'b000100001000; // R-type   
		7'b0000011 : control <= 12'b101110000000; // lw-type   
		7'b0100011 : control <= 12'b101001000000; // s-type    ;
		7'b1100011 : control <= 12'b00x000100100; // sb-type
		7'b0010011 : control <= 12'b100100001100; // I-type                      
		7'b1100111 : control <= 12'b1111xx010000; // jalr-type
		7'b1101111 : control <= 12'b0111xx010000; // jal-type
		7'b1000000 : control <= 12'b001110000010; // MemCopy
		7'b1111111 : control <= 12'b001110000001; // MUL

		default : control    <= 12'b0xxxxxxxxx00;  // xxxxxxxxx
		endcase
	end
endmodule
