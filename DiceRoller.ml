open Str
open RandomPool;;

module type DICE_ROLLER =
sig
  val roll : int -> int -> int list
  val print_diceroll : int list -> unit
  exception BadDiceRoll of string
  exception ZeroSides of string
end

module DiceRoller : DICE_ROLLER =
struct
  exception BadDiceRoll of string
  exception ZeroSides of string

  let rec roll num_dice num_sides =
    if num_sides <= 0 then raise (ZeroSides ("A die cannot be zero sides")) 
    else
      if num_dice <= 0 then [] 
      else
        let ret = RandomPool.get_rand_int num_sides in
	  ret :: roll (num_dice - 1) num_sides
  ;;

  let print_diceroll roll_list =
    let total = List.fold_left ( + ) 0 roll_list in
    let str_roll_list = List.map string_of_int roll_list in
    let out_str_roll_list = String.concat "," str_roll_list in
      print_endline out_str_roll_list;
      print_string "total: ";
      print_int total;
      print_newline ();
      print_string "# ";
  ;;

end;;
