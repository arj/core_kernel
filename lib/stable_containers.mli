(** The Stable versions of Hashtbl, Hash_set, Map, and Set are defined here rather than in
    their respective modules because:

    1. We guarantee their serializations independent of the implementation of those modules
    2. Given 1. it is cleaner (and still okay) to separate the code into a separate file *)

open Std

module Comparable : sig
  module V1 : sig
    module type S = sig
      type key
      type comparator_witness

      module Map : sig
        type 'a t = (key, 'a, comparator_witness) Map.t with sexp, bin_io, compare
      end

      module Set : sig
        type t = (key, comparator_witness) Set.t with sexp, bin_io, compare
      end
    end

    module Make (
      Key : sig
        type t with bin_io, sexp
        include Comparator.S with type t := t
      end
    ) : S with type key := Key.t and type comparator_witness := Key.comparator_witness
  end
end

module Hashable : sig
  module V1 : sig
    module type S = sig
      type key

      module Table : sig
        type 'a t = (key, 'a) Hashtbl.t with sexp, bin_io
      end

      module Hash_set : sig
        type t = key Hash_set.t with sexp, bin_io
      end
    end

    module Make (Key : Hashtbl.Key_binable) : S with type key := Key.t
  end
end
