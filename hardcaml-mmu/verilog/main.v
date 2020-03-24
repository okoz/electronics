`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:50:30 03/10/2020
// Design Name:
// Module Name:    main
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
module main(
	input [15:13] ADDR,
	input RESET_N,
	output EEPROM_CE_N,
	output RAM_CE_N,
	output VIA_CE_N,
	output ACIA_CE_N
    );

	hardcaml_mmu mmu(
		.address(ADDR),
		.reset_n(RESET_N),
		.eeprom_ce_n(EEPROM_CE_N),
		.ram_ce_n(RAM_CE_N),
		.via_ce_n(VIA_CE_N),
		.acia_ce_n(ACIA_CE_N)
	);

	/*reference_mmu mmu(
		.address(ADDR),
		.reset_n(RESET_N),
		.eeprom_ce_n(EEPROM_CE_N),
		.ram_ce_n(RAM_CE_N),
		.via_ce_n(VIA_CE_N),
		.acia_ce_n(ACIA_CE_N)
	);*/
endmodule
