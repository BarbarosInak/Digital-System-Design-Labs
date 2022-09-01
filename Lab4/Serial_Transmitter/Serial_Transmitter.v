module Serial_Transmitter(Clk, Send, PDin,SCout,SDout);
	
	input Clk, Send;
	input [7:0] PDin;
	
	output SCout,SDout;
	
	reg [7:0] temp;
	reg out;
	
	always @ (posedge Clk)
	begin
		if(Send==1'b1)
		begin
			temp<=PDin;
			out<=1'b1;
		end
		else
		begin
			out<=temp[7];
			temp[7:1]<=temp[6:0];
			temp[0]<=1'b0;
		end
	
	end
	
	assign SDout=out;
	assign SCout=Clk;
	
endmodule
