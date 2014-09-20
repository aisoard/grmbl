%{
	open Definitions
%}

%token <string> IDENTIFIER STRING
%token START_TYPE END_TYPE
%token START_TOKEN END_TOKEN
%token START_BLOCK END_BLOCK
%token IMPORT FROM
%token INPUTS OUTPUTS BLOCKS OF
%token CONNEXION THROUGH TO DOT END
%token EOF

%nonassoc EOF
%nonassoc CONNEXION TO DOT END
%nonassoc INPUTS OUTPUTS OF
%nonassoc IMPORT FROM
%nonassoc START_BLOCK END_BLOCK
%nonassoc START_TOKEN END_TOKEN
%nonassoc START_TYPE END_TYPE
%nonassoc IDENTIFIER STRING

%start program
%type <Definitions.ast> program

%%
program: dependencies blocks EOF { $1,$2 };

dependencies:
	| dependency dependencies { $1::$2 }
	|                         { [] }
;

dependency: IMPORT OF identifiers FROM STRING END { $3,$5 };

identifiers:
	| IDENTIFIER identifiers { $1::$2 }
	|                        { [] }
;

blocks:
	| block blocks { $1::$2 }
	|              { [] }
;

block:
	IDENTIFIER
	START_BLOCK
	INPUTS OF typed_identifiers END
	OUTPUTS OF typed_identifiers END
	BLOCKS OF typed_identifiers END
	connexions
	END_BLOCK
	{ $1, $5, $9, $13, $15 }
;

typed_identifiers:
	| IDENTIFIER START_TYPE IDENTIFIER END_TYPE typed_identifiers { ($1,$3)::$5 }
	|                                                             { [] }
;

connexions:
	| connexion connexions { $1::$2 }
	|                      { [] }
;

connexion:
	| CONNEXION OF port tokens TO port END { $3,$4,$6 }
;

port:
	| IDENTIFIER                { $1,"" }
	| IDENTIFIER DOT IDENTIFIER { $1,$3 }
;

tokens:
	| THROUGH IDENTIFIER tokens { $2::$3 }
	|                           { [] }
;
%%
