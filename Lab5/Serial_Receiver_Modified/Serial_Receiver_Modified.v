module Serial_Receiver_Modified(SCin, SDin, PDready, PDout,ParErr);

	input SCin,SDin;
	
	output reg PDready;
	output reg [7:0] PDout;
	output reg ParErr;
	
	reg parr;
	reg [3:0] counter;

	
	always @ (posedge SCin)
	begin
		if(SDin==1'b0 && PDout==8'd0)
		begin
			counter<=4'd10;
			PDready<=1'b0;
		end
		else if(SDin==1'b1 || counter <4'd10) 
		begin
			if(SDin==1'b1)//parity bit calculation
				parr<=~parr;
			else
				parr<=parr;
			case(counter) //obtaining parallel data
				4'd10:
				begin
					PDout<=PDout;
					ParErr<=1'b0;
				end
				4'd9:
					PDout[7]<=SDin;
				4'd8:
					PDout[6]<=SDin;
				4'd7:
					PDout[5]<=SDin;
				4'd6:
					PDout[4]<=SDin;
				4'd5:
					PDout[3]<=SDin;
				4'd4:
					PDout[2]<=SDin;
				4'd3:
					PDout[1]<=SDin;
				4'd2:
					PDout[0]<=SDin;
				4'd1:
				begin//checking is parity bit ok or not
					if(SDin==parr)
						ParErr<=1'b0;
					else
						ParErr<=1'b1;
					PDready<=1'b1;
				end
				4'd0:
				begin
					PDready<=1'b0;
					counter<=4'd10;
				end
				default:
					counter<=4'd10;
			endcase
			// updating counter in every clock
			counter<=counter-1'b1;
		end
		else
		begin
			counter<=counter;
			PDout<=PDout;
		end
				
	end

endmodule 