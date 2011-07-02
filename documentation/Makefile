.PHONY: user-manual developer-manual clean reset

all: user-manual developer-manual

user-manual:
	@make -C user-manual

developer-manual:
	@make -C developer-manual

clean:
	@rm -v -f *~
	@make -C user-manual clean
	@make -C developer-manual clean

reset: clean
	@make -C user-manual reset
	@make -C developer-manual reset
