module control_unit_and_datapath (data, address, clock, reset, mem_read, mem_write, size, r0,r1,r2,r3,r4,r5,r6,r7);

input clock, reset;
inout [63:0] data;
output [1:0] size;
output [31:0] address;
output mem_read, mem_write;
output [15:0] r0,r1,r2,r3,r4,r5,r6,r7;


wire [36:0]control_word;
wire [31:0] instruction_reg_out;
wire [63:0] constant;
wire reset, clock;
wire [63:0] data;
wire [31:0] address;
wire [1:0] size;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
wire [4:0] alu_status;
wire [63:0] alu_out;
wire [31:0] I;

datapath_memory inst0 (mem_write, mem_read, control_word, I, constant, reset, clock, data, address, size, r0, r1, r2, r3, r4, r5, r6, r7, alu_status, alu_out);

control_unit inst1 (alu_status, I, control_word, constant, clock, reset);


endmodule
