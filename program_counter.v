module program_counter (in, PS, reset, clock, out);
	input [31:0] in;
	input [1:0] PS;
	input reset, clock;
	output [63:0]out;
	
	wire [31:0] DFF_in, S_add, S_mult, dff_out, mult;
	wire C1, C2;

	assign mult = {in[29:0], 2'b00};
	
	FullAdder inst_add (S_add, C1, dff_out, 32'd4, 1'b0);
	FullAdder inst_mult (S_mult, C2, dff_out, mult, 1'b0);

	Mux4to1Nbit inst_mux (.F(DFF_in), .S(PS), .I0(dff_out), .I1(S_add), .I2(in), .I3(S_mult));
	defparam inst_mux.N = 32;
	
	PC_DFF inst_dff (.Q(dff_out), .D(DFF_in), .clock(clock), .reset(reset));
	
	assign out = dff_out;
	
endmodule


module PC_DFF(Q, D, clock, reset);
	output reg [31:0]Q;
	input [31:0]D;
	input clock, reset;
	parameter PC_RESET_VALUE=32'h00000000;
	always @(posedge clock or posedge reset) begin
		if(reset) Q <= PC_RESET_VALUE;
		else Q <= D;
	end
endmodule



