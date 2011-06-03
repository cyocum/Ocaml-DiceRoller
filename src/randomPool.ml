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

let byte_q = Queue.create ()

let byte_of_string bit_str = 
  let byte_of_string_aux accum offset =
    match bit_str.[offset] with
      | '1' ->
	accum lor (1 lsl (7-offset))
      | _ ->
	accum
  in
  let range = BatEnum.range 0 ~until:7 in
    List.fold_left byte_of_string_aux 0 (BatList.of_enum range)

let int32_of_bytes bytes =
  if List.length bytes <> 4 then
    raise (Invalid_argument ("there must be 4 bytes to make a 32 bit int"))
  else
    let int32_of_bytes_aux accum byte offset =
      Int32.logor accum (Int32.shift_left (Int32.of_int byte) (8*offset))
    in
    let range = BatEnum.range 0 ~until:3 in
    let res = List.fold_left2 int32_of_bytes_aux 0l bytes (BatList.of_enum range) in
      if (Int32.compare res 0l) < 0 then
        Int32.add (Int32.lognot res) Int32.one
      else
	res

let rand_bytes () =
  let response =  http_get_message "http://random.org/cgi-bin/randbyte?nbytes=1024&format=bin" in
  let nl_split = Pcre.split ~pat:"\n" in
  let sp_split = Pcre.split ~pat:" " in
  let lst_split = nl_split response#response_body#value in
    BatList.map (byte_of_string) (BatList.flatten (BatList.map sp_split lst_split))

let replenish_pool byte_q =
  List.iter (fun lst_mem -> Queue.add lst_mem byte_q)
    (rand_bytes ())

let rec take num_elems =
  if num_elems <= 0 then []
  else 
    try
      Queue.take byte_q :: take (num_elems - 1)
    with
	Queue.Empty -> 
	  begin
	    replenish_pool byte_q;
	    take num_elems
	  end

let get_rand_int num_sides =
  let bytes_lst = take 4 in
  let int32 = int32_of_bytes bytes_lst in
    (Int32.to_int int32) mod num_sides + 1

let save_pool () =
  try
    let oc = BatFile.open_out "random.bin" in
      Queue.iter (fun x -> BatIO.write_byte oc x) byte_q;
      BatIO.close_out oc
  with
      Sys_error e ->
	print_endline "cannot save random pool...please check your permissions."
  
let load_pool () =
  let rec load_pool_aux ic =
    try
      Queue.add (BatIO.read_byte ic) byte_q;
      load_pool_aux ic
    with 
      | BatIO.No_more_input ->
	BatIO.close_in ic
  in
  try
    let ic = BatFile.open_in "random.bin" in
      print_endline "loading random.bin";
      load_pool_aux ic
  with
      Sys_error e ->
	print_endline "no random.bin found...loading from random source."
