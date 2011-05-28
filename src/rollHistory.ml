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
