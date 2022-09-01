module DFF3st (Clk, RnW, Dio);

	input Clk, RnW;
	inout reg [7:0] Dio;
	
	reg [7:0] FFstore;
	
	always @ (posedge Clk)
		if(RnW == 1'b0)
		begin
			FFstore<=Dio;
			Dio<=8'dZ;
		end
		else
		begin
			FFstore<=FFstore;
			Dio<=FFstore;
		end
	
endmodule
	
	
	
	
	
	
	
	