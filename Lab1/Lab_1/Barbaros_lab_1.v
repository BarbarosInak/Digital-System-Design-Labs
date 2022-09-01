module Barbaros_lab_1 
(
clk, nReset, Count,in0,in1,Sel,MuxOut,MuxOut_reg
);

	input clk, nReset,in0,in1,Sel;
	output [2:0] Count,MuxOut;
	output reg MuxOut_reg; 
	reg Operand_1,Operand_2;


	Counter_3bit Mycounter(clk,nReset,Count);

	always @(posedge clk)
	begin
		Operand_1 <= Count[0];
		Operand_2 <= Count[2];
	end


	MyMux Mux1(Operand_1,Operand_2,Sel,MuxOut); 

	always @(posedge clk)
	begin
		MuxOut_reg <= MuxOut;
	end
	
endmodule 

// Counter Module
module Counter_3bit(clk,nReset,Count);

	input clk,nReset;
	reg [2:0] counter;
	output [2:0] Count;

	always @(posedge clk or negedge nReset)
	begin
		if (nReset == 1'b0)
			counter <= 3'b0;
		else
			counter <= counter + 3'b1;
	end	

	assign Count = counter;

endmodule 

// Multiplexer Module
module MyMux(in0, in1,Sel, MuxOut);

	input in0, in1, Sel;
	output MuxOut;

	assign MuxOut = (Sel == 1'b0) ? in0 & in1 : in0^in1;

endmodule 