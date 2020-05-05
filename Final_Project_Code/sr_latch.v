module sr_latch(S,R,Q,not_Q);
	input S, R;
	output Q, not_Q;
	
	nor nor0(Q, R, not_Q);
	nor nor1(not_Q, S, Q);

endmodule
