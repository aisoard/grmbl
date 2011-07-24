.PHONY: all clean reset

lexer: lexer.ll
	flex lexer.ll

all: lexer

clean:
	@rm -v -f *~ lex.yy.c

reset: clean
