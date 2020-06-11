module True_Rom (clock, address, data, mem_read);

inout [63:0] data;
input [31:0] address;
input mem_read;
input clock;

parameter base_address = 32'h00000000;
parameter address_width = 10;

wire chip_select;

AddressDetect inst_add (address, chip_select);
defparam inst_add.base_address = base_address;
defparam inst_add.address_mask = 32'hFFFFFFFF << address_width;

wire [63:0] out;

rom_case inst_rom (out, address);

wire outselect;

and inst00 (outselect, chip_select, mem_read);

tri_state_64 inst_rom1(.a(out), .b(data), .enable(outselect));

endmodule
