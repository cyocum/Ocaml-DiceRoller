type t =
  | Nil
  | Roll of (int * int)
  | Num of int
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
  | Command of (unit -> unit)

let rec eval = function
  | Roll(num, sides) -> (DiceRoller.roll num sides)
  | Add(lhs, rhs) -> DiceRoller.op_roll (+) (eval lhs) (eval rhs)
  | Sub(lhs, rhs) -> DiceRoller.op_roll (-) (eval lhs) (eval rhs)
  | Mul(lhs, rhs) -> DiceRoller.op_roll ( * ) (eval lhs) (eval rhs)
  | Div(lhs, rhs) -> DiceRoller.op_roll (/) (eval lhs) (eval rhs)
  | Command(f) -> f (); DiceRoller.nil_roll
  | Nil -> DiceRoller.nil_roll

let eval_lst lst =
  List.rev_map eval lst












