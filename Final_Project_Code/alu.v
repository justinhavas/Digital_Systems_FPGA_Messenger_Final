module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow; // need to add stuff here

   // YOUR CODE HERE //
	wire [31:0] ALUopcode,subtract_by,add_result,sub_result,and_result,or_result,sll_result,sra_result;
   wire overflow_add, overflow_sub,not_equal,less_than;
	
    
	decoder decode_ALUopcode(ctrl_ALUopcode,ALUopcode);
	
	//add
	csa_adder adding(data_operandA,data_operandB,1'b0,add_result,overflow_add);
	
	//sub
	not_bitwise calc_sub(data_operandB,subtract_by);
	csa_adder subtracting(data_operandA,subtract_by,1'b1,sub_result,overflow_sub);
	
	//and
	and_bitwise anding(data_operandA,data_operandB,and_result);
	
	//or
	or_bitwise oring(data_operandA,data_operandB,or_result);
	
	//sll
	barrelShiftLeft shiftingL(data_operandA,ctrl_shiftamt,sll_result);
	
	//sra
	barrelShiftRight shiftingR(data_operandA,ctrl_shiftamt,sra_result);
	
	//notequal
	or ne(not_equal,sub_result[0],sub_result[1],sub_result[2],sub_result[3],sub_result[4],sub_result[5],sub_result[6],sub_result[7],sub_result[8],sub_result[9],sub_result[10],sub_result[11],sub_result[12],sub_result[13],sub_result[14],sub_result[15],sub_result[16],sub_result[17],sub_result[18],sub_result[19],sub_result[20],sub_result[21],sub_result[22],sub_result[23],sub_result[24],sub_result[25],sub_result[26],sub_result[27],sub_result[28],sub_result[29],sub_result[30],sub_result[31]);
	
	//lessthan
	or lt(less_than,sub_result[31],1'b0,overflow_sub);
	
	tristate buffAdd(add_result,ALUopcode[0],data_result);
	tristate buffSub(sub_result,ALUopcode[1],data_result);
   tristate_1bit buffAddO(overflow_add,ALUopcode[0],overflow);
	tristate_1bit buffSubO(overflow_sub,ALUopcode[1],overflow);
	tristate_1bit buffSub1(not_equal,ALUopcode[1],isNotEqual);
	tristate_1bit buffSub2(less_than,ALUopcode[1],isLessThan);
	tristate buffAnd(and_result,ALUopcode[2],data_result);
	tristate buffOr(or_result,ALUopcode[3],data_result);
	tristate buffSll(sll_result,ALUopcode[4],data_result);
	tristate buffSra(sra_result,ALUopcode[5],data_result);
endmodule