`timescale 1ns / 1ps

module memory_copier_test;

   // Inputs
   reg reset_n;
   reg clock;

   // Outputs
   wire [15:0] address;
   wire        ram_we_n;
   wire        ram_cs_n;
   wire        eeprom_oe_n;
   wire        eeprom_cs_n;
   wire        done;

   // Instantiate the Unit Under Test (UUT)
   memory_copier
     #(.EEPROM_ADDRESS_BUS_WIDTH(4))
   uut (
        .reset_n(reset_n),
        .clock(clock),
        .address(address),
        .ram_we_n(ram_we_n),
        .ram_cs_n(ram_cs_n),
        .eeprom_oe_n(eeprom_oe_n),
        .eeprom_cs_n(eeprom_cs_n),
        .done(done)
        );

   initial begin
      // Initialize Inputs
      reset_n = 0;
      clock = 0;

      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      reset_n = 1;
   end

   always begin
      #500 clock = ~clock;
   end

   initial #100000 $finish;
endmodule

