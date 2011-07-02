.PHONY: all interpreter compiler tests documentation clean reset

all: interpreter compiler tests

interpreter:
	@make -C interpreter

compiler: interpreter
	@make -C compiler

tests: compiler
	@make -C tests

documentation:
	@make -C documentation

clean:
	@rm -v -f *~
	@make -C interpreter clean
	@make -C compiler clean
	@make -C tests clean
	@make -C documentation clean

reset: clean
	@make -C interpreter reset
	@make -C compiler reset
	@make -C tests reset
	@make -C documentation reset

