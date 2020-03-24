`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:12:26 03/23/2020
// Design Name:
// Module Name:    reference_mmu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module reference_mmu(
	input [2:0] address,
  input       reset_n,
  output      eeprom_ce_n,
  output      ram_ce_n,
  output      via_ce_n,
  output      acia_ce_n
	);
   assign eeprom_ce_n = reset_n ? ~(address[2] & address[1] & address[0]) : 1;
	 assign ram_ce_n = reset_n ? address[2] : 1;
	 assign via_ce_n = reset_n ? ~(address[2] & ~address[1]) : 1;
	 assign acia_ce_n = reset_n ? ~(address[2] & address[1] & ~address[0]) : 1;
endmodule
