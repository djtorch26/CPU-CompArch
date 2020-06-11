module rom_case_testbench ();
	reg [7:0] address;
	wire [63:0] out;
	
	rom_case dut(.address(address), .out(out));
	
	initial begin
	address <= 8'h00;
	#5
	address <= 8'h01;
	#5
	address <= 8'h02;
	#5
	address <= 8'h03;
	#5
	address <= 8'h04;
	#5
	address <= 8'h05;
	#5
	address <= 8'h06;
	#5
	address <= 8'h07;
	#5
	address <= 8'h08;
	#5
	address <= 8'h09;
	#5
	address <= 8'h0A;
	#5
	address <= 8'h0B;
	#5
	address <= 8'h0C;
	#5
	address <= 8'h0D;
	#5
	address <= 8'h0E;
	#5
	address <= 8'h0F;
	end
	
endmodule
