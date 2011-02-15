%{

       
%}

%token <int> NUM
%token NEWLINE D 
%token <int -> unit> COMM

%start input
%type <unit> input

%%

input: /* empty */ { }
      | input line { }
;

line: NEWLINE { }
      | roll NEWLINE { }
      | command NEWLINE { }
;

roll: NUM D NUM { 
  DiceRoller.print_and_record $1 $3
}
;

command : COMM NUM { $1 $2 }
      | COMM NEWLINE { $1 0 }
;
%%
