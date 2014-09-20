print_endline "Grmbl !";;
Cli.parse_arguments;;
Parser.program Lexer.token (Lexing.from_channel stdin);;
