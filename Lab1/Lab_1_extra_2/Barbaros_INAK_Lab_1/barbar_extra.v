module barbar_extra 
(
clk, nReset,Sel,MuxOut,Count
);

	input clk, nReset,Sel;
	output [2:0] Count;
	output MuxOut;

	Counter_3bit Mycounter(clk,nReset,Count);

	MyMux Mux1(Count[2],Count[0],Sel,MuxOut); 

endmodule 