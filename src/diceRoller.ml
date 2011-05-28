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


exception BadDiceRoll of string
exception ZeroSides of string

let apply_mod mod_char total mod_num =
  match mod_char with  
    | '+' -> total + mod_num
    | '-' -> total - mod_num
    | _ -> (raise (Invalid_argument ("either + or -")))

let rec roll num_dice num_sides =
  if num_sides <= 0 then raise (ZeroSides ("A die cannot be zero sides")) 
  else
    if num_dice <= 0 then [] 
    else
      let ret = RandomPool.get_rand_int num_sides in
	ret :: roll (num_dice - 1) num_sides

let print_diceroll roll_list total =
  let str_roll_list = BatList.map string_of_int roll_list in
  let out_str_roll_list = String.concat "," str_roll_list in
    print_endline out_str_roll_list;
    print_string "total: ";
    print_int total;
    print_newline ();
    print_string "# "

let print_and_record num_dice num_sides mod_char mod_num =
    try
      let roll = roll num_dice num_sides in
      let total = (List.fold_left (+) 0 roll)  in
      let total_mod = apply_mod mod_char total mod_num in
        print_diceroll roll total_mod;
        RollHistory.add roll total_mod
    with
        BadDiceRoll bad -> 
	  print_string("Exception raised: " ^ bad ^ "\n")
      | ZeroSides zsides -> 
          print_string("Exception raised: " ^ zsides ^ "\n")
