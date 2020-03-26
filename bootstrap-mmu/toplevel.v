`timescale 1ns / 1ps

module toplevel(
                input        reset_n,
                input        clock, // Assum 1MHz.
                inout [15:0] address,
                inout        ram_we_n,
                output       ram_cs_n,
                inout        eeprom_oe_n,
                output       eeprom_cs_n,
                output       via_ce_n,
                output       acia_ce_n
                );

   parameter
     START_COPYING = 2'b00,
     COPYING_EEPROM = 2'b01,
     DONE = 2'b10;

   reg [12:0]                current_address;
   reg [1:0]                 state;
   reg                       ram_we_n_state;
   
   always @ (posedge clock) begin
      if (reset_n == 0) begin
         state <= COPYING_EEPROM;
      end else begin
         case (state)
           START_COPYING:
             begin
                current_address <= 13'd0;
                ram_we_n_state <= 1;
                state <= COPYING_EEPROM;
             end
           // At any frequency up to 6.66MHz we should just be able to proceed 1 state per clock.
           // At 1MHz transferring 8KB of EEPROM will take 8192*4*1us = 32ms.
           // SET_UP_ADDRESS (address shows up; wait 150ns for eeprom data to show up.)
           // ENABLE_WRITE (write pulse width is at least 25-90ns based on SRAM).
           // DISABLE_WRITE (data should hold for another 5-10ns).
           // INCREMENT_ADDRESS or DONE.
           COPYING_EEPROM:
             begin
                if (current_address == 13'b1111111111111) begin
                   ram_we_n_state <= 0;
                   state <= DONE;
                end else begin
                   current_address <= current_address + 1;
                   state <= COPYING_EEPROM;
                end
             end
           DONE:
             begin
                state <= DONE;
             end
           default:
             begin
                state <= START_COPYING;
             end
         endcase
         end
   end

   assign address = { 3'b0, current_address };
   assign ram_we_n = state != DONE ? ram_we_n_state : 1'bz;
   assign ram_cs_n = state != DONE;
   assign eeprom_oe_n = state != DONE;
   assign eeprom_cs_n = state != DONE;
endmodule
