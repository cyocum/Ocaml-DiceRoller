(*
Copyright 2011 Christopher Guy Yocum 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)

{
  open DiceParser
  open Lexing

  let tbl = Hashtbl.create 16;;
  Hashtbl.add tbl "exit" (fun x -> RandomPool.save_pool (); exit 0);;
  (*Hashtbl.add tbl "history" (fun x -> DiceRoller.print_diceroll *)
  (*(RollHistory.get_hist x));;*)
}

let digit = ['0' - '9']
let ident = ['a' - 'z']
let modifier = ['+' '-']
rule token = parse
  | '\n' { NEWLINE }
  | digit+ as num { NUM (int_of_string num) }
  | 'd' { D }
  | modifier as mod_str { MOD(mod_str) }
  | ident* as word { try
		       let f = Hashtbl.find tbl word in
			 COMM f			 
		     with Not_found -> COMM (fun x -> (print_endline "no such command"))
		   }
  | _ { token lexbuf }
  | eof { raise End_of_file }
