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

let get_rand_bytes num_bytes =
  let ic = BatFile.open_in "/dev/random" in
  let rec get_rand_bytes_aux num_bytes lst =
    if num_bytes = 0 then
      begin
	BatIO.close_in ic;
	lst
      end
    else
      let byte = BatIO.read_signed_byte ic in
        get_rand_bytes_aux (pred num_bytes) (byte :: lst)
  in
    get_rand_bytes_aux num_bytes []
  
