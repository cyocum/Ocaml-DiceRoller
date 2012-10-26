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
}

let digit = ['0' - '9']
let ident = ['a' - 'z']
rule token = parse
  | '\n' { NEWLINE }
  | digit+ as num { NUM (int_of_string num) }
  | 'd' { D }
  | '+' { ADD }
  | '-' { SUB }
  | '*' { MUL }
  | '/' { DIV }
  | _ { token lexbuf }
  | eof { raise End_of_file }
