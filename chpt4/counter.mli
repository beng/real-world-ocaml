open Base

(** collection of string frequency counts *)
type t

(** empty set of frequency counts *)
val empty : t

(** bump the frequency count for the given string *)
val touch : t -> string -> t

(** converts the set of frequency counts to an association list.
a string shows up at most once, and the counts are >= 1 *)
val to_list : t -> (string * int) list
                     
(** median value computed from a set of strings. in the case where
    there is an even number of choises, the strings before and after
    the median is returned. *)
type median = | Median of string
              | Before_and_after of string * string

val median : t -> median                                               
