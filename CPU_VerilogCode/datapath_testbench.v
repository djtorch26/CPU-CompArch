module datapath_testbench ();

reg [36:0] control_word;
reg clock, reset;
reg cs, we, oe;
wire [63:0] data;
reg [63:0] constant;
wire [31:0] address;
wire [1:0] size;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
wire [3:0] alu_status;
wire [63:0] alu_out;
wire [4:0] sa, sb, da;
wire [63:0] testA, testB;

reg Status_load, instruction_load, PCsel, EN_ADDR_PC, EN_PC;
reg [1:0] PS;
wire [31:0] instruction_reg_out;


assign da = control_word[4:0];
assign sa = control_word[9:5];
assign sb = control_word[14:10];

//assign DA = control_word[4:0];
//assign SA = control_word[9:5];
//assign SB = control_word[14:10];
//assign WR = control_word[15];
//assign Bsel = control_word[16];
//assign FS = control_word[21:17];
//assign Co = control_word[22];
//assign En_B = control_word[23];
//assign En_ADDR_ALU = control_word[24];
//assign En_ALU = control_word[25];
//assign mem_read = control_word[26];
//assign mem_write = control_word[27];
//assign mem = control_word[29:28];
//assign Status_load = control_word[30];
//assign PCsel = control_word[31];
//assign EN_ADDR_PC = control_word[32];
//assign EN_PC = control_word[33];
//assign instruction_load = control_word[34];
//assign PS = control_word[36:35];


datapath_memory dut(control_word, instruction_reg_out, constant, reset, clock, data, address, size, r0, r1, r2, r3, r4, r5, r6, r7, alu_status, alu_out);

 initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		control_word[4:0]<= 5'd0; 
		control_word[9:5]<= 5'd0; 
		control_word[14:10] <= 5'd0;
		control_word[15] <= 1'b1;
		control_word[16] <= 1'b1;
		control_word[21:17] <= 5'b00100; //OR
		control_word[22] <= 1'b0;
		control_word[29:23] <= 7'b0;
		control_word[26] <= 1'b0;
		control_word[27] <= 1'b0;
		control_word[29:28] <= 2'b0;
		control_word[30] <= 1'b0;
		control_word[31] <= 1'b0;
		control_word[32] <= 1'b0;
		control_word[33] <= 1'b0;
		control_word[34] <= 1'b0;
		control_word[36:35] <= 2'b0;
		constant <= 64'd24;
		#5 reset <= 1'b0; // delay 5 ticks then turn reset off
		#70 $stop;
	end
	
	always
		#5 clock <= ~clock;
		
always begin
	#2
	control_word[21:17] <= 5'b00100;
	control_word[4:0] <= 5'b0;
	control_word[9:5] <= 5'd31;
	control_word[14:10] <=5'd0;
	control_word[16] <= 1'b1;
	control_word[25] <= 1'b1;
	#10
	control_word[4:0] <=5'b1;
	control_word[16] <=1'b0;
	control_word[22] <= 1'b1;
	control_word[21:17] <= 5'b01001;
	#10
	constant <= 64'h1024;
	control_word[15] <= 1'b0;
	control_word[22] <= 1'b0;
	control_word[25] <= 1'b0;
	control_word[16] <= 1'b1;
	control_word[14:10] <= 5'b1;
	control_word[21:17] <= 5'b01000;
	control_word[24] <= 1'b1;
	control_word[23] <= 1'b1;
	
	control_word[27] <= 1'b1;
	we <= 1'b1;
	#10
	control_word[4:0] <=5'b1;
	control_word[9:5] <= 5'd0;
	control_word[14:10] <= 5'd1;
	control_word[15] <= 1'b1;
	control_word[16] <= 1'b0;
	control_word[21:17] <= 5'b00000;
	control_word[22] <= 1'b0;
	control_word[23] <= 1'b0;
	control_word[24] <= 1'b0;
	control_word[25] <= 1'b1;
	control_word[26] <= 1'b0;
	control_word[27] <= 1'b0;
	#10
	control_word[25] <= 1'b0;
	control_word[26] <= 1'b1;
	control_word[15] <= 1'b1;
	control_word[25] <= 1'b0;
	control_word[4:0] <= 5'd2;
	control_word[16] <= 1'b1;
	control_word[9:5] <= 5'd31;
	control_word[21:17] <= 5'b01000;
	control_word[24] <= 1'b1;
	#10
	#5;
end
/*
initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		datahelp <= 64'b0;
		control_word[4:0]<= 5'd1; // write to register 0 first since D will be incremented before first clock
		control_word[9:5]<= 5'd1; // read from register 31 first on A bus
		control_word[14:10] <= 5'd0; // read from register 30 first on B bus
		control_word[15] <= 1'b1;
		control_word[16] <= 1'b1;
		control_word[21:17] <= 5'b01000;
		control_word[22] <= 1'b0;
		control_word[29:23] <= 7'b0;
		#5 reset <= 1'b0; // delay 5 ticks then turn reset off
		#950 $stop;
	end
	
	assign data = datahelp;
	
	always
		#5 clock <= ~clock;
		
	always begin
		#10
		control_word[15] <= 1'b1;
		datahelp <= datahelp + 64'b10;
		control_word[4:0] <= control_word[4:0] + 1'b1;
		da <= control_word[4:0];
		control_word[9:5] <=control_word[9:5] + 1'b1;
		sa <= control_word[9:5];
		control_word[14:10] <=control_word[14:10] + 1'b1;
		sb <= control_word[14:10];
		#10
		control_word[15] <= 1'b0;
		control_word[16] <= 1'b0;
		#10
		control_word[16] <= 1'b1;
		control_word[21:17] <= 5'b01001;	//A-B
		control_word[22] <= 1'b1;
		#5
		control_word[25] <= 1'b0;
		control_word[22] <= 1'b0;
		#5;
	end 
	*/
	endmodule
	