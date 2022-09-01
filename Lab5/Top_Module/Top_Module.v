module Top_Module (ClkIn, PDin1, PDin2, Send1, Send2, PDready, ParErr,PDout,Sclk1,Sclk2,Sdata1,Sdata2,Sdata_test,send_en);

	input ClkIn,Send1,Send2,Sdata_test;
	input [7:0] PDin1, PDin2;
	
	
	output ParErr,PDready,Sclk1,Sclk2,Sdata1,Sdata2,send_en;
	output [7:0] PDout; 

	Serial_Transmitter_New ST1 (.Clk(ClkIn), .Send(Send1), .PDin(PDin1), .SCout(Sclk1), .SDout(Sdata1));
	
	Serial_Transmitter_Modified2 ST2 (.Clk(ClkIn), .Send(Send2), .PDin(PDin2), .SCout(Sclk2), .SDout(Sdata2),.send_en(send_en));

	Serial_Receiver_Modified SR1(.SCin(Sclk2), .SDin(Sdata_test), .PDready(PDready), .PDout(PDout),.ParErr(ParErr));


endmodule 