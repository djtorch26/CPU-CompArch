module datapath_memory (memread, memwrite,control_word, instruction_reg_out, constant, reset, clock, data, address, size, r0, r1, r2, r3, r4, r5, r6, r7, alu_status, alu_out);


output [31:0] instruction_reg_out;
input [36:0] control_word;
input clock, reset;
input [63:0] constant;
output [63:0] alu_out;
inout [63:0] data;
output memread, memwrite;
output [31:0] address;
output [1:0] size;
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
output [3:0] alu_status;

assign memread = control_word[26];
assign memwrite = control_word[27];

datapath inst0 (control_word, instruction_reg_out, constant, reset, clock, data, address, size, r0, r1, r2, r3, r4, r5, r6, r7, alu_status, alu_out);

True_RAM inst1 (clock, address, data, control_word[27], control_word[26]);
defparam inst1.base_address = 32'h00020000;
defparam inst2.address_width = 10;

True_Rom inst2 (clock, address, data, control_word[26]);
defparam inst2.base_address = 32'h00000000;
defparam inst2.address_width = 10;

endmodule


