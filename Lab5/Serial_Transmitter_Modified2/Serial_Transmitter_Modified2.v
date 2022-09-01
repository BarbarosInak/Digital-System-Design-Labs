module Serial_Transmitter_Modified2 ( Clk, Send, PDin, SCout, SDout, send_en);

	input Clk, Send;
	input [7:0] PDin;
	
	output SCout;
	output SDout;
	
	output reg send_en;
	
	reg [8:0] temp;
	reg parr,out,delayed_send;
	reg [3:0] counter;
	
	
	
	
	always @ (posedge Send)	
	begin
		if(Send==1'b1)
			send_en<=1'b1;
		else 
			send_en<=send_en;
	end
		
	//assign send_en=(delayed_send) & ~(|counter);
		

		
	always @ (posedge Clk)
	begin
		
		if (send_en && temp==9'd0 )
		begin
			temp<={|PDin,PDin};
			
			out<=PDin[7];
			parr<=parr^PDin[7];
			counter<=4'd1;
			
		end
		
		else if(counter<4'd9)
		begin
			out<=temp[7];
			temp<={temp[7:0],1'b0};
			parr<=parr^temp[7];
			counter<=counter+1'd1;
			
		end
		
		else
		begin
			out<=parr;
			temp<=8'd0;
			counter<=4'd0;
		end
			


	end
	
	assign SDout=out;
	assign SCout=Clk;
	
endmodule 
	
	
	