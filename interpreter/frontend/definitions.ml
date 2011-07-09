(* Lexing error *)
exception Comment_mismatch;;
exception Unrecognized of string;;

(* Parsing error *)
exception Pipe_mismatch;;
exception Vector_mismatch;;
exception Block_mismatch;;
exception Expecting of string;;

(* Type check *)
exception Uncompatible_type;;

(* CLI params *)
type params = {
   mutable input_file : in_channel;
   mutable output_file : out_channel;
   mutable color : bool;
   mutable print_ast : bool;
   mutable optimize : bool;
}
;;

(* string indexed map, for identifiers context *)
module Strmap = Map.Make (String);;

(*** types ***)
(* syntax_tree *)
type ast_object = string;;
type ast_type = string;;
type ast_include = ast_object list * string;;

type ast_typed_object = ast_object * ast_type;;
type ast_port = ast_object * ast_object;;
type ast_connexion = ast_port * ast_object list * ast_port;;
type ast_connexions = ast_connexion list;;
type ast_block = ast_object * ast_typed_object list * ast_typed_object list * ast_typed_object list * ast_connexion list;;

type ast = ast_include list * ast_block list;;

(* type system *)
type type_t =
   | Var of int
   | Constr of type_constr_t * type_t list
and type_constr_t =
   | TUnit
   | TBool
   | TInt
   | TChar
   | TString
   | TTuple
   | TList
   | TFunc
   | TRef
;;

(* constraint list *)
type constraint_t = (type_t * type_t) list;;

(* syntax_tree - typed *)
type ast_typed_t = ast_typed_struct_t * type_t
and ast_typed_struct_t =
   (* let rec lists *)
   | ATLet of bool * (ast_typed_t * ast_typed_t) list * ast_typed_t
   (* pattern *)
   | ATTuple of ast_typed_t list
   (* ctrl structs *)
   | ATIf of ast_typed_t * ast_typed_t * ast_typed_t
   | ATWhile of ast_typed_t * ast_typed_t
   | ATFor_inc of string * ast_typed_t * ast_typed_t * ast_typed_t 
   | ATFor_dec of string * ast_typed_t * ast_typed_t * ast_typed_t
   | ATSequence of ast_typed_t * ast_typed_t
   (* pattern matching *)
   | ATFunction of ast_typed_t list
   | ATApply of ast_typed_t * ast_typed_t
   | ATPattern of ast_typed_t * ast_typed_t * ast_typed_t
   (* const *)
   | ATConstructor of ast_typed_t * ast_typed_t
   | ATUnit 
   | ATInt of int
   | ATChar of char
   | ATString of string
   | ATBool of bool
   (* identifiers *)
   | ATUnderscore 
   | ATEmpty_list
   | ATIdent of string
;;

(* primitives *)
type primitive_t =
   (* misc *)
   | PExit
   (* print *)
   | PPrint_int
   | PPrint_newline
   (* read *)
   | PRead_int
   (* arith *)
   | PAdd_int
   | PSub_int
   | PNeg_int
   | PMul_int
   | PDiv_int
   | PSucc_int
   | PPred_int
   (* generic *)
   | PIs_equal
   | PIs_diff
   | PIs_gt
   | PIs_ge
   | PIs_lt
   | PIs_le
   (* bool *)
   | PNot_bool
   | PAnd_bool
   | POr_bool
   (* ref *)
   | PMake_ref
   | PAccess_ref
   | PAssign_ref
   (* tuple *)
   | PMake_tuple of int
   | PGet_tuple of int
   (* list *)
   | PCons_list
   (* matching *)
   | PMatch_bool
   | PMatch_list
   | PMatch_tuple of int
;;

(* constructors *)
type construct_t =
   | PUnit
   | PNil_list
   | PBool of bool
   | PChar of char
   | PInt of int
   | PString of string
;;

(* syntax_tree − bruijn tree *)
type bruijn_t = bruijn_struct_t ref
and bruijn_struct_t =
   | BVar of int
   | BLambda of bruijn_t
   | BMu of bruijn_t list
   | BApply of bruijn_t * bruijn_t
   | BPrim of primitive_t * bruijn_t list
   | BConstr of construct_t
;;

(* code tree *)
type code_t = code_tree_t list
and code_tree_t =
   (* lambda calculus *)
   | CAccess of int
   | CClosure of code_t
   | CApply of bool
   | CRet of int
   (* opt *)
   | CPop
   | CTail_apply of bool * int
   (* rec *)
   | CSet of int
   | CPush_env of int
   (* code struct *)
   | CMatch_bool of code_t * code_t
   | CMatch_list of code_t * code_t
   | CMatch_tuple of int * code_t
   (* prim *)
   | CPrim of primitive_t
   (* const *)
   | CConstr of construct_t
;;

