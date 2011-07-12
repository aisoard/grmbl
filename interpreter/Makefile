.PHONY: all clean reset native

build_tool=ocamlbuild
build_dir=build
build_include=interface,frontend

build_options=-classic-display -build-dir $(build_dir) -Is $(build_include)

target=main.native


all:
	$(build_tool) $(build_options) $(target)
	
clean:
	@rm -vf *~

reset: clean
	$(build_tool) $(build_options) -clean
