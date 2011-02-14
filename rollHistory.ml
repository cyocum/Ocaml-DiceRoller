type roll = {
  roll_lst : int list;
  total : int
}

let add roll_hist lst total =
  let last = [{ roll_lst = lst; total = total }] in
    match roll_hist with
      | [] -> last
      | xs -> BatList.append xs last

let get_hist roll_hist num =
  BatList.at roll_hist (num - 1)

let print_roll roll = 
  DiceRoller.print_diceroll roll.roll_lst
