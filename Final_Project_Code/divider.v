module divider(data_operandA, data_operandB, clock, div, data_result, data_overflow, data_ready);
input [31:0] data_operandA,data_operandB;
input clock,div;
output [31:0] data_result;
output data_overflow, data_ready;

wire [63:0] quotient,start_quotient,in_quotient,shift_result,after_shift,quot_shift;
wire [31:0] not_A,not_B,dividend_check,divisor_check,twos_dividend,twos_divisor,alu_result,rando_alu2,to_add_one,for_counter,not_quot,twos_quot;
wire not_ready,dividend_sign,divisor_sign,ctrl_sign0,ctrl_sign1,not_ctrl_sign0,not_ctrl_sign1,rando_overflow0,rando_overflow1;
wire rando_ine,rando_lt,rando_ovf,lessThan_result,not_div,not_lt,ctrl_newShift,ctrl_nochange,notEqual_result,rando_lt2,rando_ovf2;
wire equal_result,zero,count_overflow,retrieve_sign,no_problem,original,twos_it,rando_overflow4;

not ready(not_ready,data_ready);

// make division with positives
assign dividend_sign = data_operandA[31];
assign divisor_sign = data_operandB[31];

or orSign1(ctrl_sign0,dividend_sign,1'b0);
not notSign1(not_ctrl_sign0,ctrl_sign0);
tristate tris(data_operandA,not_ctrl_sign0,dividend_check);

not_bitwise notb(data_operandA,not_A);
csa_adder finishTwos(not_A,32'b0,1'b1,twos_dividend,rando_overflow0);
tristate triss(twos_dividend,ctrl_sign0,dividend_check);

or orSign2(ctrl_sign1,divisor_sign,1'b0);
not notSign2(not_ctrl_sign1,ctrl_sign1);
tristate tris2(data_operandB,not_ctrl_sign1,divisor_check);

not_bitwise notb2(data_operandB,not_B);
// change what goes into adder a little
csa_adder finishTwos2(not_B,32'b0,1'b1,twos_divisor,rando_overflow1);
tristate triss2(twos_divisor,ctrl_sign1,divisor_check);

// create the starting quotient
assign start_quotient[63:33] = 31'b0;
assign start_quotient[32:1] = dividend_check;
assign start_quotient[0] = 1'b0;

tristate_64bit startQuot(start_quotient,div,in_quotient);

//get quotient register
product_register quot(clock,not_ready,in_quotient,1'b0,quotient);

// create the main ALU
alu theAlu(quotient[63:32],divisor_check,5'b00001,5'b0,alu_result,rando_ine,rando_lt,rando_ovf);

// Do less than computation
assign lessThan_result = alu_result[31];

not noDiv(not_div,div);
not noLt(not_lt,lessThan_result);
and andCtrl1(ctrl_newShift,not_div,not_lt);
and andCtrl2(ctrl_nochange,not_div,lessThan_result);


// put new quotient back
assign shift_result[63:32] = alu_result;
assign shift_result[31:0] = quotient[31:0];
// could be a debug
assign after_shift = (shift_result<<1) | 64'd1;
//assign after_shift[0] = 1'b1; driver problem
tristate_64bit inQuot(after_shift,ctrl_newShift,in_quotient);

assign quot_shift = quotient<<1;
tristate_64bit inQuotShift(quot_shift,ctrl_nochange,in_quotient);

// take care of exception
alu isZero(32'b0,data_operandB,5'b00001,5'b0,rando_alu2,notEqual_result,rando_lt2,rando_ovf2);
not getZero(equal_result,notEqual_result);
tristate_1bit zero1(equal_result,not_ready,zero);
dflipflop zeroDffe(data_overflow,zero,clock,1'b1,div);

// take care of counter
csa_adder addOne(to_add_one,32'b0,1'b1,for_counter,count_overflow);
assign data_ready = to_add_one[5];
register counter(clock,not_ready,for_counter,div,to_add_one);

// take care of result if needed to be inverted
xor diffSign(retrieve_sign,dividend_sign,divisor_sign);
not noProb(no_problem,retrieve_sign);
and and3(original,no_problem,data_ready);
tristate tris5(quotient[31:0],original,data_result);

and and4(twos_it,retrieve_sign,data_ready);
not_bitwise notb3(quotient[31:0],not_quot);
csa_adder finishTwos3(not_quot,32'b0,1'b1,twos_quot,rando_overflow4);
tristate triss3(twos_quot,twos_it,data_result);
endmodule