`timescale 1ns / 1ps

module toplevel(
                input        reset_n,
                input        clock, // Assume 1MHz.
                inout [15:0] address,
                inout        ram_we_n,
                output       ram_cs_n,
                inout        eeprom_oe_n,
                output       eeprom_cs_n,
                output       via_ce_n,
                output       acia_ce_n
                );

   wire                      done;

   wire [15:0]               mem_copier_address;
   wire                      mem_copier_ram_we_n;
   wire                      mem_copier_ram_cs_n;
   wire                      mem_copier_eeprom_oe_n;
   wire                      mem_copier_eeprom_cs_n;

   wire                      mmu_ram_cs_n;
   wire                      mmu_via_ce_n;
   wire                      mmu_acia_ce_n;

   assign address = done ? 16'bz : mem_copier_address;
   assign ram_we_n = done ? 1'bz : mem_copier_ram_we_n;
   assign eeprom_oe_n = done ? 1'b1 : mem_copier_eeprom_oe_n;
   assign eeprom_cs_n = done ? 1'b1 : mem_copier_eeprom_cs_n;
   assign ram_cs_n = done ? mmu_ram_cs_n : mem_copier_ram_cs_n;
   assign via_ce_n = done ? mmu_via_ce_n : 1'b1;
   assign acia_ce_n = done ? mmu_acia_ce_n : 1'b1;

   mmu mmu(
           .address(address[15:13]),
           .ram_cs_n(mmu_ram_cs_n),
           .via_ce_n(mmu_via_ce_n),
           .acia_ce_n(mmu_acia_ce_n)
           );

   memory_copier mem_copier(
                            .reset_n(reset_n),
                            .clock(clock),
                            .address(mem_copier_address),
                            .ram_we_n(mem_copier_ram_we_n),
                            .ram_cs_n(mem_copier_ram_cs_n),
                            .eeprom_oe_n(mem_copier_eeprom_oe_n),
                            .eeprom_cs_n(mem_copier_eeprom_cs_n),
                            .done(done)
                            );
endmodule
