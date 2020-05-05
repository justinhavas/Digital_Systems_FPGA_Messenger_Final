module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;
	 wire [31:0] mult_result,div_result;
	 wire multiplication,division,andOfClkMult,andOfClkDiv,resetMult,resetDiv,enable_mult,enable_div,mult_exception,mult_ready,div_ready;

    // Your code here
	 
	 // set up multiplication and divison d flip-flops
	 and andClkMult(andOfClkMult,clock,ctrl_MULT);
	 dffe_ref multDffe(multiplication,ctrl_MULT,andOfClkMult,1'b1,resetMult);
	 and andClkDiv(andOfClkDiv,clock,ctrl_DIV);
	 dffe_ref divDffe(division,ctrl_DIV,andOfClkDiv,1'b1,resetDiv);
	 
	 //setup resets
	 and and0(resetMult,ctrl_DIV,multiplication);
	 and and1(resetDiv,ctrl_MULT,division);

	 
	 // implement multiplier and divider
	 multiplier multing(data_operandA,data_operandB,clock,ctrl_MULT,mult_result,mult_exception,mult_ready);
	 divider dividing(data_operandA,data_operandB,clock,ctrl_DIV,div_result,div_exception,div_ready);
	 
	 //output the result
	 and readyAndMult(enable_mult,mult_ready,multiplication);
	 tristate result0(mult_result,enable_mult,data_result);
	 tristate_1bit tris0(mult_ready,enable_mult,data_resultRDY);
	 tristate_1bit tris1(mult_exception,enable_mult,data_exception);
	 
	 and readyAndDiv(enable_div,div_ready,division);
	 tristate result1(div_result,enable_div,data_result);
	 tristate_1bit tris2(div_ready,enable_div,data_resultRDY);
	 tristate_1bit tris3(div_exception,enable_div,data_exception);
endmodule
