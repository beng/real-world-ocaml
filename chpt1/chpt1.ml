open Base;;
#require "core";;
open Core;;

let mul x y = x * y;;
mul 2 4;;

(* let ratio x y =
 *   Float.of_int x /. Float.of_int y
 * ;;
 * ratio 4 7;; *)
let ratio x y =
  let open Float.O in
  of_int x / of_int y;;

(* return sum integers passed in *)
let sum_if_true test first second =
  (if test first then first else 0)
  + (if test second then second else 0)
;;

let even x =
  x mod 2 = 0
;;

let inc x =
  x + 1
;;



let first_if_true test x y =
  if test x then x else y
;;


let long_string s = String.length s > 6;;
long_string "aaaaaaaaa";;
first_if_true long_string "ben" "bennnnnnnn";;
first_if_true even 5 2;;



let languages = ["a"; "b"; "c"];;

List.length languages;;

List.map languages ~f:String.length;;

"Ben" :: "Ben G" :: languages;;

1 :: 2 :: 3 :: [];;

[1;2;3] :: [4;5] :: [];;

[1;3] @ [4;5];;

let fav_langs langs =
  match langs with
  | head :: tail -> head
  | [] -> "no langs provided"
;;

let rec sum l =
  match l with
  (* base case *)
  | [] -> 0
  (* inductive case *)
  | head :: tail -> head + sum tail
;;

sum [1; 2];;

let rec remove_seq_dups list =
  match list with
  | [] -> []
  | [hd] -> [hd]
  | hd1 :: hd2 :: tl ->
     if hd1 = hd2 then remove_seq_dups (hd2 :: tl)
     else hd1 :: remove_seq_dups (hd2 :: tl)
;;

remove_seq_dups [1;1;2;3;3;4;1;1;1;];;

let divide x y =
  if y = 0 then None else Some (x /y )
;;


(* let downcase_ext filename =
 *   match String.rsplit2 filename ~on: '.' with
 *   | None -> filename
 *   | Some (base, ext) ->
 *      base ^ "." ^ String.lowercase ext
 * ;;
 * 
 * List.map ~f: downcase_ext ["hell.TXT"; "help.CSV"; "hell.teXt"];; *)

let log_entry maybe_time message =
  let time =
    match maybe_time with
    | Some x -> x
    | None -> Time.now ()
  in
  core.std.Time.to_sec_string time ^" -- " ^ message
;;
