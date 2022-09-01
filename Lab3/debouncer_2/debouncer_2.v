module debouncer_2 (SwOut, Clk, SwOutDB2);

	input SwOut,Clk;
	output SwOutDB2;

	reg [3:0] shifter;
	
	
	always @ (posedge Clk)
	begin
		shifter[0]<=SwOut;
		shifter[3:1]<=shifter[2:0];
	end
	
	assign SwOutDB2=(shifter==4'b0000 && SwOut==1'b1)? 1'b1:
					((shifter==4'b1111 && SwOut==1'b0)? 1'b0:
					((shifter==4'b0000 && SwOut==1'b0)? 1'b0 : SwOutDB2));
		
endmodule 