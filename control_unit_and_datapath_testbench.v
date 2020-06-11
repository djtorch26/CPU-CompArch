module control_unit_and_datapath_testbench();

	wire [63:0]data;
	wire[31:0]address;
	reg reset;
	reg clock;
	wire r0,r1,r2,r3,r4,r5,r6,r7;
	wire memread, memwrite;
	wire[1:0]size;
	
	control_unit_and_datapath instDT (data, address, clock, reset, memread, memwrite, size, r0,r1,r2,r3,r4,r5,r6,r7);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		#5
		reset <= 1'b0;
		#2000 $stop;
	end
	
	always  
		#5 clock = ~clock;

endmodule
