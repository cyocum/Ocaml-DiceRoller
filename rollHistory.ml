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
  let my_num = num - 1 in
  BatList.at roll_hist my_num

let print_roll roll = 
  DiceRoller.print_diceroll roll.roll_lst
