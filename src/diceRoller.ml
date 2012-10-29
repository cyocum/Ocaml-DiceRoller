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

type r = 
    {
      total : int;
      dice_rolled : int list;
    }

let print_roll { total; dice_rolled } =
  print_endline (String.concat ", " (BatList.map string_of_int dice_rolled));
  print_endline ("total: " ^ (string_of_int total))

let print_rolls lst =
  List.iter print_roll lst

let roll num_dice num_sides =
  let rec aux nd accum =
    if num_sides <= 0 then raise (ZeroSides ("A die cannot be zero sides")) 
    else
      if nd <= 0 then accum
      else
        let ret = RandomPool.get_rand_int num_sides in
	aux (pred nd) (ret::accum)
  in
  let dices = (aux num_dice []) in 
  { dice_rolled = dices; total = (List.fold_left (+) 0 dices) }

let op_roll op lhs rhs =
  { total = (op lhs.total rhs.total); dice_rolled = (BatList.append lhs.dice_rolled rhs.dice_rolled) }

let num_op op lhs num =
  { lhs with total = (op lhs.total num) }

let nil_roll =
  { total = 0; dice_rolled = [] }









