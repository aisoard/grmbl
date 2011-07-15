open Definitions

(* Parameters *)
let parameters = {
	input_file = stdin;
	verbose = false;
	optimize = true;
};;

let set_input_file file_name = parameters.input_file <- (open_in file_name);;
let set_verbose verbose = parameters.verbose <- verbose;;
let set_optimize optimize = parameters.optimize <- optimize;;

let options = [
	"-i", Arg.String set_input_file, "Set input file name";
	"--debug", Arg.Bool set_verbose, "Print a lot of information [default: false]";
	"--optimize", Arg.Bool set_optimize, "Enable optimizations [default: true]";
];;

let parse_arguments =
	Arg.parse options ignore (Sys.argv.(0) ^ " [-i <filename.grmbl>] [--debug (true|false)] [--optimize (true|false)]");
	parameters
;;
