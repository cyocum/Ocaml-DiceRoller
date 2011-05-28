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


open Http_client.Convenience
open Http_client
open Queue
open Random

let byte_q = Queue.create ()

let int_of_bool = function
  | true -> 1
  | false -> 0

let rand_bytes () =
  let response =  http_get_message "http://random.org/cgi-bin/randbyte?nbytes=1024&format=bin" in
  let nl_split = Pcre.split ~pat:"\n" in
  let sp_split = Pcre.split ~pat:" " in
  let lst_split = nl_split response#response_body#value in
    BatList.flatten (BatList.map sp_split lst_split)

let replenish_pool byte_q =
  List.iter (fun lst_mem -> Queue.add lst_mem byte_q)
    (rand_bytes ())

let rec take num_elems =
  if num_elems <= 0 then []
  else 
    try
      Queue.take byte_q :: take (num_elems - 1)
    with
	Empty -> begin
	  replenish_pool byte_q;
	  take num_elems
	end

let int_of_bits bit_list = 
  BatList.fold_right (fun x z -> 2 * z + x) bit_list 0

let get_rand_int num_sides = 
  let int32_list = take 4 in
  let int32_str = String.concat "" int32_list in
  let int32_bit_lst = Pcre.split ~pat:"" int32_str in
  let my_int32 = (int_of_bits (BatList.map (int_of_string) int32_bit_lst)) in
    my_int32 mod num_sides + 1


