module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	wire zero;
	wire [31:0] write,readRegA,readRegB,we;
	wire [31:0] out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31;
	or reg0_or(zero,ctrl_writeEnable,ctrl_reset);
	
	decoder decode_readRegA(ctrl_readRegA,readRegA);
	decoder decode_readRegB(ctrl_readRegB,readRegB);
	decoder decode_writeReg(ctrl_writeReg,write);
	
	and we_and0(we[0],ctrl_writeEnable,write[0]);
	and we_and1(we[1],ctrl_writeEnable,write[1]);
	and we_and2(we[2],ctrl_writeEnable,write[2]);
	and we_and3(we[3],ctrl_writeEnable,write[3]);
	and we_and4(we[4],ctrl_writeEnable,write[4]);
	and we_and5(we[5],ctrl_writeEnable,write[5]);
	and we_and6(we[6],ctrl_writeEnable,write[6]);
	and we_and7(we[7],ctrl_writeEnable,write[7]);
	and we_and8(we[8],ctrl_writeEnable,write[8]);
	and we_and9(we[9],ctrl_writeEnable,write[9]);
	and we_and10(we[10],ctrl_writeEnable,write[10]);
	and we_and11(we[11],ctrl_writeEnable,write[11]);
	and we_and12(we[12],ctrl_writeEnable,write[12]);
	and we_and13(we[13],ctrl_writeEnable,write[13]);
	and we_and14(we[14],ctrl_writeEnable,write[14]);
	and we_and15(we[15],ctrl_writeEnable,write[15]);
	and we_and16(we[16],ctrl_writeEnable,write[16]);
	and we_and17(we[17],ctrl_writeEnable,write[17]);
	and we_and18(we[18],ctrl_writeEnable,write[18]);
	and we_and19(we[19],ctrl_writeEnable,write[19]);
	and we_and20(we[20],ctrl_writeEnable,write[20]);
	and we_and21(we[21],ctrl_writeEnable,write[21]);
	and we_and22(we[22],ctrl_writeEnable,write[22]);
	and we_and23(we[23],ctrl_writeEnable,write[23]);
	and we_and24(we[24],ctrl_writeEnable,write[24]);
	and we_and25(we[25],ctrl_writeEnable,write[25]);
	and we_and26(we[26],ctrl_writeEnable,write[26]);
	and we_and27(we[27],ctrl_writeEnable,write[27]);
	and we_and28(we[28],ctrl_writeEnable,write[28]);
	and we_and29(we[29],ctrl_writeEnable,write[29]);
	and we_and30(we[30],ctrl_writeEnable,write[30]);
	and we_and31(we[31],ctrl_writeEnable,write[31]);
	
	
	register reg0(clock,we[0],data_writeReg,zero,out0);
	register reg1(clock,we[1],data_writeReg,ctrl_reset,out1);
	register reg2(clock,we[2],data_writeReg,ctrl_reset,out2);
	register reg3(clock,we[3],data_writeReg,ctrl_reset,out3);
	register reg4(clock,we[4],data_writeReg,ctrl_reset,out4);
	register reg5(clock,we[5],data_writeReg,ctrl_reset,out5);
	register reg6(clock,we[6],data_writeReg,ctrl_reset,out6);
	register reg7(clock,we[7],data_writeReg,ctrl_reset,out7);
	register reg8(clock,we[8],data_writeReg,ctrl_reset,out8);
	register reg9(clock,we[9],data_writeReg,ctrl_reset,out9);
	register reg10(clock,we[10],data_writeReg,ctrl_reset,out10);
	register reg11(clock,we[11],data_writeReg,ctrl_reset,out11);
	register reg12(clock,we[12],data_writeReg,ctrl_reset,out12);
	register reg13(clock,we[13],data_writeReg,ctrl_reset,out13);
	register reg14(clock,we[14],data_writeReg,ctrl_reset,out14);
	register reg15(clock,we[15],data_writeReg,ctrl_reset,out15);
	register reg16(clock,we[16],data_writeReg,ctrl_reset,out16);
	register reg17(clock,we[17],data_writeReg,ctrl_reset,out17);
	register reg18(clock,we[18],data_writeReg,ctrl_reset,out18);
	register reg19(clock,we[19],data_writeReg,ctrl_reset,out19);
	register reg20(clock,we[20],data_writeReg,ctrl_reset,out20);
	register reg21(clock,we[21],data_writeReg,ctrl_reset,out21);
	register reg22(clock,we[22],data_writeReg,ctrl_reset,out22);
	register reg23(clock,we[23],data_writeReg,ctrl_reset,out23);
	register reg24(clock,we[24],data_writeReg,ctrl_reset,out24);
	register reg25(clock,we[25],data_writeReg,ctrl_reset,out25);
	register reg26(clock,we[26],data_writeReg,ctrl_reset,out26);
	register reg27(clock,we[27],data_writeReg,ctrl_reset,out27);
	register reg28(clock,we[28],data_writeReg,ctrl_reset,out28);
	register reg29(clock,we[29],data_writeReg,ctrl_reset,out29);
	register reg30(clock,we[30],data_writeReg,ctrl_reset,out30);
	register reg31(clock,we[31],data_writeReg,ctrl_reset,out31);
	
	
	tristate buffA0(out0,readRegA[0],data_readRegA);
	tristate buffA1(out1,readRegA[1],data_readRegA);
	tristate buffA2(out2,readRegA[2],data_readRegA);
	tristate buffA3(out3,readRegA[3],data_readRegA);
	tristate buffA4(out4,readRegA[4],data_readRegA);
	tristate buffA5(out5,readRegA[5],data_readRegA);
	tristate buffA6(out6,readRegA[6],data_readRegA);
	tristate buffA7(out7,readRegA[7],data_readRegA);
	tristate buffA8(out8,readRegA[8],data_readRegA);
	tristate buffA9(out9,readRegA[9],data_readRegA);
	tristate buffA10(out10,readRegA[10],data_readRegA);
	tristate buffA11(out11,readRegA[11],data_readRegA);
	tristate buffA12(out12,readRegA[12],data_readRegA);
	tristate buffA13(out13,readRegA[13],data_readRegA);
	tristate buffA14(out14,readRegA[14],data_readRegA);
	tristate buffA15(out15,readRegA[15],data_readRegA);
	tristate buffA16(out16,readRegA[16],data_readRegA);
	tristate buffA17(out17,readRegA[17],data_readRegA);
	tristate buffA18(out18,readRegA[18],data_readRegA);
	tristate buffA19(out19,readRegA[19],data_readRegA);
	tristate buffA20(out20,readRegA[20],data_readRegA);
	tristate buffA21(out21,readRegA[21],data_readRegA);
	tristate buffA22(out22,readRegA[22],data_readRegA);
	tristate buffA23(out23,readRegA[23],data_readRegA);
	tristate buffA24(out24,readRegA[24],data_readRegA);
	tristate buffA25(out25,readRegA[25],data_readRegA);
	tristate buffA26(out26,readRegA[26],data_readRegA);
	tristate buffA27(out27,readRegA[27],data_readRegA);
	tristate buffA28(out28,readRegA[28],data_readRegA);
	tristate buffA29(out29,readRegA[29],data_readRegA);
	tristate buffA30(out30,readRegA[30],data_readRegA);
	tristate buffA31(out31,readRegA[31],data_readRegA);
	
	
	tristate buffB0(out0,readRegB[0],data_readRegB);
	tristate buffB1(out1,readRegB[1],data_readRegB);
	tristate buffB2(out2,readRegB[2],data_readRegB);
	tristate buffB3(out3,readRegB[3],data_readRegB);
	tristate buffB4(out4,readRegB[4],data_readRegB);
	tristate buffB5(out5,readRegB[5],data_readRegB);
	tristate buffB6(out6,readRegB[6],data_readRegB);
	tristate buffB7(out7,readRegB[7],data_readRegB);
	tristate buffB8(out8,readRegB[8],data_readRegB);
	tristate buffB9(out9,readRegB[9],data_readRegB);
	tristate buffB10(out10,readRegB[10],data_readRegB);
	tristate buffB11(out11,readRegB[11],data_readRegB);
	tristate buffB12(out12,readRegB[12],data_readRegB);
	tristate buffB13(out13,readRegB[13],data_readRegB);
	tristate buffB14(out14,readRegB[14],data_readRegB);
	tristate buffB15(out15,readRegB[15],data_readRegB);
	tristate buffB16(out16,readRegB[16],data_readRegB);
	tristate buffB17(out17,readRegB[17],data_readRegB);
	tristate buffB18(out18,readRegB[18],data_readRegB);
	tristate buffB19(out19,readRegB[19],data_readRegB);
	tristate buffB20(out20,readRegB[20],data_readRegB);
	tristate buffB21(out21,readRegB[21],data_readRegB);
	tristate buffB22(out22,readRegB[22],data_readRegB);
	tristate buffB23(out23,readRegB[23],data_readRegB);
	tristate buffB24(out24,readRegB[24],data_readRegB);
	tristate buffB25(out25,readRegB[25],data_readRegB);
	tristate buffB26(out26,readRegB[26],data_readRegB);
	tristate buffB27(out27,readRegB[27],data_readRegB);
	tristate buffB28(out28,readRegB[28],data_readRegB);
	tristate buffB29(out29,readRegB[29],data_readRegB);
	tristate buffB30(out30,readRegB[30],data_readRegB);
	tristate buffB31(out31,readRegB[31],data_readRegB);
endmodule