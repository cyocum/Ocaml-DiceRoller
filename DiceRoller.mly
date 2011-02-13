%{
  open DiceRoller
%}

%token <int> NUM

%start input
%type <unit> input

%%

input: /* empty */ { }
      | input line { }
;

line: NEWLINE { }
      | NUM 'd' NUM { DiceRoller.print_diceroll (DiceRoller.roll $1 $3) }

%%
