type token =
  | NUM of (int)
  | NEWLINE
  | D
  | COMM of (int -> unit)
  | MOD of (char)

val input :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
