module Top_Module(ClkIn, Send, PDin, Sclk, Sdata, PDready, PDout);

	input ClkIn,Send;
	input [7:0] PDin;
	
	output Sclk, Sdata,PDready;
	output [7:0] PDout;
	
	Serial_Transmitter st1 (ClkIn,Send,PDin,Sclk,Sdata);
	
	Serial_Receiver sr1 (Sclk,Sdata,PDready,PDout);

endmodule
