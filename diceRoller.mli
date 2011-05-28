val roll : int -> int -> int list
val print_and_record : int -> int -> char -> int -> unit
val print_diceroll : int list -> int -> unit
exception BadDiceRoll of string
exception ZeroSides of string
 
