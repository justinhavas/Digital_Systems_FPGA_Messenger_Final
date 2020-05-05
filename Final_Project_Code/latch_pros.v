module latch_pros(clock,en,res,pc,instruct,valA,valB,pcOut,instructOut,valAOut,valBOut);
	input clock, en, res;
	input [31:0] pc, instruct, valA, valB;
	output [31:0] pcOut, instructOut, valAOut, valBOut;
	
	register pcReg(clock,en,pc,res,pcOut);
	register insReg(clock,en,instruct,res,instructOut);
	register valAReg(clock,en,valA,res,valAOut);
	register valBReg(clock,en,valB,res,valBOut);
endmodule