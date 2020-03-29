`timescale 1ns / 1ps

module mmu_test;

   // Inputs
   reg [2:0] address;

   // Outputs
   wire      ram_cs_n;
   wire      via_ce_n;
   wire      acia_ce_n;

   // Instantiate the Unit Under Test (UUT)
   mmu uut (
            .address(address),
            .ram_cs_n(ram_cs_n),
            .via_ce_n(via_ce_n),
            .acia_ce_n(acia_ce_n)
            );

   initial begin
      // Initialize Inputs
      address = 0;

      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      address = 3'b000;
      #1;
      address = 3'b001;
      #1;
      address = 3'b010;
      #1;
      address = 3'b011;
      #1;
      address = 3'b100;
      #1;
      address = 3'b101;
      #1;
      address = 3'b110;
      #1;
      address = 3'b111;
      #1;
      $finish;
   end
endmodule

