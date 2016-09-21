type t = Pkcs11_CK_BYTE.t
let typ = Pkcs11_CK_BYTE.typ

let _CK_FALSE = Pkcs11_CK_BYTE.zero
let _CK_TRUE = Pkcs11_CK_BYTE.one

let of_int x = if x = 0 then _CK_FALSE else _CK_TRUE
