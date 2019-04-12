open Base

(* this approach is inefficient and could be faster with a hashmap *)
   
type t = (string * int) list

type median = | Median of string
              | Before_and_after of string * string

let empty = []

let to_list x = x
              
let touch counts line =
  let count =
        match List.Assoc.find ~equal:String.equal counts line with
        | None -> 0
        | Some x -> x
      in
      List.Assoc.add ~equal:String.equal counts line (count + 1)

