/*----------------------------------------------------------------------
File: Exp7_Top.v - Top-level module to implement bidirectional data
transfer through an 8-bit bus.

Cyclone FPGAs do not support internal tri-state output connections.
Quartus-II Verilog compiler replaces tri-state drivers with logic
operations that arbitrate net signals according to the driver status. 
------------------------------------------------------------------------
Revision History:
14 Mar 15 - Barbaros Ozdemirel
Created the module.
----------------------------------------------------------------------*/
module New_Top_Module(Clock, Sel1, RnW1, temp1, Sel2, RnW2, temp2, Sel3, RnW3, temp3, Sel4, RnW4, temp4, DioExt);
input Clock;  // clock input for all modules
input Sel1, Sel2, Sel3, Sel4;  // module select inputs
input RnW1, RnW2, RnW3, RnW4;  // module read/write control inputs
inout tri [7:0] DioExt; // IO connection to external data pins
output [7:0] temp1,temp2,temp3,temp4;

tri [7:0] Dbus;  // internal data bus connecting all modules and
                 // DioExt[7:0] external data pins
Reg8bit R1(Clock, Sel1, RnW1, temp1, Dbus);  // register modules
Reg8bit R2(Clock, Sel2, RnW2, temp2, Dbus);
Reg8bit R3(Clock, Sel3, RnW3, temp3, Dbus);
Accumulator(Clock, Sel4, RnW4, temp4, Dbus);

// DioExt[7:0] drive Dbus[7:0] while writing to a register module.
assign Dbus[7:0] = ( (RnW1 | RnW2 | RnW3 |RnW4) == 1'b0 ) ?
                   DioExt[7:0] :8'bZ; 
// Dbus[7:0] drive DioExt[7:0] while reading from a register module.
assign DioExt[7:0] = ( (RnW1 | RnW2 | RnW3 | RnW4) == 1'b1 ) ?
                     Dbus[7:0] : 8'bZ;

endmodule
//----------------------------------------------------------------------


//Accumulator Part
//------------------------------------------------------------------------------------
module Accumulator (Clk, Sel, RnW, sum, Dio);
	
	input Clk, Sel, RnW;
	inout tri [7:0] Dio;
	output reg [7:0] sum;
	
	reg control;
	
	always @ (posedge Clk)
		if(Sel == 1'b1)
		begin
			if(RnW==1'b0 && control==1'b0)
				sum<=sum+Dio;
			else if (RnW==1'b0 && control==1'b1)
			begin
				sum<=Dio;
				control<=1'b0;
			end
			else
				if(control==1'b0)
				begin
					sum<=sum;
					control<=1'b1;
				end
				else
				begin
					sum<=8'd0;
					control<=1'b0;
				end
		end
		
		else
			if(control==1'b0)
			begin
				sum<=sum;
				
			end
			else
			begin
				sum<=8'd0;
				control<=1'b0;
			end
			
	assign Dio=(RnW==1'b1 && Sel==1'b1)? sum:((RnW==1'b0 && Sel==1'b1)? Dio: 8'bZ);

endmodule 
//------------------------------------------------------------------------------------
