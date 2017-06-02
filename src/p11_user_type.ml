type t =
  | CKU_SO
  | CKU_USER
  | CKU_CONTEXT_SPECIFIC
  | CKU_CS_UNKNOWN of Pkcs11_CK_ULONG.t
[@@deriving eq,ord]

let to_string =
  function
  | CKU_SO  -> "CKU_SO"
  | CKU_USER  -> "CKU_USER"
  | CKU_CONTEXT_SPECIFIC  -> "CKU_CONTEXT_SPECIFIC"
  | CKU_CS_UNKNOWN x -> Unsigned.ULong.to_string x

let of_string =
  function
  | "CKU_SO" -> CKU_SO
  | "CKU_USER" -> CKU_USER
  | "CKU_CONTEXT_SPECIFIC" -> CKU_CONTEXT_SPECIFIC
  | x -> (
      try
        CKU_CS_UNKNOWN (Unsigned.ULong.of_string x)
      with
      | Sys.Break as e ->
        raise e
      | _ ->
        invalid_arg ("Pkcs11_CK_USER_TYPE.of_string: cannot find " ^ x)
    )

let to_yojson user_type =
  `String (to_string user_type)

let of_yojson = Pkcs11_helpers.of_json_string ~typename:"user type" of_string
