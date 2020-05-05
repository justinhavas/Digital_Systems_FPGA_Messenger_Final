/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile
	 ps2_data_ready,
	 is_enter,
	 reset_ps2,
	 ps2_ascii_code,
	 allAscii,
	 outAscii,
	 transmitting,
	 outAscii_ready,
	 receiving,
	 receivingChar
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem; // send out address you want
    input [31:0] q_imem; // get back instruction

    // Dmem
    output [11:0] address_dmem; // send out address to write to in data
    output [31:0] data; // send out the data you want written
    output wren; // whether to write enable into the memory
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 // ps2
	 input ps2_data_ready, is_enter, transmitting, receiving;
	 output reset_ps2, outAscii_ready;
	 input [7:0] ps2_ascii_code, receivingChar;
	 output [31:0] allAscii, outAscii;
	 

    /* YOUR CODE STARTS HERE */
	 wire [31:0] pc_next, pc_address, pc_address1, nop, in_FD, pc_D, ins_D, in_DX, pc_X, ins_X, valA_X, valB_X, pc_M, ins_M, valA_M, valB_M, pc_W, ins_W, valA_W, valB_W, immed, toALU_B, alu_result, alu_result1, to_jal_mux, jal_j, jump_to, go, pc_or_go, j_X, Rs1_X32, Rs2_X32, Rs2_M32, Rd_M32, Rd_W32, Rd_X32, R_X32, R_M32, decoded_A, decoded_B, decoded_z, operandA, operandB, operandBM, decoded_ALUopD;
	 wire [31:0] Rs1_D32, Rs2_D32, Rd_D32, R_D32, instruct_num, decoded_ALU, to_XM, rstatus_ins, to_XMins, to_next_alu_result, multdiv_result, multdiv_result_out, to_next_alu_result1, A, B, ps2_ready, to_before_XM1, to_before_XM2, to_before_XM3, to_before_XM4, to_before_XM5, to_before_XM6, to_before_XM7, ps2_enter, asciiOut, asciiReg, transmit_ready, outTransmit, receive_ready, receive_char;
	 wire [26:0] jump;
	 wire [4:0] ALUop_D, ALUop_X, Rd_D, Rs1_D, Rs2_D, Rd_X, Rs1_X, Rs2_X, sham, Rd_M, Rs2_M, Rd_W, ctrl_A, ctrl_B;
	 wire sw_switchD, sw_switchX, ALUinB, br, not_br, jp, jr, isNotEqual, isLessThan, z, branchTrue, overflow, Rwe_M, DMwe, sw_switchM, Rwe_W, Rwd, jal, not_jr, doBR, notEqual_AMX, equal_AMX, equalA_M, notEqual_AWX, equal_AWX, equalA_W, notEqual_BMX, equal_BMX, equalB_M, notEqual_BWX, equal_BWX, equalB_W, notEqual_WM, equal_WM0, equal_WM, ALUop_sw, to_stall, to_and, to_or, notEqual_stall, equal_stall, notEqual_stall1, equal_stall1, not_clock;
	 wire stall, not_stall, nop0, nop1, not_equal_reg0_M, not_equal_reg0_W, ovf_MUX, bex_or_jp, do_bex, doMult, doDiv, multdiv_exception, multdiv_RDY, mult_or_div, notMult_or_div, en_latch, not_multStall, multStall, into_multStall, reset_multStall, to_or_resetStall, reset_ovf_or_result, multdiv_exception_out, final_exception, to_stall1;
	 wire [31:0] rando_valA, rando_valB, rando_immed0, rando_immed2, rando_immed3, rando_result0, rando_result1, rando_result2, rando_result3, rando_result4; /* rando wires*/
	 wire [26:0] rando_jump0, rando_jump2, rando_jump3; /* rando wires*/
	 wire [4:0] rando_sham0, rando_ALUop2, rando_Rs12, rando_sham2, rando_ALUop3, rando_Rs13, rando_Rs23, rando_sham3; /* rando wires*/
	 wire rando_rwe0, rando_rwe1, rando_alub0, rando_dmwe0, rando_dmwe1, rando_rwd0, rando_rwd1, rando_br0, rando_jp0, rando_jal0, rando_jal1, rando_jr0, rando_alub2, rando_rwd2, rando_br2, rando_jp2, rando_jal2, rando_jr2, rando_alub3, rando_DMwe3, rando_br3, rando_jp3, rando_jr3,rando_swswitch3, rando_overflow4, rando_overflow5, rando_overflow6, rando_less0, rando_ovf0; /* rando wires*/
	 wire rando_less1, rando_ovf1, rando_less2, rando_ovf2, rando_less3, rando_ovf3, rando_less4, rando_ovf4, rando_result5, rando_less5, rando_ovf5, rando_result6, rando_less6, rando_ovf6; /* rando wires*/
	 
	 // create nop
	 assign nop = 32'b0;
	 
	 // fetch the instruction
	 register pcReg(clock,en_latch,pc_next,reset,pc_address); 
	 assign address_imem = pc_address[11:0];
	 csa_adder getPC1(pc_address,32'b0,1'd1,pc_address1,rando_overflow6); // compute pc+1
	 
	 
	 // setup decode nop for flush
	 or nopctrl(nop0,doBR,jp);
	 mux_32bit flush0(q_imem,nop,nop0,in_FD);
	 
	 //// FD latch and stage
	 latch_pros FD(clock,en_latch,reset,pc_address1,in_FD,32'b0,32'b0,pc_D,ins_D,rando_valA,rando_valB); 
	 // decode FD instruction
	 instructDecode FDdecode(ins_D,rando_jump0,rando_rwe0,rando_alub0,ALUop_D,rando_dmwe0,rando_rwd0,rando_br0,rando_jp0,rando_jal0,Rd_D,Rs1_D,Rs2_D,rando_immed0,rando_sham0,rando_jr0,sw_switchD);
	 // regfile connections 
	 assign ctrl_readRegA = Rs1_D;
	 assign ctrl_readRegB = sw_switchD ? Rd_D : Rs2_D;
	 
	 // setup execute nop for flush
	 or nopctrl1(nop1,stall,doBR,jp);
	 mux_32bit flush1(ins_D,nop,nop1,in_DX);
	 
	 //// DX latch and stage
	 latch_pros DX(clock,not_multStall,reset,pc_D,in_DX,data_readRegA,data_readRegB,pc_X,ins_X,valA_X,valB_X);
	 // decode DX instruction
	 instructDecode DXdecode(ins_X,jump,rando_rwe1,ALUinB,ALUop_X,rando_dmwe1,rando_rwd1,br,jp,rando_jal1,Rd_X,Rs1_X,Rs2_X,immed,sham,jr,sw_switchX);
	 // alu setup
	 mux_32bit Boperand(operandB,immed,ALUinB,toALU_B);
	 mux_32bit bltMux0(operandA,toALU_B,br,A); // add weird case for branches
	 mux_32bit bltMux1(toALU_B,operandA,br,B);
	 alu alu_X(A,B,ALUop_X,sham,alu_result,isNotEqual,isLessThan,overflow);
	 // decode for z
	 decoder get_instruct1(ins_X[31:27],decoded_z);
	 tristate_1bit zTri(isNotEqual,decoded_z[2],z);
	 tristate_1bit zTri2(isLessThan,decoded_z[6],z);
	 tristate_1bit out_z(z,br,branchTrue);
	 // send out alu_result
	 not not_z(not_br,br);
	 tristate aluTri(alu_result,not_br,alu_result1);
	 
	 // implementing multdiv
	 // mult = decoded_ALU[6], div = decoded_ALU[7]
	 and andMult(doMult,not_multStall,decoded_ALU[6]);
	 and andDiv(doDiv,not_multStall,decoded_ALU[7]);
	 multdiv my_mult(operandA,toALU_B,doMult,doDiv,clock,multdiv_result,multdiv_exception,multdiv_RDY);
	 or orMultDiv(mult_or_div,decoded_ALU[6],decoded_ALU[7]);
	 not elseMultDiv(notMult_or_div,mult_or_div);
	 // make not_multStall
	 and andForMultStall(into_multStall,mult_or_div,not_multStall);
	 dflipflop resMultStall(to_or_resetStall,multdiv_RDY,not_clock,multdiv_RDY,not_multStall);
	 or ormultStall(reset_multStall,reset,to_or_resetStall);
	 dflipflop multStallflip(multStall,into_multStall,not_clock,into_multStall,reset_multStall);
	 not notmultStall(not_multStall,multStall);
	 // make result register and multdiv exception dffe
	 or orResetMultDiv(reset_ovf_or_result,reset,notMult_or_div);
	 register multResultReg(not_clock,1'b1,multdiv_result,reset_ovf_or_result,multdiv_result_out);
	 dflipflop exceptionflip(multdiv_exception_out,multdiv_exception,not_clock,multdiv_exception,reset_ovf_or_result);
	 
	 // computing the overflow, guarded by jump since that could lead to error
	 or orTotalOverflow(final_exception,overflow,multdiv_exception_out);
	 mux_1bit getALUovf(final_exception,1'b0,jp,ovf_MUX);
	 
	 decoder decode_ALUop(ALUop_X,decoded_ALU);
	 tristate add_ins(32'd1,decoded_ALU[0],instruct_num);
	 tristate addi_ins(32'd2,decoded_z[5],instruct_num);
	 tristate sub_ins(32'd3,decoded_ALU[1],instruct_num);
	 tristate mul_ins(32'd4,decoded_ALU[6],instruct_num);
	 tristate div_ins(32'd5,decoded_ALU[7],instruct_num);
	 mux_32bit setSetx(alu_result1,jump_to,decoded_z[21],to_next_alu_result); //setting setx
	 mux_32bit sendInMultResult(to_next_alu_result,multdiv_result_out,mult_or_div,to_next_alu_result1); // sending out multdiv result
	 mux_32bit XM_valA(to_next_alu_result1,instruct_num,ovf_MUX,to_before_XM1);
	 assign rstatus_ins[31:27] = 5'd21;
	 assign rstatus_ins[26:0] = 27'b0; // value here doesn't matter since actual target found in instruct_num
	 mux_32bit XM_ins(ins_X,rstatus_ins,ovf_MUX,to_XMins);
	 
	 // take care of ps2 stuff
	 assign ps2_ready[31:1] = 31'b0;

	 assign ps2_ready[0] = ps2_data_ready; //PUT THAT BACK WHEN ACTUALLY USING PS2
	 //assign ps2_ready[0] = 1'b1;
	 assign ps2_enter[31:1] = 31'b0;
	 assign ps2_enter[0] = is_enter; //PUT THAT BACK WHEN ACTUALLY USING PS2
	 //assign ps2_enter[0] = 1'b1;
	 
	 assign asciiReg[31:8] = 24'b0;
	 assign asciiReg[7:0] = ps2_ascii_code;
	 //assign asciiReg[7:0] = 8'd10;
	 
	 // for transmit output, have first 24 bits as zero REMEMBER TO INITIALIZE THIS
	 assign transmit_ready[31:1] = 31'b0;
	 assign transmit_ready[0] = ~transmitting; 
	 //assign transmit_ready[0] = 1'b1;
	 assign outTransmit[31:8] = 24'b0;
	 assign outTransmit[7:0] = A[7:0];
	 
	 // receiving stuff
	 assign receive_ready[31:1] = 31'b0;
	 assign receive_ready[0] = receiving;
	 
	 assign receive_char[31:8] = 24'b0;
	 assign receive_char[7:0] = receivingChar;

    mux_32bit XM_valAwithPs2(to_before_XM1,ps2_ready,decoded_z[9],to_before_XM2); //priortize check ready over exceptions 
	 mux_32bit XM_valAwithPs2a(to_before_XM2,ps2_enter,decoded_z[10],to_before_XM3);
	 mux_32bit XM_valAwithPs2b(to_before_XM3,asciiReg,decoded_z[13],to_before_XM4);
	 mux_32bit XM_valAwithPs2c(to_before_XM4,transmit_ready,decoded_z[14],to_before_XM5);
	 mux_32bit XM_valAwithPs2d(to_before_XM5,outTransmit,decoded_z[15],to_before_XM6);
	 mux_32bit XM_valAwithPs2e(to_before_XM6,receive_ready,decoded_z[16],to_before_XM7);
	 mux_32bit XM_valAwithPs2f(to_before_XM7,receive_char,decoded_z[17],to_XM);

	 assign asciiOut[31:22] = 10'b0;
	 assign asciiOut[21:14] = receive_ready[0] ? receivingChar : ps2_ascii_code;
	 //assign asciiOut[21:14] = 8'd10;
	 assign asciiOut[13:7] = A[6:0];
	 assign asciiOut[6:0] = B[6:0];
	 register asciiStore(clock,((ps2_ready[0]|receive_ready[0])&decoded_z[11]),asciiOut,reset,allAscii);
	 mux_1bit resetPs2(1'b0,1'd1,decoded_z[12],reset_ps2);
	 register outAsciiReg(clock,transmit_ready[0]&decoded_z[15],outTransmit,reset,outAscii);
	 dflipflop outAsciiEnable(outAscii_ready,decoded_z[15],clock,decoded_z[15],reset|transmitting);
	 
	 
	 
	 
	 
	 // compute the branch or jump
	 assign jump_to[26:0] = jump;
	 assign jump_to[31:27] = pc_X[31:27];
	 //compute go
	 not notJr(not_jr,jr);
	 tristate go1(jump_to,not_jr,go);
	 tristate go2(operandA,jr,go);
	 //compute branch
	 csa_adder getBranch(pc_X,immed,1'd0,j_X,rando_overflow5); //compute j_X here, a little different from drawn out
	 and andBr(doBR,br,branchTrue);
	 mux_32bit pcorbr(pc_address1,j_X,doBR,pc_or_go);
	 
	 // do regular jump along with bex
	 and andbex(do_bex,isNotEqual,decoded_z[22]); // isn't guarded, just goes off isNotEqual
	 or orjp(bex_or_jp,do_bex,jp);
	 mux_32bit pcorgo(pc_or_go,go,bex_or_jp,pc_next);
	 
	 //// XM latch and stage
	 latch_pros XM(clock,not_multStall,reset,pc_X,to_XMins,to_XM,operandB,pc_M,ins_M,valA_M,valB_M);
	 // decode XM instruction
	 instructDecode XMdecode(ins_M,rando_jump2,Rwe_M,rando_alub2,rando_ALUop2,DMwe,rando_rwd2,rando_br2,rando_jp2,rando_jal2,Rd_M,rando_Rs12,Rs2_M,rando_immed2,rando_sham2,rando_jr2,sw_switchM);
	 // go into dmem
	 assign address_dmem = valA_M[11:0];
	 assign data = operandBM; 
	 assign wren = DMwe;
	 
	 //// MW latch and stage
	 latch_pros MW(clock,not_multStall,reset,pc_M,ins_M,valA_M,q_dmem,pc_W,ins_W,valA_W,valB_W);
	 // decode MW instruction
	 instructDecode MWdecode(ins_W,rando_jump3,Rwe_W,rando_alub3,rando_ALUop3,rando_DMwe3,Rwd,rando_br3,rando_jp3,jal,Rd_W,rando_Rs13,rando_Rs23,rando_immed3,rando_sham3,rando_jr3,rando_swswitch3);
	 // complete regFile outputs
	 mux_32bit writeBack(valA_W,valB_W,Rwd,to_jal_mux);
	 mux_32bit writeReg(to_jal_mux,pc_W,jal,data_writeReg); // changed jal_j to pc_W since pc_W is already pc + 1
	 assign ctrl_writeEnable = Rwe_W;
	 assign ctrl_writeReg = Rd_W;
	 
	 //// Adding bypass logic
	 // sign extend the registers
	 sign_extendReg rds1(Rs1_X,Rs1_X32);
	 sign_extendReg rds2(Rs2_X,Rs2_X32);
	 sign_extendReg rds2o(Rs2_M,Rs2_M32);
	 sign_extendReg rd(Rd_X,Rd_X32);
	 sign_extendReg rd3(Rd_M,Rd_M32);
	 sign_extendReg rdo(Rd_W,Rd_W32);
	 // check if destinations equal to register zero 
	 not_equal_reg0 regRdM(Rd_M,not_equal_reg0_M);
	 not_equal_reg0 regRdW(Rd_W,not_equal_reg0_W);
	 // using the not equal of alu's to compute
	 alu AMX(Rs1_X32,Rd_M32,5'd1,5'd0,rando_result0,notEqual_AMX,rando_less0,rando_ovf0);
	 not notAMX(equal_AMX,notEqual_AMX);
	 and andAMX(equalA_M,equal_AMX,Rwe_M,not_equal_reg0_M);
	 
	 alu AWX(Rs1_X32,Rd_W32,5'd1,5'd0,rando_result1,notEqual_AWX,rando_less1,rando_ovf1);
	 not notAWX(equal_AWX,notEqual_AWX);
	 and andAWX(equalA_W,equal_AWX,Rwe_W,not_equal_reg0_W);
	 
	 mux_32bit rs2orrd(Rs2_X32,Rd_X32,sw_switchX,R_X32);
	 alu BMX(R_X32,Rd_M32,5'd1,5'd0,rando_result2,notEqual_BMX,rando_less2,rando_ovf2);
	 not notBMX(equal_BMX,notEqual_BMX);
	 and andBMX(equalB_M,equal_BMX,Rwe_M,not_equal_reg0_M);
	 
	 alu BWX(R_X32,Rd_W32,5'd1,5'd0,rando_result3,notEqual_BWX,rando_less3,rando_ovf3);
	 not notBWX(equal_BWX,notEqual_BWX);
	 and andBWX(equalB_W,equal_BWX,Rwe_W,not_equal_reg0_W);
	 
	 mux_32bit rs2orrd0(Rs2_M32,Rd_M32,sw_switchM,R_M32);
	 alu WM(R_M32,Rd_W32,5'd1,5'd0,rando_result4,notEqual_WM,rando_less4,rando_ovf4);
	 not notWM(equal_WM0,notEqual_WM);
	 and andWM(equal_WM,equal_WM0,Rwe_W,not_equal_reg0_W);
	 
	 assign ctrl_A[4:2] = 3'b0;
	 assign ctrl_A[1] = equalA_W;
	 assign ctrl_A[0] = equalA_M;
	 
	 assign ctrl_B[4:2] = 3'b0;
	 assign ctrl_B[1] = equalB_W;
	 assign ctrl_B[0] = equalB_M;
	 
	 decoder decodeA(ctrl_A,decoded_A);
	 decoder decodeB(ctrl_B,decoded_B);
	 tristate A0(valA_X,decoded_A[0],operandA);
	 tristate A1(valA_M,decoded_A[1],operandA);
	 tristate A2(to_jal_mux,decoded_A[2],operandA);
	 tristate A3(valA_M,decoded_A[3],operandA);
	 
	 tristate B0(valB_X,decoded_B[0],operandB);
	 tristate B1(valA_M,decoded_B[1],operandB);
	 tristate B2(to_jal_mux,decoded_B[2],operandB);
	 tristate B3(valA_M,decoded_B[3],operandB);
	 
	 
	 mux_32bit WMbypass(valB_M,to_jal_mux,equal_WM,operandBM);
	 
	 //// Adding stall logic
	 // sign extend registers
	 sign_extendReg rds1h(Rs1_D,Rs1_D32);
	 sign_extendReg rds2h(Rs2_D,Rs2_D32);
	 sign_extendReg rdh(Rd_D,Rd_D32);
	 // use the alu not equals again if not opcode
	 decoder get_instruct2(in_DX[31:27],decoded_ALUopD); // for store word
	 not notsw(ALUop_sw,decoded_ALUopD[7]);
	 
	 mux_32bit rs2orrdd(Rs2_D32,Rd_D32,sw_switchD,R_D32);
	 alu alu_stall(R_D32,Rd_X32,5'd1,5'd0,rando_result5,notEqual_stall,rando_less5,rando_ovf5);
	 not notstall(equal_stall,notEqual_stall);
	 
	 alu alu_stall1(Rs1_D32,Rd_X32,5'd1,5'd0,rando_result6,notEqual_stall1,rando_less6,rando_ovf6);
	 not notstall1(equal_stall1,notEqual_stall1);
	 
	 and andToOr(to_or,ALUop_sw,equal_stall);
	 or orStall(to_and,to_or,equal_stall1);
	 and andStall(to_stall,decoded_z[8],to_and);
	 or orfinalStallgate(to_stall1,to_stall,mult_or_div); // this is for the one stall for multdiv operations
	 
	 not notClok(not_clock,clock);
	 dflipflop stallflipflop(stall,to_stall1,not_clock,1'd1,reset);
	 not notstalling(not_stall,stall);
	 and andStallandMult(en_latch,not_stall,not_multStall);
endmodule
