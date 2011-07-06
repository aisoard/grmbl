{
	open Definitions
	open Parser
}

let blank = [' ' '\t' '\r' '\n']

let identifier = ['a'-'z']
	| ['a'-'z']['a'-'z' '-']*['a'-'z']

let character = [^'"' '\\']
	| '\\' ['"' '\\' 'n' 'b' 'r' 't' 'v']
	| '\\' ['0'-'9' 'A'-'F']['0'-'9' 'A'-'F']

rule token = parse
	(* Blocks *)
	| '('       { START_TYPE  }
	| ')'       { END_TYPE    }
	| '['       { START_TOKEN }
	| ']'       { END_TOKEN   }
	| '{'       { START_BLOCK }
	| '}'       { END_BLOCK   }

	(* Keywords *)
	| "import"    { IMPORT    }
	| "from"      { FROM      }
	| "inputs"    { INPUTS    }
	| "outputs"   { OUTPUTS   }
	| "blocks"    { BLOCKS    }
	| "connexion" { CONNEXION }
	| "->"        { TO        }
	| "."         { DOT       }
	| ";"         { END       }

	(* Identifier *)
	| identifier as id     { IDENTIFIER id      }

	(* Characters *)
	| character* as s { STRING s }

	(* Special *)
	| blank+              { token lexbuf                  }
	| "(*"                { comment lexbuf ; token lexbuf }
	| "*)"                { raise (Comment_mismatch)      }
	| eof                 { EOF                           }
	| (_ # blank)* as bug { raise (Unrecognized bug)      }

and comment = shortest
	(* Comments *)
	| _* "(*"   { comment lexbuf ; comment lexbuf }
	| _* "*)"   { ()                              }
	| _* eof    { raise (Comment_mismatch)        }
