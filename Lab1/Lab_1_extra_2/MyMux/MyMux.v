module MyMux(in0, in1,Sel, MuxOut);

	input [1:0] in0, in1;
	input Sel;
	output [1:0] MuxOut;

	assign MuxOut[1:0] = (Sel == 1'b0) ? (in0[1:0] & in1[1:0]) : (in0[1:0] ^ in1[1:0]);

endmodule 