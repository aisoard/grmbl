%{
	open Definitions
%}

%token <string> IDENTIFIER STRING
%token START_TYPE END_TYPE
%token START_TOKEN END_TOKEN
%token START_BLOCK END_BLOCK
%token IMPORT FROM
%token INPUTS OUTPUTS BLOCKS
%token CONNEXION TO DOT END
%token EOF

%nonassoc EOF
%nonassoc CONNEXION TO DOT END
%nonassoc INPUTS OUTPUTS
%nonassoc IMPORT FROM
%nonassoc START_BLOCK END_BLOCK
%nonassoc START_TOKEN END_TOKEN
%nonassoc START_TYPE END_TYPE
%nonassoc IDENTIFIER

%start program
%type <Definitions.ast> program

%%
program: dependencies blocks EOF { $1,$2 };

dependencies:
	| dependency dependencies { $1::$2 }
	|                         { [] }
;

dependency: IMPORT identifiers FROM STRING END { $2,$4 };

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
	INPUTS typed_identifiers END
	OUTPUTS typed_identifiers END
	BLOCKS typed_identifiers END
	connexions
	END_BLOCK
	{ $1, $4, $7, $10, $12 }
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
	| CONNEXION port TO port END        { $2,[],$4 }
	| CONNEXION port TO tokens port END { $2,$4,$5 }
;

port:
	| IDENTIFIER DOT IDENTIFIER { $1,$3 }
;

tokens:
	| IDENTIFIER TO tokens { $1::$3 }
	|                      { [] }
;
%%
