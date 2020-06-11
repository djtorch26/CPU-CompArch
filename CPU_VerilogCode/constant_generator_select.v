module constant_generator_select(CGS_Sel, I, K);

	input [2:0] CGS_Sel;
	input [31:0] I;
	output [63:0] K;
	
	Mux8to1Nbit mux1 (K, CGS_Sel, {52'b0, I[21:10]}, {52'b0, I[21:10]}, {48'b0, I[20:5]}, 64'hFFFFFFFFFFFF0000, {{38{I[25]}},I[25:0]}, {{45{I[23]}},I[23:5]}, {{55{I[20]}},I[20:12]}, 64'b0);
	defparam mux1.N = 64;
	
endmodule
