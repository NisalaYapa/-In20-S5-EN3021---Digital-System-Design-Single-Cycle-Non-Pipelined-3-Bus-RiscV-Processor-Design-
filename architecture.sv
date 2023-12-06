module architecture(
input clk,
input sw1, 
output wire [27:0] segments1,
output wire [27:0] segments2

);
	wire [31:0] d,e, Mux1output, ALUOut,ALUOut1, DataOutput, shiftoutput,Mux10output; //,Writedata //  RD1,RD2,
	wire [31:0]  PC, RD, PCPlus4; //
	wire [31:0] branchaddress ,PCinput; 
	wire [3:0] Control; 
	wire [1:0] Aluop,MemtoReg ;
	wire [31:0]PCaddress, Writedata;
	wire [31:0] RD1, RD2 ,immediateout;
	//reg PCen ;
	reg [31:0] tempRD;//addr
	//reg andOutput;
	wire MemCopy, mul ,MemCopy1 ;
	//reg en ;

	
	

	
		reg PCen = 1;       // added for testing
		reg [31:0] addr = 32'd0; //added for testing
		reg Asel = 0;       //added for testing
		reg andOutput = 0;
		int i = 0;
		int j = 0;
		reg en = 1;
		reg [31:0] disp = 32'd0896;//added for testing
		reg [31:0] disp2 = 32'd0856;//added for testing
		reg disp_en =1;
		
	

	
	always @(negedge clk) begin    // MemCopy instuction //negedge
	/////////////////////////////////////////////////////////////////////////////////////
	  
	  //disp = ALUOut;
	         if(sw1==1)
					begin
						disp_en <= 0;
						
					end
				else
					begin
                  disp_en <= 1;
					end
	
   
	//seg_disp_4digits_1 W5( ALUOut, disp_en, segments1);
	///////////////////////////////////////////////////////////////////////////////////////
	
	if(MemCopy || mul)
		begin
			if(MemCopy) 
			begin
				if(RD1 == i)
					begin
						PCen <= 1;
						
					end
				else
					begin
						i <= i + 1;
						PCen <= 0;
					end
			end
			else begin
				if(j==31)
					begin
						PCen <= 1;
						
					end
				else
					begin
						j <= j + 1;
						PCen <= 0;
					end
			end
		end
	else if(!MemCopy && !mul)   //else if(!MemCopy && !mul)
		begin
			addr <= PCaddress;
			i <=0;
			j <=0;
		end
	end  


	MUX #(32)M9(addr,ALUOut[31:0],jump,PCinput);   //(PCaddress,ALUOut[31:0],jump,PCinput);

	PCCounter P1(clk,PCen,addr,PC);  //PCinput (for addr)

	adder A1(PC,PCPlus4);

	assign MemCopy1 =  !PCen;

	instructionmemory I1(clk,PC,MemCopy1, mul, RD); //PC

	mainController M1(RD[6:0],ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,jump,Aluop,MemCopy,mul);  //Asel

	Registerfile R1(clk,RegWrite,RD[19:15],RD[24:20],RD[11:7],Writedata,RD1,RD2);

	Multiplier X1(clk,RD1,RD2,mul,result);

	immediategeneration S1(RD[31:0],immediateout);

	MUX #(32)M4(RD2,immediateout,ALUSrc,Mux1output);   //64

	ALUControl A3(Aluop,RD[30],RD[14:12],Control);

	MUX #(32)M10(RD1,PC,Asel,Mux10output);   //64

	ALU A2(Control,Mux10output,Mux1output,ALUOut,Zero);    //d instead of Mux10output

	DataMemory D1(clk,MemWrite,MemRead,ALUOut, RD2,DataOutput);    

	MUX #(32)M11(ALUOut,result,mul,ALUOut1); // connecting multiplier

	MUX1 #(32)M2(ALUOut1,DataOutput,PCPlus4,MemtoReg,Writedata);   //64   // e instead of PCPlus4  //MUX1 #(32)M2(ALUOut,DataOutput,PCPlus4,MemtoReg,Writedata);

	and Q1(andoutput,Branch,Zero);
	shift S12(immediateout,shiftoutput);
	add A23(PC,shiftoutput[31:0],branchaddress);
	MUX #(32)M3(PCPlus4,branchaddress,andoutput,PCaddress);  //(PCPlus4,branchaddress,andoutput,PCaddress);
	
 
	seg_disp_4digits_1 W3( PC, disp_en, segments1);
	seg_disp_4digits_2 W4( PC, disp_en, segments2);
	

	

endmodule
