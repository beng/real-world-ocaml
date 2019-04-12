#require "base";;
open Base;;


let x = 3;;
let y = 4;;
let z = x + y;;

(*
 * variables
 *)
let languages = "OCaml,Perl,C++,C";;
let dashed_languages =
  let languages = String.split languages ~on:',' in
  String.concat ~sep:"-" languages
;;

let area_of_ring inner_radius outer_radius =
  let pi = Float.pi in
  let area_of_circle r = pi *. r *. r in
  area_of_circle outer_radius -. area_of_circle inner_radius
;;

area_of_ring 1. 3.;;

(*
 * pattern matching and let
 *)
let (ints,strings) = List.unzip [(1,"one"); (2, "two"); (3, "three")];;

let upcase_first_entry_line line =
  match String.split ~on:',' line with
  (* string.split returns at least one element and assert marks this case as impossible*)
  | [] -> assert false
  | first :: rest -> String.concat ~sep:"," (String.uppercase first :: rest)
;;

upcase_first_entry_line "one, two, three";;


(*
 * section: functions / anonymous functions
 *)
 
(fun x -> x + 1) 9;;

List.map ~f:(fun x-> x + 1) [1; 2; 3];;

let transforms = [String.uppercase; String.lowercase];;
List.map ~f:(fun g -> g "HeLlO WoRlD") transforms;;

let inc = (fun x -> x + 1);;
inc 1;;

let inc_ x = x + 1;;
inc_ 1;;

(* section:
 * multiargument functions -- curring and partials
 *)

let abs_diff x y = abs (x - y);;
let dist_from_3 = abs_diff 3;;
dist_from_3 8;;
let dist_from_x x = abs_diff x;;
dist_from_x 3 8;;

let abs_diff_2 = (fun x y -> abs (x - y));;

(* recursive functions *)
let rec find_first_repeat elements =
  match elements with
  | [] | [_] -> None
  | x :: y :: tail ->
     if x = y then Some x else find_first_repeat (y::tail)
;;

find_first_repeat([1;2;2;2;2;3]);;

(* section:
 *   prefix and infix operators
 *)
           
(* override the + operator to make it sum vectors *)
let (+!) (x1, y1) (x2, y2) = (x1 + x2, y1 + y2);;
(3, 2) +! (-2, 4);;
(+!) (3, 2) (-2, 4);;

let (+&) (x1, y1) (x2, y2) = (x1 + x2, y1 + y2);;

(*
 * take a value and a function and apply the func to value
 * acts in a similar way to unix pipe
 *)
let (|>) x f = f x;;

(*
 * given a fake PATH, sort and remove duplicates
 * using `|>`
 *)
open Stdio;;
let path = "/usr/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/bin";;
String.split ~on: ':' path
|> List.dedup_and_sort ~compare: String.compare
|> List.iter ~f: print_endline
;;

(*
 * without using |>, the above can be done more verbosely via:
 *)
let split_path = String.split ~on: ':' path in
    let deduped_path = List.dedup_and_sort ~compare: String.compare split_path in
    List.iter ~f: print_endline deduped_path
;;

(* the 2 stmts below are equivalent *)
let some_or_zero = function
  | Some x -> x
  | None -> 0
;;

let some_or_z num_opt =
  match num_opt with
  | Some x -> x
  | None -> 0
;;

let x = List.map ~f: some_or_zero [Some 3; None];;
let y = List.map ~f: some_or_z [Some 3; None];;

(* let some_or_default_val default_val = function
 *   | Some x y -> x + y
 *   | None -> default_val
 * ;;
 * 
 * some_or_default_val 5 (None);;
 * some_or_default_val 5 ((Some 3) (Some 4));; *)

(* optional arugments *)

(* boiler plate code to define sep when its not provided *)
let concat ?sep v1 v2 =
  let sep = match sep with
  | None -> ""
  | Some v1 -> v1 in v1 ^ sep ^ v2
;;
concat "foo" "bar";;
concat ~sep: "\t" "foo" "bar";;

(* how to set default arg without above boiler plate *)
let concat ?(sep="") v1 v2 =
  v1 ^ sep ^ v2
;;

concat "foo" "bar";;
concat ~sep: "      " "foo" "bar";;
