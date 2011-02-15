{
  open DiceParser
  open Lexing

  let tbl = Hashtbl.create 16;;
  Hashtbl.add tbl "exit" (fun x -> exit 0);;
  Hashtbl.add tbl "history" (fun x -> DiceRoller.print_diceroll 
  (RollHistory.get_hist x));;
}

let digit = ['0' - '9']
let ident = ['a' - 'z']
rule token = parse
  | '\n' { NEWLINE }
  | digit+ as num { NUM (int_of_string num) }
  | 'd' { D }
  | ident* as word { try
		       let f = Hashtbl.find tbl word in
			 COMM f			 
		     with Not_found -> COMM (fun x -> (print_endline "no such command"))
		   }
  | _ { token lexbuf }
  | eof { raise End_of_file }
