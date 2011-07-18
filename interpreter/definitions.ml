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
   mutable verbose : bool;
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
