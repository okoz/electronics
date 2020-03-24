open! Core_kernel
open HardCaml

module Interface = HardCaml.Interface

module Mmu = struct
  let name = "MMU"
  let desc = "MMU for 65C02 microcomputer"

  module Make (B : Comb.S) : sig
    module I : Interface.S
    module O : Interface.S
    val hw : B.t I.t -> B.t O.t
  end = struct
    module I = struct
      type 'a t =
        { address : 'a
        ; reset_n : 'a
        }

      let t =
        { address = ("address", 3)
        ; reset_n = ("reset_n", 1) }

      let map f a = { address = f a.address; reset_n = f a.reset_n }
      let map2 f a b = { address = f a.address b.address; reset_n = f a.reset_n b.reset_n }
      let to_list t = [ t.address; t.reset_n ]
    end

    module O  = struct
      type 'a t = {
        eeprom_ce_n : 'a
      ; ram_ce_n : 'a
      ; via_ce_n : 'a
      ; acia_ce_n : 'a
      }

      let t =
        { eeprom_ce_n = ("eeprom_ce_n", 1)
        ; ram_ce_n = ("ram_ce_n", 1)
        ; via_ce_n = ("via_ce_n", 1)
        ; acia_ce_n = ("acia_ce_n", 1) }

      let map f a =
        { eeprom_ce_n = f a.eeprom_ce_n
        ; ram_ce_n = f a.ram_ce_n
        ; via_ce_n = f a.via_ce_n
        ; acia_ce_n = f a.acia_ce_n }

      let map2 f a b =
        { eeprom_ce_n = f a.eeprom_ce_n b.eeprom_ce_n
        ; ram_ce_n = f a.ram_ce_n b.ram_ce_n
        ; via_ce_n = f a.via_ce_n b.via_ce_n
        ; acia_ce_n = f a.acia_ce_n b.acia_ce_n }

      let to_list t = [ t.eeprom_ce_n; t.ram_ce_n; t.via_ce_n; t.acia_ce_n ]
    end

    let hw (i : 'a I.t) =
      let open B in
      { O.eeprom_ce_n = mux2 i.reset_n (~: ((bit i.address 2) &: (bit i.address 1) &: (bit i.address 0))) (const "1'b1")
      ; ram_ce_n = mux2 i.reset_n (bit i.address 2) (const "1'b1")
      ; via_ce_n = mux2 i.reset_n ((~: (bit i.address 2)) |: (bit i.address 1)) (const "1'b1")
      ; acia_ce_n = mux2 i.reset_n ((~: (bit i.address 2)) |: (~: (bit i.address 1)) |: (bit i.address 0)) (const "1'b1")}
  end
end

let () =
  let module Mmu = Mmu.Make (Signal.Comb) in
  let module Circuit = Interface.Circ (Mmu.I)(Mmu.O) in 
  let circuit = Circuit.make "mmu" Mmu.hw in
  Rtl.Verilog.write (output_string stdout) circuit
