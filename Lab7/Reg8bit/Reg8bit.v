module Reg8bit (Clk, Sel, RnW,temp, Dio);

	input Clk, RnW, Sel;
	inout tri [7:0] Dio;
	output reg [7:0] temp;
	
	//output reg [7:0] temp;
	reg [7:0] FFstore;
	
	always @ (posedge Clk)
		if(Sel == 1'b0)
		begin
			FFstore<=FFstore;
			temp<=temp;
		end
		else
		begin
			if(RnW==1'b1)
			begin
				FFstore<=FFstore;
				temp<=temp;
			end
			else
			begin
				FFstore<=Dio;
				temp<=Dio;
			end
		end
			
	
	assign Dio=(RnW==1'b1 && Sel==1'b1)? FFstore:((RnW==1'b0 && Sel==1'b1)? Dio: 8'bZ);
	
endmodule 