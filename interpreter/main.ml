let _ = print_endline "Grmbl !";;
let _ = Cli.parse_arguments;;
let _ = Parser.program Lexer.token (Lexing.from_channel stdin);;
