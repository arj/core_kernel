(** various combinators for functions *)

(** A 'pipe' operator. Deprecated. *)
external ( |! ) : 'a -> ( 'a -> 'b) -> 'b = "%revapply"

(** A pipe operator, equivalent to |!, but this notation is more broadly accepted *)
external ( |> ) : 'a -> ( 'a -> 'b) -> 'b = "%revapply"

(** produces a function that just returns its first argument *)
val const : 'a -> _ -> 'a

(**
 * [ignore] is the same as [Pervasives.ignore].  It is useful to have here so
 * that code that rebinds [ignore] can still refer to [Fn.ignore].
 *)
external ignore : _ -> unit = "%ignore"

(** Negates a function *)
val non : ('a -> bool) -> 'a -> bool

(** [forever f] runs [f ()] until it throws an exception and returns the
    exception. This function is useful for read_line loops, etc. *)
val forever : (unit -> unit) -> exn

(** [apply_n_times ~n f x] is the [n]-fold application of [f] to [x]. *)
val apply_n_times : n:int -> ('a -> 'a) -> ('a -> 'a)

(** The identity function*)
external id : 'a -> 'a = "%identity"

(** [compose f g x] is [f (g x)] *)
val compose : ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c)

(** reverse the order of arguments for a binary function *)
val flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c)

(** Transform a function that takes a pair as an argument into
    a binary function. Inverse of [uncurry]. *)
val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c

(** Transform a binary function into a unary function taking a pair
    as argument. Inverse of [curry]. *)
val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c

(** Transform a function that takes a three-tuple as an argument into
    a ternary function. Inverse of [uncurry3]. *)
val curry3 : ('a * 'b * 'c -> 'd) -> 'a -> 'b -> 'c -> 'd

(** Transform a ternary function into a unary function taking a three-tuple
    as argument. Inverse of [curry3]. *)
val uncurry3 : ('a -> 'b -> 'c -> 'd) -> 'a * 'b * 'c -> 'd
