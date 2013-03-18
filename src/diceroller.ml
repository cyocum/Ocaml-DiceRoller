open Lexing
open Parsing

let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
      Sys.catch_break true;
      RandomPool.load_pool ();
      while true do
	try
	  let ast = DiceParser.input DiceLexer.token lexbuf in
            DiceRoller.print_rolls (DiceAST.eval_lst ast);
	with
	  | Parse_error -> ()
      done
  with
    | End_of_file -> exit 0
    | Sys.Break ->
      begin
	RandomPool.save_pool ();
	exit 0
      end
