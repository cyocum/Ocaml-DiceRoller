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

type r

val roll : int -> int -> r
val op_roll : (int -> int -> int) -> r -> r -> r
val num_op : (int -> int -> int) -> r -> int -> r
val nil_roll : r
val print_roll : r -> unit
val print_rolls : r list -> unit
