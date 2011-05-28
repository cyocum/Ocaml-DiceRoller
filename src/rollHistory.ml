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


type roll = {
  roll_lst : int list;
  total : int
}

let hist = ref []

let add lst total =
  let last = [{ roll_lst = lst; total = total }] in
    match !hist with
    | [] -> hist := last; ()
    | xs -> hist := BatList.append xs last; ()

let get_hist num =
  try 
    let rolls = BatList.at !hist (num - 1) in
      rolls.roll_lst
  with
    Invalid_argument e -> 
      print_endline e; 
      [0] 
