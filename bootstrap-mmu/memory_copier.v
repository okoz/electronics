`timescale 1ns / 1ps

module memory_copier(
                     input         reset_n,
                     input         clock,
                     output [15:0] address,
                     output        ram_we_n,
                     output        ram_cs_n,
                     output        eeprom_oe_n,
                     output        eeprom_cs_n,
                     output        done
                     );

   // 8KB of EEPROM.
   parameter EEPROM_ADDRESS_BUS_WIDTH = 13;
   parameter
     SETTLE_ADDRESS_AND_DATA = 0,
     START_WRITE = 1,
     END_WRITE = 2,
     NEXT_ADDRESS = 3,
     DONE = 4;

   reg [2:0]                       state;
   reg [EEPROM_ADDRESS_BUS_WIDTH:0] current_address;
   reg                              ram_we_n_state;
 
   assign address[15:0] = {{(16-EEPROM_ADDRESS_BUS_WIDTH){1'b1}}, current_address};
   assign ram_we_n = ram_we_n_state;
   assign ram_cs_n = 0;
   assign eeprom_oe_n = 0;
   assign eeprom_cs_n = 0;
   assign done = state == DONE;
   
   always @ (posedge clock) begin
      if (reset_n == 0) begin
         state <= SETTLE_ADDRESS_AND_DATA;
         // Set the most significant bits to high because we want to copy the
         // EEPROM to the highest RAM address.
         current_address <= {EEPROM_ADDRESS_BUS_WIDTH{1'b0}};
         ram_we_n_state <= 1;
      end else begin
         case (state)
           SETTLE_ADDRESS_AND_DATA:
             begin
                state <= START_WRITE;
             end
           START_WRITE:
             begin
                ram_we_n_state <= 0;
                state <= END_WRITE;
             end
           END_WRITE:
             begin
                ram_we_n_state <= 1;
                state <= NEXT_ADDRESS;
             end
           NEXT_ADDRESS:
             begin
                if (current_address == {EEPROM_ADDRESS_BUS_WIDTH{1'b1}}) begin
                   state <= DONE;
                end else begin
                   current_address <= current_address + 1;
                   state <= SETTLE_ADDRESS_AND_DATA;
                end
             end
           DONE:
             begin
                state <= DONE;
             end
           default:
              begin
                 state <= state;
              end
         endcase
      end
   end
endmodule
