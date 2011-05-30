open Lexing
open Parsing
open DiceLexer
open DiceParser

let _ =
  try 
    let lexbuf = Lexing.from_channel stdin in
      while true do
	try 
	  RandomPool.load_pool ();
	  DiceParser.input DiceLexer.token lexbuf
	with Parse_error -> ()
      done
  with End_of_file -> exit 0


