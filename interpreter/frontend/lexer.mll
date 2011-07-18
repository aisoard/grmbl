{
	open Definitions
	open Parser
}

(* Blank/Ignored characters *)
let blank = [' ' '\t' '\r' '\n']

(* Identifiers *)
let identifier = ['a'-'z']
	| ['a'-'z']['a'-'z' '-']*['a'-'z']

(* Characters for string *)
let character = [^'"' '\\']
	| '\\' ['"' '\\' 'n' 'b' 'r' 't' 'v']
	| '\\' ['0'-'9' 'A'-'F']['0'-'9' 'A'-'F']

rule token = parse
	(* Blocks *)
	| '('       { START_TYPE  }
	| ')'       { END_TYPE    }
	| '{'       { START_BLOCK }
	| '}'       { END_BLOCK   }

	(* Keywords *)
	| "import"    { IMPORT    }
	| "from"      { FROM      }
	| "inputs"    { INPUTS    }
	| "outputs"   { OUTPUTS   }
	| "blocks"    { BLOCKS    }
	| "connexion" { CONNEXION }
	| ":"         { OF }
	| "--"        { THROUGH   }
	| "->"        { TO        }
	| "."         { DOT       }
	| ";"         { END       }

	(* Identifier *)
	| identifier as id { IDENTIFIER id }

	(* Characters *)
	| '"' (character* as s) '"' { STRING s }

	(* Special *)
	| blank+              { token lexbuf }
	| "#" [^'\n']         { token lexbuf }
	| eof                 { EOF          }
