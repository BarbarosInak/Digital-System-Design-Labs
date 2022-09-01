module Barbaros_INAK_Lab2(nReset, clk, enable, co1,co10,co100,nextEn,nextEn10,nextEn100);

	input nReset,clk,enable;
	output [3:0] co1,co10,co100;
	output nextEn,nextEn10,nextEn100;
	
	BCD_counter counter_1(nReset,clk,enable,nextEn,co1);
	
	BCD_counter counter_2(nReset,clk,nextEn,nextEn10,co10);
	
	BCD_counter counter_3(nReset,clk,nextEn10,nextEn100,co100);
	
endmodule

module BCD_counter(nReset, clk, enable, nextEn, Cout);

	input nReset,clk,enable;
	output nextEn;
	output [3:0] Cout;
	reg [3:0] counter;
	
	always @ (posedge clk, negedge nReset)
	begin
		if (nReset==1'b0)
			counter<=4'd0;
		else
		begin
			if(enable == 1'b1)
			begin
				if(counter == 4'd9)
					counter <= 4'd0;			
				else
					counter <= counter+4'd1;
			end
			else
				counter <= counter;
		end
					
	end
	
	assign nextEn=(counter== 4'd9 && enable==1'b1)? 1'b1 : 1'b0;
	
	assign Cout=counter;
	
endmodule
		
			