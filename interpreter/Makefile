.PHONY: all clean reset native

BUILDTOOL=ocamlbuild

all: native

native:
	$(BUILDTOOL).$@ main.$@
	
clean:
	@$(BUILDTOOL) -clean
	@rm -vf *~

reset: clean
