%{
	open Definitions
%}

%token <string> IDENTIFIER
%token START_TYPE END_TYPE
%token START_TOKEN END_TOKEN
%token START_BLOCK END_BLOCK
%token IMPORT FROM
%token INPUTS OUTPUTS
%token CONNEXION TO END

%nonassoc CONNEXION TO END
%nonassoc INPUTS OUTPUTS
%nonassoc IMPORT FROM
%nonassoc START_BLOCK END_BLOCK
%nonassoc START_TOKEN END_TOKEN
%nonassoc START_TYPE END_TYPE
%nonassoc IDENTIFIER

%start program
%type <Definitions.abstract-syntax-tree> program

%%
program: dependencies blocks { $1,$2 };

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
	INPUTS typed-identifiers END
	OUTPUTS typed-identifiers END
	BLOCKS typed-identifiers END
	connexions
	END_BLOCK
	{ $2, $5, $8, $10 }
;

typed-identifiers:
	| IDENTIFIER START_TYPE IDENTIFIER END_TYPE typed-identifiers { ($1,$3)::$5 }
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

tokens:
	| IDENTIFIER TO tokens { $1::$3 }
	|                      { [] }
;
%%
