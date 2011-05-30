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
  let range = BatEnum.range 0 ~until:7 in
  let rec byte_of_string_aux offset accum =
    match offset with
      | x::xs ->
	begin
	  match bit_str.[x] with
	    | '1' ->
	      let curr = accum lor (1 lsl (7-x)) in
		byte_of_string_aux xs curr
	    | _ -> 
		byte_of_string_aux xs accum
	end
      | [] ->
	accum
  in
    byte_of_string_aux (BatList.of_enum range) 0

let int32_of_bytes bytes =
  if List.length bytes <> 4 then
    raise (Invalid_argument ("there must be 4 bytes to make a 32 bit int"))
  else
    let res = ref 0l in
      for i = 0 to 3 do
	let byte = List.nth bytes i in
	  res := Int32.logor !res (Int32.shift_left (Int32.of_int byte) (8*i))
      done;
    if (Int32.compare !res 0l) < 0 then
      Int32.add (Int32.lognot !res) Int32.one
    else
      !res

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
	Queue.Empty -> begin
	  replenish_pool byte_q;
	  take num_elems
	end

let int_of_bits bit_list = 
  BatList.fold_right (fun x z -> 2 * z + x) bit_list 0

let get_rand_int num_sides =
  let bytes_lst = take 4 in
  let int32 = int32_of_bytes bytes_lst in
    (Int32.to_int int32) mod num_sides + 1

let save_pool () =
  let oc = BatFile.open_out_bin ~mode:[`append; `create] "random.bin" in
    Queue.iter (fun x -> BatIO.write_byte oc x) byte_q;
    (*flush oc;*)
    BatIO.close_out oc
  
(*let load_pool () =
  let ic = BatFile.open_in "random.bin" in
    List.iter (fun x -> BatIO.input ic)*)
