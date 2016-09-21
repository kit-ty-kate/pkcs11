type t = Pkcs11_CK_ULONG.t

type u =
  | CKO_DATA
  | CKO_CERTIFICATE
  | CKO_PUBLIC_KEY
  | CKO_PRIVATE_KEY
  | CKO_SECRET_KEY
  | CKO_HW_FEATURE
  | CKO_DOMAIN_PARAMETERS
  | CKO_MECHANISM
  | CKO_OTP_KEY
  | CKO_VENDOR_DEFINED

  (* This is a catch-all case that makes it possible to deal with
     vendor-specific/non-standard CKO. *)
  | CKO_CS_UNKNOWN of Unsigned.ULong.t

let typ = Ctypes.ulong

let with_value x = Unsigned.ULong.of_string @@ Int64.to_string x

let _CKO_DATA              = with_value 0x00000000L
let _CKO_CERTIFICATE       = with_value 0x00000001L
let _CKO_PUBLIC_KEY        = with_value 0x00000002L
let _CKO_PRIVATE_KEY       = with_value 0x00000003L
let _CKO_SECRET_KEY        = with_value 0x00000004L
let _CKO_HW_FEATURE        = with_value 0x00000005L
let _CKO_DOMAIN_PARAMETERS = with_value 0x00000006L
let _CKO_MECHANISM         = with_value 0x00000007L
let _CKO_OTP_KEY           = with_value 0x00000008L
let _CKO_VENDOR_DEFINED    = with_value 0x80000000L


let make u =
  match u with
    | CKO_DATA  -> _CKO_DATA
    | CKO_CERTIFICATE  -> _CKO_CERTIFICATE
    | CKO_PUBLIC_KEY  -> _CKO_PUBLIC_KEY
    | CKO_PRIVATE_KEY  -> _CKO_PRIVATE_KEY
    | CKO_SECRET_KEY  -> _CKO_SECRET_KEY
    | CKO_HW_FEATURE  -> _CKO_HW_FEATURE
    | CKO_DOMAIN_PARAMETERS  -> _CKO_DOMAIN_PARAMETERS
    | CKO_MECHANISM  -> _CKO_MECHANISM
    | CKO_OTP_KEY  -> _CKO_OTP_KEY
    | CKO_VENDOR_DEFINED  -> _CKO_VENDOR_DEFINED
    | CKO_CS_UNKNOWN x -> x

let view t =
  let is value = Unsigned.ULong.compare t value = 0 in
  match () with
    | _ when is _CKO_DATA -> CKO_DATA
    | _ when is _CKO_CERTIFICATE -> CKO_CERTIFICATE
    | _ when is _CKO_PUBLIC_KEY -> CKO_PUBLIC_KEY
    | _ when is _CKO_PRIVATE_KEY -> CKO_PRIVATE_KEY
    | _ when is _CKO_SECRET_KEY -> CKO_SECRET_KEY
    | _ when is _CKO_HW_FEATURE -> CKO_HW_FEATURE
    | _ when is _CKO_DOMAIN_PARAMETERS -> CKO_DOMAIN_PARAMETERS
    | _ when is _CKO_MECHANISM -> CKO_MECHANISM
    | _ when is _CKO_OTP_KEY -> CKO_OTP_KEY
    | _ when is _CKO_VENDOR_DEFINED -> CKO_VENDOR_DEFINED
    | _ -> CKO_CS_UNKNOWN t

let to_string u =
  match u with
    | CKO_DATA  -> "CKO_DATA"
    | CKO_CERTIFICATE  -> "CKO_CERTIFICATE"
    | CKO_PUBLIC_KEY  -> "CKO_PUBLIC_KEY"
    | CKO_PRIVATE_KEY  -> "CKO_PRIVATE_KEY"
    | CKO_SECRET_KEY  -> "CKO_SECRET_KEY"
    | CKO_HW_FEATURE  -> "CKO_HW_FEATURE"
    | CKO_DOMAIN_PARAMETERS  -> "CKO_DOMAIN_PARAMETERS"
    | CKO_MECHANISM  -> "CKO_MECHANISM"
    | CKO_OTP_KEY  -> "CKO_OTP_KEY"
    | CKO_VENDOR_DEFINED  -> "CKO_VENDOR_DEFINED"
    | CKO_CS_UNKNOWN x -> Unsigned.ULong.to_string x

let of_string s =
  match s with
    | "CKO_DATA" -> CKO_DATA
    | "CKO_CERTIFICATE" -> CKO_CERTIFICATE
    | "CKO_PUBLIC_KEY" -> CKO_PUBLIC_KEY
    | "CKO_PRIVATE_KEY" -> CKO_PRIVATE_KEY
    | "CKO_SECRET_KEY" -> CKO_SECRET_KEY
    | "CKO_HW_FEATURE" -> CKO_HW_FEATURE
    | "CKO_DOMAIN_PARAMETERS" -> CKO_DOMAIN_PARAMETERS
    | "CKO_MECHANISM" -> CKO_MECHANISM
    | "CKO_OTP_KEY" -> CKO_OTP_KEY
    | "CKO_VENDOR_DEFINED" -> CKO_VENDOR_DEFINED
    | x ->
        (try CKO_CS_UNKNOWN (Unsigned.ULong.of_string x)
         with | Sys.Break  as e -> raise e
              | _ ->
                  invalid_arg
                    ("Pkcs11_CK_OBJECT_CLASS.of_string" ^ (": cannot find " ^ x)))

let equal (a : u) (b : u) = Pervasives.(=) a b
let compare (a : u) (b : u) = Pervasives.compare a b
