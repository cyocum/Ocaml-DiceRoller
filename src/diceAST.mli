type t = 
  | Nil
  | Roll of (int * int)
  | Num of int
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
  | Command of (unit -> unit)

val eval : t -> DiceRoller.r
val eval_lst : t list -> DiceRoller.r list




















