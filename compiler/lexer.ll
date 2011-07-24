%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	unsigned long int line_count = 0;
%}

digit		[0-9]
letter		[a-zA-Z]
lcase		[a-z]
ucase		[A-Z]
whitespace	[' ' '\t' '\r']
litt_whitespace	([' ']|['\\'][nbrtv])

%%
"("			return START_TYPE;
")"			return END_TYPE;
"["			return START_TOKEN;
"]"			return END_TOKEN;
"{"			return START_BLOCK;
"}"			return END_BLOCK;

"(*"			comment_parse();
"*)"			fprintf(stderr, "Unmatched closing comment at line %lu\n", line_count); exit(1);

import			return IMPORT;
from			return FROM;
inputs			return INPUTS;
outputs			return OUTPUTS;
blocks			return BLOCKS;
connexion		return CONNEXION;
:			return OF;
--			return THROUGH;
->			return TO;
"."			return DOT;
";"			return END;

['\n']			line_count++;
{whitespace}		/* Eat up white-spaces */

{lcase}				yylval=yytext; return IDENTIFIER;
{lcase}[a-z '_']*{lcase}	yylval=yytext; return IDENTIFIER;

['"']({litt_whitespace}|{letter}|{digit})+['"']		yylval=yytext; return STRING;
#([^ '"' '\\']|(['\\']['"' '\\' 'n' 'b' 'r' 't' 'v'])|(['\\'][0-9A-F][0-9A-F]))+		yylval=yytext; return STRING;
%%

int comment_parse()
{
	unsigned int comment_nesting = 1;
	while (comment_nesting != 0) {
		switch(input()) {
			case '\n': {
				line_count++;
				break;
			}
			case '*': {
				if (input() != ')') unput(yytext[yyleng-1]);
				else comment_nesting--;
				break;
			}
			case '(': {
				if (input() != '*') unput(yytext[yyleng-1]);
				else comment_nesting++;
				break;
			}
			case EOF: {
				fprintf(stderr, "Unclosed comment at line \%lu\n", line_count++);
				exit(1);
				break;
			}
			default: {
				{};
			}
		}
	}
	return 0;
}



