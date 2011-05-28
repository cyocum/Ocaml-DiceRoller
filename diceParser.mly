%{

       
%}

%token <int> NUM
%token NEWLINE D 
%token <int -> unit> COMM
%token <char> MOD

%start input
%type <unit> input

%%

input: /* empty */ { }
      | input line { }
;

line: NEWLINE { }
      | roll NEWLINE { }
      | roll_with_mod NEWLINE { }
      | command NEWLINE { }
;

roll: NUM D NUM { 
  DiceRoller.print_and_record $1 $3 '+' 0
}
;

roll_with_mod: NUM D NUM MOD NUM {
	DiceRoller.print_and_record $1 $3 $4 $5
}
;

command : COMM NUM { $1 $2 }
      | COMM NEWLINE { $1 0 }
;
%%
