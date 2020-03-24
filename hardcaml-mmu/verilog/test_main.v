`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:44:20 03/22/2020
// Design Name:   main
// Module Name:   C:/Users/olegk/Documents/Projects/FPGA/CPLD_MMU/test_main.v
// Project Name:  CPLD_MMU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_main;

	// Inputs
	reg [15:13] ADDR;
	reg RESET_N;

	// Outputs
	wire EEPROM_CE_N;
	wire RAM_CE_N;
	wire VIA_CE_N;
	wire ACIA_CE_N;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.ADDR(ADDR), 
		.RESET_N(RESET_N), 
		.EEPROM_CE_N(EEPROM_CE_N), 
		.RAM_CE_N(RAM_CE_N), 
		.VIA_CE_N(VIA_CE_N), 
		.ACIA_CE_N(ACIA_CE_N)
	);

	initial begin
		// Initialize Inputs
		ADDR = 0;
		RESET_N = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		RESET_N = 1;
		#5;
		
		// Add stimulus here
		ADDR = 3'b000;
		#5;
		ADDR = 3'b001;
		#5;
		ADDR = 3'b010;
		#5;
		ADDR = 3'b011;
		#5;
		ADDR = 3'b100;
		#5;
		ADDR = 3'b101;
		#5;
		ADDR = 3'b110;
		#5;
		ADDR = 3'b111;
		#5;
		$finish;
	end
      
endmodule

