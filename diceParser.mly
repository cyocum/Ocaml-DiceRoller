%{
  let hist = ref []
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
  try
    let roll = DiceRoller.roll $1 $3 in
      DiceRoller.print_diceroll roll;
      (*RollHistory.add !hist *)
  with
      DiceRoller.BadDiceRoll bad -> 
	print_string("Exception raised: " ^ bad ^ "\n");
    | DiceRoller.ZeroSides zsides -> 
        print_string("Exception raised: " ^ zsides ^ "\n");
}
;

command : COMM NUM { $1 $2 }
      | COMM NEWLINE { $1 0 }
;
%%
