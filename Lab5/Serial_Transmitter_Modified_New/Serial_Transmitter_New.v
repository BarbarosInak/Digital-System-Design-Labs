module Serial_Transmitter_New ( Clk, Send, PDin, SCout, SDout);

	input Clk, Send;
	input [7:0] PDin;
	
	reg par;
	
	reg [3:0] counter;
	
	output SCout;
	output SDout;
	
	
	reg out,start,control_send;
	reg [8:0] temp;
	
	always @ (posedge Clk)
	begin // creating delayed send for obtaining short version
		control_send<=Send;
	end
	
	always @ (posedge Clk)
	begin
		// short version of Send control
		if(Send==1'b1 && control_send==1'b0)
		begin
			out<=|PDin;
			temp<={PDin,^({1'b1,PDin})};
		end
		else // shift and out
		begin
			out<= temp[8];
			temp<={temp[7:0], 1'b0};
		end
		
	end
	
	assign SDout=out;
	assign SCout=Clk;

endmodule 