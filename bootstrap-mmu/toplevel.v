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

   memory_copier mem_copier(
                            .reset_n(reset_n),
                            .clock(clock),
                            .address(address),
                            .ram_we_n(ram_we_n),
                            .ram_cs_n(ram_cs_n),
                            .eeprom_oe_n(eeprom_oe_n),
                            .eeprom_cs_n(eeprom_cs_n),
                            .done(via_ce_n)
                            );
endmodule
