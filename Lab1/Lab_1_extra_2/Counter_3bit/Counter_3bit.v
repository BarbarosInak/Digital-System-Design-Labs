module Counter_3bit(clk,nReset,Count);

	input clk,nReset;
	reg [2:0] counter;
	output [2:0] Count;

	always @(posedge clk or posedge nReset)
	begin
		if (nReset == 1'b1)
			counter <= 3'b0;
		else
			counter <= counter + 3'b1;
	end	

	assign Count = counter;

endmodule 