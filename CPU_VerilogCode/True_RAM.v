module True_RAM (clock, address, data, mem_write, mem_read);

inout [63:0] data;
input [31:0] address;
input mem_write, mem_read;
input clock;

parameter base_address = 32'h00020000;
parameter address_width = 10;

wire chip_select;

AddressDetect inst_add (address, chip_select);
defparam inst_add.base_address = base_address;
defparam inst_add.address_mask = 32'hFFFFFFFF << address_width;

wire [63:0] raminout;

ram_sp_sr_sw inst_ram (clock, address, raminout, chip_select, mem_write, mem_read);
defparam inst_ram.ADDR_WIDTH = address_width;


tri_state_64 inst_ram2(.a(raminout), .b(data), .enable(mem_read));
tri_state_64 inst_ram3(.a(data), .b(raminout), .enable(mem_write));

endmodule
