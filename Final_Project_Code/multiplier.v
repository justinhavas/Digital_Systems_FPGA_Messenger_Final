module multiplier(data_operandA, data_operandB, clock, mult, data_result, data_overflow, data_ready);
input [31:0] data_operandA,data_operandB;
input clock,mult;
output [31:0] data_result;
output data_overflow, data_ready;


wire [63:0] start_product,in_product,product,shift_product,after_shift;
wire [31:0] alu_result,shift_result,decoder_result,to_product,for_counter,to_add_one,rando_alu,rando_alu2,rando_alu3,rando_alu4,rando_alu5;
wire [4:0] ctrl_opcode,alu_opcode;
wire not_equal,less_than,overflow,helper_bit,not_ready,not_mult,count_overflow,overflow_dffe,other_overflow,notEqual_result,rando_lt2,rando_ovf2;
wire tris1,tris2,tris3,tris4,tris5,rando_ne,lessThan1,rando_ovfn,rando_ne1,lessThan2,rando_ovfn1,another_overflow,pos_sign1,pos_sign2,pos_sign3,pos_sign4,another_overflow1;

not ready(not_ready,data_ready);

// inital start product
assign start_product[31:0] = data_operandB;
assign start_product[63:32] = 32'b0;

tristate_64bit startProd(start_product,mult,in_product);

// make the product register
product_register myreg(clock,not_ready,in_product,1'b0,product);

// build the control
assign ctrl_opcode[4:3] = 2'b00;
assign ctrl_opcode[2:1] = product[1:0];
assign ctrl_opcode[0] = helper_bit;
decoder decode(ctrl_opcode,decoder_result);


// implement modified Booth's
or or1(tris1,decoder_result[0],decoder_result[7]); // do nothing
or or2(tris2,decoder_result[1],decoder_result[2],decoder_result[5],decoder_result[6]); // regular
or or3(tris3,decoder_result[3],decoder_result[4]); // shifted
or or4(tris4,decoder_result[0],decoder_result[1],decoder_result[2],decoder_result[3],decoder_result[7]); //add
or or5(tris5,decoder_result[4],decoder_result[5],decoder_result[6]); //sub



tristate doNone(32'b0,tris1,to_product);
tristate useMult(data_operandA,tris2,to_product);
tristate useShiftMult(data_operandA<<1,tris3,to_product);
tristate useAdd(5'b0,tris4,alu_opcode);
tristate useSub(5'b00001,tris5,alu_opcode);

// now ready for the alu
alu myAlu(product[63:32],to_product,alu_opcode,5'b0,alu_result,not_equal,less_than,overflow);
tristate trime(alu_result,not_ready,shift_product[63:32]);
//shift output of alu
assign shift_product[31:0] = product[31:0];
// this code be a debug area //
assign after_shift = shift_product>>>2;
//shiftRight byTwo1(shift_product[31:0],4'b0010,after_shift[31:0]);
//assign after_shift[31:30] = shift_product[33:32];
//shiftRight byTwo2(shift_product[63:32],4'b0010,after_shift[63:32]);
not notMult(not_mult,mult);
tristate_64bit shiftedInProduct(after_shift,not_mult,in_product);

// take care of helper bit
dflipflop helperDffe(helper_bit,product[1],clock,1'b1,mult);

// take care of exception
dflipflop overflowDffe(overflow_dffe,overflow,clock,overflow,mult);
xor otherOverflow(other_overflow,data_result[31],data_operandA[31],data_operandB[31]);
alu isZero(32'b0,product[31:0],5'b00001,5'b0,rando_alu,notEqual_result,rando_lt2,rando_ovf2);
and and11(other_overflow1,notEqual_result,other_overflow);
alu isLessThan1(data_result,data_operandA,5'b00001,5'b0,rando_alu2,rando_ne,lessThan1,rando_ovfn);
alu isLessThan2(data_result,data_operandB,5'b00001,5'b0,rando_alu3,rando_ne1,lessThan2,rando_ovfn1);
not notSign1(pos_sign1,data_operandA[31]);
not notSign2(pos_sign2,data_operandB[31]);
and and17(another_overflow,lessThan1,lessThan2,pos_sign1,pos_sign2);
//check if all ones or all zeros in upper product, apparently not working
//and and18(pos_sign3,product[63],product[62],product[61],product[60],product[59],product[58],product[57],product[56],product[55],product[54],product[53],product[52],product[51],product[50],product[49],product[48],product[47],product[46],product[45],product[44],product[43],product[42],product[41],product[40],product[39],product[38],product[37],product[36],product[35],product[34],product[33],product[32],product[31]);
//nor nor1(pos_sign4,product[63],product[62],product[61],product[60],product[59],product[58],product[57],product[56],product[55],product[54],product[53],product[52],product[51],product[50],product[49],product[48],product[47],product[46],product[45],product[44],product[43],product[42],product[41],product[40],product[39],product[38],product[37],product[36],product[35],product[34],product[33],product[32],product[31]);
//nor nor20(another_overflow1,pos_sign3,pos_sign4);




or or10(data_overflow,other_overflow1,overflow_dffe,another_overflow,another_overflow1);


// implement counter
csa_adder addOne(to_add_one,32'b0,1'b1,for_counter,count_overflow);
assign data_ready = to_add_one[4];
register counter(clock,not_ready,for_counter,mult,to_add_one);

// pass to the result
tristate finish(product[31:0],data_ready,data_result);
endmodule