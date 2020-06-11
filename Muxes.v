module Mux2to1Nbit(F, S, I0, I1);
	parameter N = 64;
	input [N-1:0]I0, I1;
	input S;
	output [N-1:0]F;
	
	assign F = S ? I0 : I1;
endmodule

module Mux4to1Nbit (F, S, I0, I1, I2, I3);
	parameter N = 64;
	input [N-1:0]I0, I1, I2, I3;
	input [2:0]S;
	output [N-1:0]F;
	
	assign F = S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0);
endmodule

module Mux8to1Nbit(F, S, I0, I1, I2, I3, I4, I5, I6, I7);
	parameter N = 64;
	input [N-1:0]I0, I1, I2, I3, I4, I5, I6, I7;
	input [2:0]S;
	output [N-1:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule

module Mux32to1Nbit(F, S, I00, I01, I02, I03, I04, I05, I06, I07, I08, I09,
								  I10, I11, I12, I13, I14, I15, I16, I17, I18, I19,
								  I20, I21, I22, I23, I24, I25, I26, I27, I28, I29,
								  I30, I31);

	parameter N = 8;
	output reg [N-1:0]F; // output
	input [4:0]S; // select
	input [N-1:0]I00, I01, I02, I03, I04, I05, I06, I07, I08, I09;
	input [N-1:0]I10, I11, I12, I13, I14, I15, I16, I17, I18, I19;
	input [N-1:0]I20, I21, I22, I23, I24, I25, I26, I27, I28, I29;
	input [N-1:0]I30, I31;
	
	always @(*) begin
		case(S)
			5'h00: F <= I00;
			5'h01: F <= I01;
			5'h02: F <= I02;
			5'h03: F <= I03;
			5'h04: F <= I04;
			5'h05: F <= I05;
			5'h06: F <= I06;
			5'h07: F <= I07;
			5'h08: F <= I08;
			5'h09: F <= I09;
			5'h0A: F <= I10;
			5'h0B: F <= I11;
			5'h0C: F <= I12;
			5'h0D: F <= I13;
			5'h0E: F <= I14;
			5'h0F: F <= I15;
			5'h10: F <= I16;
			5'h11: F <= I17;
			5'h12: F <= I18;
			5'h13: F <= I19;
			5'h14: F <= I20;
			5'h15: F <= I21;
			5'h16: F <= I22;
			5'h17: F <= I23;
			5'h18: F <= I24;
			5'h19: F <= I25;
			5'h1A: F <= I26;
			5'h1B: F <= I27;
			5'h1C: F <= I28;
			5'h1D: F <= I29;
			5'h1E: F <= I30;
			5'h1F: F <= I31;
		endcase
	end
endmodule

module Mux64to1Nbit(F, S, I00, I01, I02, I03, I04, I05, I06, I07, I08, I09,
								  I10, I11, I12, I13, I14, I15, I16, I17, I18, I19,
								  I20, I21, I22, I23, I24, I25, I26, I27, I28, I29,
								  I30, I31, I32, I33, I34, I35, I36, I37, I38, I39, I40,
								  I41, I42, I43, I44, I45, I46, I47, I48, I49, I50, I51,
								  I52, I53, I54, I55, I56, I57, I58, I59, I60, I61, I62, I63);

	parameter N = 8;
	output reg [N-1:0]F; // output
	input [5:0]S; // select
	input [N-1:0]I00, I01, I02, I03, I04, I05, I06, I07, I08, I09;
	input [N-1:0]I10, I11, I12, I13, I14, I15, I16, I17, I18, I19;
	input [N-1:0]I20, I21, I22, I23, I24, I25, I26, I27, I28, I29;
	input [N-1:0]I30, I31, I32, I33, I34, I35, I36, I37, I38, I39, I40, I41, I42, I43, I44, I45, I46, I47, I48, I49, I50, I51, I52, I53, I54, I55, I56, I57, I58, I59, I60, I61, I62, I63;
	
	always @(*) begin
		case(S)
			5'h00: F <= I00;
			5'h01: F <= I01;
			5'h02: F <= I02;
			5'h03: F <= I03;
			5'h04: F <= I04;
			5'h05: F <= I05;
			5'h06: F <= I06;
			5'h07: F <= I07;
			5'h08: F <= I08;
			5'h09: F <= I09;
			5'h0A: F <= I10;
			5'h0B: F <= I11;
			5'h0C: F <= I12;
			5'h0D: F <= I13;
			5'h0E: F <= I14;
			5'h0F: F <= I15;
			5'h10: F <= I16;
			5'h11: F <= I17;
			5'h12: F <= I18;
			5'h13: F <= I19;
			5'h14: F <= I20;
			5'h15: F <= I21;
			5'h16: F <= I22;
			5'h17: F <= I23;
			5'h18: F <= I24;
			5'h19: F <= I25;
			5'h1A: F <= I26;
			5'h1B: F <= I27;
			5'h1C: F <= I28;
			5'h1D: F <= I29;
			5'h1E: F <= I30;
			5'h1F: F <= I31;
			5'h20: F <= I32;
			5'h21: F <= I33;
			5'h22: F <= I34;
			5'h23: F <= I35;
			5'h24: F <= I36;
			5'h25: F <= I37;
			5'h26: F <= I38;
			5'h27: F <= I39;
			5'h28: F <= I40;
			5'h29: F <= I41;
			5'h2A: F <= I42;
			5'h2B: F <= I43;
			5'h2C: F <= I44;
			5'h2D: F <= I45;
			5'h2E: F <= I46;
			5'h2F: F <= I47;
			5'h30: F <= I48;
			5'h31: F <= I49;
			5'h32: F <= I50;
			5'h33: F <= I51;
			5'h34: F <= I52;
			5'h35: F <= I53;
			5'h36: F <= I54;
			5'h37: F <= I55;
			5'h38: F <= I56;
			5'h39: F <= I57;
			5'h3A: F <= I58;
			5'h3B: F <= I59;
			5'h3C: F <= I60;
			5'h3D: F <= I61;
			5'h3E: F <= I62;
			5'h3F: F <= I63;
		endcase
	end
endmodule

// this is here only to make into a block
module mux2to1_64bit(F, S, I0, I1);
	input [63:0] I0, I1;
	input S;
	output [63:0] F;
	
	assign F = S ? I1 : I0;
endmodule
