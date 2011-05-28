type token =
  | NUM of (int)
  | NEWLINE
  | D
  | COMM of (int -> unit)
  | MOD of (char)

open Parsing;;
# 2 "diceParser.mly"

       
# 13 "diceParser.ml"
let yytransl_const = [|
  258 (* NEWLINE *);
  259 (* D *);
    0|]

let yytransl_block = [|
  257 (* NUM *);
  260 (* COMM *);
  261 (* MOD *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\003\000\004\000\
\005\000\005\000\000\000"

let yylen = "\002\000\
\000\000\002\000\001\000\002\000\002\000\002\000\003\000\005\000\
\002\000\002\000\002\000"

let yydefred = "\000\000\
\001\000\000\000\000\000\000\000\003\000\000\000\002\000\000\000\
\000\000\000\000\000\000\009\000\010\000\004\000\005\000\006\000\
\000\000\000\000\008\000"

let yydgoto = "\002\000\
\003\000\007\000\008\000\009\000\010\000"

let yysindex = "\001\000\
\000\000\000\000\255\254\004\255\000\000\003\255\000\000\006\255\
\007\255\008\255\005\255\000\000\000\000\000\000\000\000\000\000\
\009\255\010\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\012\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\011\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 14
let yytable = "\004\000\
\005\000\001\000\006\000\012\000\013\000\017\000\011\000\014\000\
\015\000\016\000\019\000\011\000\007\000\018\000"

let yycheck = "\001\001\
\002\001\001\000\004\001\001\001\002\001\001\001\003\001\002\001\
\002\001\002\001\001\001\000\000\002\001\005\001"

let yynames_const = "\
  NEWLINE\000\
  D\000\
  "

let yynames_block = "\
  NUM\000\
  COMM\000\
  MOD\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 16 "diceParser.mly"
                   ( )
# 80 "diceParser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'line) in
    Obj.repr(
# 17 "diceParser.mly"
                   ( )
# 88 "diceParser.ml"
               : unit))
; (fun __caml_parser_env ->
    Obj.repr(
# 20 "diceParser.mly"
              ( )
# 94 "diceParser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'roll) in
    Obj.repr(
# 21 "diceParser.mly"
                     ( )
# 101 "diceParser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'roll_with_mod) in
    Obj.repr(
# 22 "diceParser.mly"
                              ( )
# 108 "diceParser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'command) in
    Obj.repr(
# 23 "diceParser.mly"
                        ( )
# 115 "diceParser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 26 "diceParser.mly"
                ( 
  DiceRoller.print_and_record _1 _3 '+' 0
)
# 125 "diceParser.ml"
               : 'roll))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 31 "diceParser.mly"
                                 (
	DiceRoller.print_and_record _1 _3 _4 _5
)
# 137 "diceParser.ml"
               : 'roll_with_mod))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int -> unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "diceParser.mly"
                   ( _1 _2 )
# 145 "diceParser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int -> unit) in
    Obj.repr(
# 37 "diceParser.mly"
                     ( _1 0 )
# 152 "diceParser.ml"
               : 'command))
(* Entry input *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let input (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
;;
