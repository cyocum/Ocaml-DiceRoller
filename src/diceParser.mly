%{
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
       
%}

%token <int> NUM
%token NEWLINE D 
%token ADD SUB MUL DIV
%token  IDENT
%token <unit -> unit> COMM

%start input
%type <DiceAST.t list> input

%%

input: /* empty */ { [DiceAST.Nil] }
      | rolls_aux NEWLINE { $1 }
;

roll: 
      | NUM D NUM { DiceAST.Roll($1, $3) }
      | op { $1 }
      | comm { $1 }
;

rolls_aux :
      | roll { [$1] }
      | rolls_aux roll { $2 :: $1 }
;

op : 
      | roll_op { $1 }
      | num_op { $1 }
;

roll_op :
      | roll ADD roll { DiceAST.Add($1, $3) }
      | roll SUB roll { DiceAST.Sub($1, $3) }
      | roll MUL roll { DiceAST.Mul($1, $3) }
      | roll DIV roll { DiceAST.Div($1, $3) }
;

num_op :
      | roll ADD NUM { DiceAST.Add($1, DiceAST.Num($3)) }
      | roll SUB NUM { DiceAST.Sub($1, DiceAST.Num($3)) }
      | roll MUL NUM { DiceAST.Mul($1, DiceAST.Num($3)) }
      | roll DIV NUM { DiceAST.Div($1, DiceAST.Num($3)) }
      | NUM ADD roll { DiceAST.Add($3, DiceAST.Num($1)) }
      | NUM SUB roll { DiceAST.Sub($3, DiceAST.Num($1)) }
      | NUM MUL roll { DiceAST.Mul($3, DiceAST.Num($1)) }
      | NUM DIV roll { DiceAST.Div($3, DiceAST.Num($1)) }
;

comm : COMM { DiceAST.Command($1) }

%%










