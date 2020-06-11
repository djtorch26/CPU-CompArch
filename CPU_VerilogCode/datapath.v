module datapath (control_word, instruction_reg_out, constant, reset, clock, data, address, size, r0, r1, r2, r3, r4, r5, r6, r7, alu_status, alu_out);


output [31:0] instruction_reg_out;
input [36:0] control_word;
input clock, reset;
input [63:0] constant;
output [63:0] alu_out;
inout [63:0] data;
output [31:0] address;
output [1:0] size;
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
output [4:0] alu_status;

wire Status_load, PCsel, EN_ADDR_PC, EN_PC, instruction_load;
wire [1:0] PS;

wire [63:0] A, B, raminout;
wire [4:0] DA, SA, SB, FS;
wire WR, Bsel, Co, En_B, En_ADDR_ALU, EN_ALU;
wire [1:0] Mem;
wire [31:0] ADDRESS;
wire mem_read, mem_write;

assign DA = control_word[4:0];
assign SA = control_word[9:5];
assign SB = control_word[14:10];
assign WR = control_word[15];
assign Bsel = control_word[16];
assign FS = control_word[21:17];
assign Co = control_word[22];
assign En_B = control_word[23];
assign En_ADDR_ALU = control_word[24];
assign En_ALU = control_word[25];
assign mem_read = control_word[26];
assign mem_write = control_word[27];
assign mem = control_word[29:28];
assign Status_load = control_word[30];
assign PCsel = control_word[31];
assign EN_ADDR_PC = control_word[32];
assign EN_PC = control_word[33];
assign instruction_load = control_word[34];
assign PS = control_word[36:35];

RegisterFile32x64 inst_reg (.A(A), .B(B), .SA(SA), .SB(SB), .D(data), .DA(DA), .W(WR), .reset(reset), .clock(clock), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7));

wire [63:0] mux_out;

mux2to1_64bit inst_mux(.F(mux_out), .S(Bsel), .I0(B), .I1(constant));

wire [63:0] alu_outw;
wire [3:0] alu_statusw;
 
ALU_LEGv8 inst_alu (.A(A), .B(mux_out), .FS(FS), .C0(Co), .F(alu_outw), .status(alu_statusw));

assign alu_out = alu_outw;

tri_state_64 inst_ENB (.a(B), .b(data), .enable(En_B));
tri_state_32 inst_ENADDR (.a(alu_outw[31:0]), .b(ADDRESS), .enable(En_ADDR_ALU));
tri_state_64 inst_ENALU (.a(alu_outw), .b(data), .enable(En_ALU));


assign address = ADDRESS;

RegisterNbit inst_status_reg (.Q(alu_status), .D(alu_statusw), .L(Status_load), .R(reset), .clock(clock));
defparam inst_status_reg.N = 4;

RegisterNbit inst_instruction_reg (.Q(instruction_reg_out), .D(data[31:0]), .L(instruction_load), .R(reset), .clock(clock));
defparam  inst_instruction_reg.N = 32;

wire [63:0] mux_out_PC;

mux2to1_64bit inst_mux2(.F(mux_out_PC), .S(PCsel), .I0(A), .I1(constant));

wire [32:0] PC_out;

program_counter inst_count(.in(mux_out_PC), .PS(PS), .reset(reset), .clock(clock), .out(PC_out));

tri_state_32 inst_PC1(.a(PC_out), .b(ADDRESS), .enable(EN_ADDR_PC));
tri_state_32 inst_PC2(.a(PC_out), .b(data), .enable(EN_PC));

endmodule





module tri_state_64 (a, b, enable);

input [63:0]a;
input enable;
output [63:0]b;
wire [63:0] a, b;
wire enable;

assign b = (enable) ? a : 64'bz;

endmodule

module tri_state_32 (a, b, enable);

input [31:0]a;
input enable;
output [31:0]b;
wire [31:0] a, b;
wire enable;

assign b = (enable) ? a : 32'bz;

endmodule
