module Top_Module(Clk,D1,D2,nRst,counter,D3);

	input D1,D2,Clk,nRst;
	
	output reg [2:0] counter;
	
	reg [2:0] state;
	reg [2:0] nextState;
	reg count_up,count_down;
	reg route;
	output reg D3;
	
	parameter S0=3'b000, S1=3'b001, S2=3'b011, S3=3'b010, S4=3'b100;
	
	always @ ( posedge Clk, negedge nRst)
	begin
		if(nRst==1'b0)
		begin
			D3<=1'b0;
			state<=S0;
			count_up<=1'b0;
			count_down<=1'b0;
			counter<=3'd0;
		end
			
		else
		begin
			nextState<={D3,D2,D1};
			case(state)
				S0:
				begin
					if(nextState==3'b001 | nextState==3'b101)
						state<=S1;
					
					else
						state<=S0;
					route<=1'b1;
					count_up<=1'b0;
					count_down<=1'b0;
				end
				
				S1:
				begin
					if(nextState==3'b011 | nextState==3'b111)
					begin
						state<=S2;
						count_down<=1'b0;
					end
					
					else if(nextState==3'b000|nextState==3'b100)
					begin
					
						if(route==1'b0)
						begin
							count_down<=1'b1;
							D3<=0;
						end
						
						else
							count_down<=1'b0;
							
						state<=S0;
					end
					
					else
					begin
						state<=S1;
						count_down<=1'b0;
					end
					
					count_up<=1'b0;
				end
				
				S2:
				begin
					if(nextState==3'b010 | nextState==3'b110)
					begin
						state<=S3;
						D3<=1'b1;
					end
					
					else if(nextState==3'b001|nextState==3'b101)
						state<=S1;
					
					else
						state<=S2;
						
					count_down<=1'b0;
					count_up<=1'b0;
				end
				
				S3:
				begin
					if(nextState==3'b100)
					begin
						state<=S4;
						if(route==1'b1)
							count_up<=1'b1;
						else
							count_up<=1'b0;
					end
					
					else if(nextState==3'b011 | nextState==3'b111)
					begin
						state<=S2;
						count_up<=1'b0;
						
					end
					
					else
					begin
						state<=S3;
						count_up<=1'b0;
					end
					
					count_down<=1'b0;
					
				end
				
				S4:
				begin
					if(nextState==3'b101)
					begin
						D3<=1'b0;
						state<=S1;
						route<=1'b1;
					end
					
					else if(nextState==3'b110)
					begin
						state<=S3;
						route<=1'b0;
					end
					
					else
						state<=state;
						
					count_up<=1'b0;
					count_down<=1'b0;
				end
						
				
				default:
				begin
					state<=S0;
					D3<=1'b0;
					count_up<=1'b0;
					count_down<=1'b0;
				end
			endcase
			
			if(count_up==1'b1)
				counter<=counter+1'b1;
			else if(count_down==1'b1)
				counter<=counter-1'b1;
			else
				counter<=counter;
			
				
		end


	end
	

endmodule 