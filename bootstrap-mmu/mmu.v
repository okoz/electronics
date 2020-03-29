`timescale 1ns / 1ps

module mmu(
           input [2:0] address,
           output      ram_cs_n,
           output      via_ce_n,
           output      acia_ce_n
           );

   assign via_ce_n = ~(address[2] & ~address[1]);
   assign acia_ce_n = ~(address[2] & address[1] & ~address[0]);
   assign ram_cs_n = via_ce_n & acia_ce_n;
endmodule
