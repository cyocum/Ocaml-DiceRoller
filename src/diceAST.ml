type t =
  | Nil
  | Roll of (int * int)
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t

let rec eval = function
  | Roll(num, sides) -> (DiceRoller.roll num sides)
  | Add(lhs, rhs) -> DiceRoller.add_roll (eval lhs) (eval rhs)
  | Sub(lhs, rhs) -> DiceRoller.sub_roll (eval lhs) (eval rhs)
  | Mul(lhs, rhs) -> DiceRoller.mul_roll (eval lhs) (eval rhs)
  | Div(lhs, rhs) -> DiceRoller.div_roll (eval lhs) (eval rhs)
  | Nil -> DiceRoller.roll 0 1

let eval_lst lst =
  List.rev_map eval lst









