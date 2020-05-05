module instructDecode(instruct,jump_address,Rwe,ALUinB,ALUop,DMwe,Rwd,br,jp,jal,Rd,Rs1,Rs2,immed,sham,jr,sw_switch);
	input [31:0] instruct;
	output [26:0] jump_address;
	output Rwe, ALUinB, DMwe, Rwd, br, jp, jal, jr, sw_switch;
	output [4:0] ALUop, Rd, Rs1, Rs2, sham;
	output [31:0] immed;
	
	wire I, JI, JII, I_add, I_sub;
	wire [31:0] decoded, imm;
	
	
	// decode instruction to determine type
	decoder get_instruct(instruct[31:27],decoded);
	
	// setup outputs if R-type
	tristate_5bit Rd0(instruct[26:22],decoded[0],Rd);
	tristate_5bit Rs10(instruct[21:17],decoded[0],Rs1);
	tristate_5bit Rs20(instruct[16:12],decoded[0],Rs2);
	tristate_5bit sham0(instruct[11:7],decoded[0],sham);
	tristate_5bit ALU0(instruct[6:2],decoded[0],ALUop);
	
	// check if I-type and setup outputs
	or or_I(I,decoded[5],decoded[7],decoded[8],decoded[2],decoded[6]);
	//or or_I_branch(I_branch,decoded[2],decoded[6]);
	//or or_together(I,I_branch,I_first);
	or or_Iadd(I_add,decoded[5],decoded[7],decoded[8]);
	or or_Isub(I_sub,decoded[2],decoded[6]);
	tristate_5bit Rd1(instruct[26:22],I,Rd); 
	tristate_5bit Rs11(instruct[21:17],I,Rs1);
	//tristate_5bit Rd11(instruct[26:22],I_branch,Rs1); // flipped this from logisim, branch causes weird thing
	//tristate_5bit Rs111(instruct[21:17],I_branch,Rd);
	tristate_5bit ALU1a(5'b0,I_add,ALUop);
	tristate_5bit ALU1b(5'd1,I_sub,ALUop);
	sign_extend extend(instruct[16:0],imm);
	assign immed = I ? imm : 32'bz; 
	
	// check if JI-type
	or or_JI(JI,decoded[1],decoded[3],decoded[22],decoded[21]); //make sure to remember to implement the bex and setx
	//don't forget to set jump and link register
	tristate_5bit Rdj(5'd31,decoded[3],Rd);
	tristate_5bit Rdx(5'd30,decoded[21],Rd); // set setx register
	assign jump_address = JI ? instruct[26:0] : 27'bz;
	// take care of bex
	tristate_5bit bexALU(5'd1,decoded[22],ALUop);
	tristate_5bit bexRs1(5'd30,decoded[22],Rs1);
	tristate_5bit bexRs2(5'b0,decoded[22],Rs2);
	
	
	//check if JII-type
	tristate_5bit Rd2(instruct[26:22],decoded[4],Rs1); // BUG Rd); how is this Rd, should be Rs1
	
	// ps2 instructions
	tristate_5bit Rd3(5'd15,decoded[9],Rd);
	tristate_5bit Rd4(5'd14,decoded[10],Rd);
	tristate_5bit Rs1p(instruct[26:22],decoded[11],Rs1);
	tristate_5bit Rs2p(instruct[21:17],decoded[11],Rs2);
	
	// storing ps2 ascii to dmem
	tristate_5bit Rd25(5'd25,decoded[13],Rd);
	tristate_5bit Rd18(5'd18,decoded[14],Rd); // chTransmit
	tristate_5bit Rs1t(5'd28,decoded[15],Rs1); //outTransmit
	tristate_5bit Rd28(5'd28,decoded[15],Rd); //outTransmit
	tristate_5bit Rd19(5'd19,decoded[16],Rd); // chReceiving
	tristate_5bit Rd28a(5'd28,decoded[17],Rd); // chReceivingChar
	
	
	
	// control stuff based off alu op and opcode ADD bex and setx and multdiv logic
	or or_Rwe(Rwe,decoded[0],decoded[5],decoded[8],decoded[3],decoded[21],decoded[9],decoded[10],decoded[13],decoded[14],decoded[15],decoded[16],decoded[17]); // all R type, addi, lw, jal, and setx
	or or_br(br,decoded[2],decoded[6]); // same signal as z in the processor
	or or_jp(jp,decoded[1],decoded[4],decoded[3]);
	or or_ALUinB(ALUinB,decoded[5],decoded[7],decoded[8]);
	or or_sw(sw_switch,decoded[7],decoded[2],decoded[6]); 
	assign DMwe = decoded[7];
	assign Rwd = decoded[8];
	assign jal = decoded[3];
	assign jr = decoded[4];
endmodule