module Serial_Receiver(SCin, SDin, PDready, PDout);

	input SCin,SDin;
	
	output reg PDready;
	output reg [7:0] PDout;
	
	reg [3:0] counter;

	
	always @ (posedge SCin)
	begin
		if(SDin==1'b0 && PDout==8'd0)
		begin
			counter<=4'd9;
			PDready<=1'b0;
		end
		else if(SDin==1'b1 || counter <4'd9) 
		begin
			case(counter)
				4'd9:
					PDout<=PDout;
				4'd8:
					PDout[7]<=SDin;
				4'd7:
					PDout[6]<=SDin;
				4'd6:
					PDout[5]<=SDin;
				4'd5:
					PDout[4]<=SDin;
				4'd4:
					PDout[3]<=SDin;
				4'd3:
					PDout[2]<=SDin;
				4'd2:
					PDout[1]<=SDin;
				4'd1:
				begin
					PDout[0]<=SDin;
					PDready<=1'b1;
				end
				4'd0:
				begin
					PDready<=1'b0;
					counter<=4'd9;
				end
				default:
					counter<=4'd9;
			endcase
			counter<=counter-1'b1;
		end
		else
		begin
			counter<=counter;
			PDout<=PDout;
		end
				
	end

endmodule 