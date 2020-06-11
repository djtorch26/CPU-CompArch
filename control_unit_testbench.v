module control_unit_testbench();


wire [36:0]control_word;
wire [63:0]constant;
reg[4:0]status;
reg[31:0]I;
reg clock, reset;


control_unit instcontrol_unit (status, I, control_word, constant, clock, reset);


initial begin

	clock <= 1'b1;
	status <= 5'b00000;
	I <= 32'b0;
	reset <= 1'b1;
	#5
	reset <= 1'b0;
	#100 $stop;
end


always
#5 clock <= ~clock;
	
always begin
	#10
	I <= 32'b10010001000000000000100000100001; //r1 <= r1+k	ADDI
	#10
	I <= 32'b11001011000000010000000000000000; //r0 <= r0-r1	SUB
	#10
	I <= 32'b10101011000000100000000000100010; //r2 <= r2+r1 with flags	ADDS
	#10
	I <= 32'b11111000000000000001000000100011; //mem[r1+1] <= r3 	STUR
	#10;
	I <= 32'b11010010100000000000000000100001; //r1 <= 1	MOVZ
	#10
	I <= 32'b11110010100000000000000000100001; //r1 <= 1 MOVK
	#20;

end

endmodule
