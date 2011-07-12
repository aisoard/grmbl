.PHONY: all clean reset native

build_tool_base=ocamlbuild
build_dir=build

# list of dir
dir_list=frontend runtime

dir_options=$(foreach dir, $(dir_list), -I $(dir))

build_tool=$(build_tool_base) \
			 -classic-display \
			 $(dir_options) \
#			 -build-dir $(build_dir)

target=native

all:
	$(build_tool) main.$(target)
	
clean:
	@$(build_tool) -clean
	@rm -vf *~

reset: clean
