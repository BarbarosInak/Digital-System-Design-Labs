module Top_Module(SwOut,Clk,SwOutDB1,SwOutDB2);

	input SwOut,Clk;
	output SwOutDB1,SwOutDB2;
	
	debouncer_1 db1 (SwOut,Clk,SwOutDB1);
	
	debouncer_2 db2 (SwOut,Clk,SwOutDB2);

endmodule 