module control_unit (status, I, control_word, constant, clock, reset);
	input [4:0] status;
	input [31:0] I;
	output [36:0] control_word;
	output [63:0] constant;
	input clock, reset;

	wire [1:0]next_state;
	wire [1:0] control_selects;
		
	wire [42:0] IF, EX0, EX1, EX2, DataImm, Branches, Mem, DataReg, ADDI_SUBBI, ANDI_ORI_EORI_ANDIS, MOVZ_MOVK, B_BL, CBZ_CBNZ, B_COND, BR, LDUR_STUR, AND_ANDS_ORR_EOR, ADD_ADDS_SUB_SUBS, MOVK2;
	wire [63:0] K;
	wire [41:0] Fcontrol_word;	
	
	assign constant = K;
	
	assign control_word[36:0] = Fcontrol_word[36:0];
	
	wire and_SL;
	wire [4:0] and_FS;
	assign and_SL = I[30]&I[29];
	
	Mux8to1Nbit inst000 (and_FS,{I[21], I[30:29]}, 5'b00000, 5'b00100, 5'b01100, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 5'b00000);
	defparam inst000.N = 5;
	
	wire [4:0] add_FS;
	
	Mux2to1Nbit inst001 (add_FS, I[30], 5'b01000, 5'b01001);
	defparam inst001.N = 5;
	
	wire [4:0] movz_SA;
	
	assign movz_SA[0] = I[0] | ~I[29];
	assign movz_SA[1] = I[1] | ~I[29];
	assign movz_SA[2] = I[2] | ~I[29];
	assign movz_SA[3] = I[3] | ~I[29];
	assign movz_SA[4] = I[4] | ~I[29];
	
	wire [1:0] Bcond;
	wire Bcondmux, Bcondand1, Bcondand2;
	
	wire znotc, nxnorv, norv;
	
	assign znotc = ~status[0]&status[2];
	assign nxnorv = ~(status[1]^status[3]);
	assign norv = ~status[0]&nxnorv;
	
	Mux8to1Nbit inst002 (Bcondmux, I[3:1], status[0], status[2], status[1], status[3], znotc, nxnorv, norv, 1'b1);
	defparam inst002.N = 1;
	
	assign Bcondand1 = ~(I[0]&I[1]&I[2]&I[3]);
	assign Bcondand2 = Bcondand1 & I[0];

	assign Bcond = {Bcondmux ^ Bcondand2,Bcondmux ^ Bcondand2};
	
	wire [1:0] cbzxor;
	
	assign cbzxor = I[24] ^ status[4];
	
		
											    //CG   NS  PS  IL  EN_PC  EN_ADDR_PC  PCsel  SL  size  mem_write  mem_read  EN_ALU  EN_ADDR_ALU  EN_B  C0   FS  	 Bsel  regwrite    SB     SA     DA
		assign IF =    				  42'b000__01__01__1_____0_________1________0_____0___00______0__________1________0__________0_________0___0___00000____0_______0______11111___00000__00000;
		assign AND_ANDS_ORR_EOR = 	 {11'b000__00__01__0_____0_________0________0__,and_SL,8'b00_____0__________0________1__________0______0___0__,and_FS,2'b__0____1_____,I[20:16],I[9:5],I[4:0]};
		

		assign ADD_ADDS_SUB_SUBS =  {11'b000__00__01__0_____0_________0_______0___,I[29],8'b00_____0__________0________1__________0_______0___0__,add_FS,2'b__0____1_____,I[20:16],I[9:5],I[4:0]};
		//includes CMP^^^ I[4:0]== 11111;
		
		assign LDUR_STUR = 			 {14'b110__00__01__0_____0_________0_______0______0___00_____,~I[22],   I[22],2'b_0__________1,    ~I[22],7'b0_01000____1____,I[22],   I[4:0],  I[9:5],I[4:0]};
		assign MOVZ_MOVK = 		{2'b01,I[29],I[29],16'b0_00_0__0_________0_______0______0___00______0__________0________1__________0________0___0___00,I[29],3'b00_1,~I[29],5'b00000,movz_SA,I[4:0]};
		assign ANDI_ORI_EORI_ANDIS = {11'b001__00__01__0_____0_________0________0__,and_SL,8'b00_____0__________0________1__________0______0___0__,and_FS,2'b__1____1_____,5'b00000,I[9:5],I[4:0]};
		assign ADDI_SUBBI = 			 {11'b000__00__01__0_____0_________0_______0___,I[29],8'b00_____0__________0________1__________0_______0___0__,add_FS,2'b__1____1_____,5'b00000,I[9:5],I[4:0]};
		assign BR = 					 {32'b000__00__00__0_____0_________0_______0_____0____00______0__________0________0_________0__________0___0___00000____0_______0_____00000,   I[9:5],5'b00000};
		assign B_COND = 				 {5'b101__00__,Bcond,35'b0_0_______0_______1_____0____00______0__________0________0_________0__________0___0___00000____0_______0_____00000____00000__00000};
		assign CBZ_CBNZ = 			 {5'b101__00__,cbzxor,36'b0_0______0_______1_____0____00______0__________0________0_________0__________0___0___00100____0_______0_____11111,   I[4:0],5'b00000};
		assign B_BL = 					 {36'b100_00___11__0_____1__________0_______1_____0____00______0__________0________0_________0__________0___0___00000____0______,I[31],15'b00000____00000__11110};
		assign MOVK2 = 				 {32'b010__00__01__0____0__________0_______0______0___00_____0___________0_______1__________0__________0___0___00100____1_______0_____00000____,I[4:0],I[4:0]};
		
		
	RegisterNbit inst0 (control_selects[1:0], Fcontrol_word[38:37], 1'b1, reset, clock);
	defparam inst0.N = 2;
	
	
	wire [1:0]E1_out, E2_out;
	wire E3_out;
	
	E1 instencode1 (I[28:25], E1_out);
	
	E2 instencode2 ({I[30:29],I[25]}, E2_out);
	
	E3 instencode3 ({I[29:28],I[24],I[21],I[11:10]}, E3_out);
	
	
	constant_generator_select cgs1 (Fcontrol_word[41:39], I, K);
	
	Mux4to1Nbit mux1 (Fcontrol_word[41:0], control_selects, IF, MOVK2, EX1, EX2);
	defparam mux1.N = 42;
	
	Mux4to1Nbit mux2 (EX0, E1_out[1:0], DataImm, Branches, Mem, DataReg);
	defparam mux2.N = 42;

	Mux8to1Nbit mux3 (DataImm, I[25:23], 42'b0, 42'b0, ADDI_SUBBI, 42'b0, ANDI_ORI_EORI_ANDIS, MOVZ_MOVK, 42'b0, 42'b0);
	defparam mux3.N = 42;
	
	Mux4to1Nbit mux4 (Branches, E2_out[1:0], B_BL, CBZ_CBNZ, B_COND, BR);
	defparam mux4.N = 42;
	
	Mux2to1Nbit mux5 (Mem, E3_out, LDUR_STUR, 42'b0);
	defparam mux5.N = 42;
	
	Mux4to1Nbit mux6 (DataReg, {I[28], I[24]}, AND_ANDS_ORR_EOR, ADD_ADDS_SUB_SUBS, 42'b0, 42'b0);
	defparam mux6.N = 42;
		
		
		
		
		
endmodule 