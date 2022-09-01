module debouncer_1 (SwOut, Clk, SwOutDB1);

	input SwOut,Clk;
	output reg SwOutDB1;
	
	reg [3:0] shifter;
	
	always @ (posedge Clk)
	begin
		
		shifter[0]<=SwOut;
		shifter[3:1]<=shifter[2:0];
		
		if(shifter==4'b1111 & SwOut==1'b1)
			SwOutDB1<=1'b1;
		else if(shifter==4'b0000 & SwOut==1'b0)
			SwOutDB1<=1'b0;
		else
			SwOutDB1<=SwOutDB1;
		
	end
	
endmodule 