.PHONY: all clean reset native

build_tool=ocamlbuild

build_options=-classic-display
#build_options+=-build-dir build
#build_options+=-install-bin-dir bin
#build_options+=-install-lib-dir lib

build_options+=-Is interface,frontend

target=main.native

all:
	$(build_tool) $(build_options) $(target)
	
clean:
	@rm -vf *~

reset: clean
	$(build_tool) $(build_options) -clean
