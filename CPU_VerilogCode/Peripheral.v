module SPIPeripheral(clk, Data, display)
	
	input clk;
	input data;
	output display;
	
	
endmodule

module Master(Sclk, MOSI, MISO, ss0, ss1, ss2, ss3)
	
	output ss1, ss2, ss3;
	output Sclk;
	output [7:0]MOSI;
	input [7:0]MISO;
	
	
	
	
endmodule

module Slave (Sclk, MOSI, MISO, ss)

	input Sclk;
	input MOSI;
	output MISO;
	input ss;
	
endmodule

module TransmitterFSM(clock, reset, ready, ns, newbyte, transmit)

		input clock,reset;
		input ready;
		input ns, newbyte;
		output transmit;
		
		wire clock, reset, ns, nbyte, ready;
		
		reg transmit;
		
		parameter SIZE = 3;
		parameter IDLE = 3'001, WAIT = 3'010, SEND = 3'b100;
		
		reg [SIZE-1:0] state;
		wire [SIZE-1:0] nextState;
		
		assign nextState = TransmitterFSM(state, ready, reset, ns, newbyte);
		
		function [SIZE-1:0] TransmitterFSM;
			input [SIZE-1:0] state;
			input ready, reset, ns, newbye;
			
				case(state)
					IDLE: 	if (ready == 1'b1) begin
									TransmitterFSM = WAIT;
								end else if (ready == 1'b0) begin
									TransmitterFSM = IDLE;
								end 
								
					WAIT:		if (ns == 1'b1) begin
									TransmitterFSM = SEND;
								end else if (ns == 1'b0) begin
									TransmitterFSM = WAIT;
								end
								
					SEND: 	if (newbyte == 1'b1)
									TransmitterFSM = SEND;
								end else if (newbyte == 1'b0)
									TransmitterFSM = WAIT;
								
								
						default: TransmitterFSM = IDLE;
				endcase
			endfunction
	
	always @ (posedge clock)
		begin : FSM
			if (reset == 1'b1) begin
				state <= #1 IDLE;
			end else begin
				state <= #1 nextState;
			end 
		end 
		
	always @ (posedge clock)
		begin: OutLogic
			if (reset == 1'b1) begin 
				transmit <= 1'b0;
			end
			else begin 
				case(state)
					IDLE: begin
							transmit = #1 1'b0;
							end
					WAIT: begin
							transmit = #1 1'b0;
							end
					SEND: begin
							transmit = #1 1'b1;
							end
					endcase
				end
			end
endmodule
		
		
	
	
	
	
	
	
	