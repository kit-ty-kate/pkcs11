type t

type u =
  | CKD_NULL
  | CKD_SHA1_KDF
  [@@deriving yojson]

val make : u -> t
val view : t -> u

val t : t Ctypes.typ
