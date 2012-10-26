interfaces:
	ocp-ocamlc -c randomPool.mli diceRoller.mli diceAST.mli emergencyRandom.mli

program: interfaces
	ocamlyacc diceParser.mly
	ocp-ocamlc -c diceParser.mli
	ocamllex diceLexer.mll
	ocamlfind -toolchain typerex ocamlopt -o diceroller -linkpkg -package pcre,unix,netclient,batteries emergencyRandom.ml randomPool.ml diceRoller.ml diceLexer.ml diceParser.ml diceAST.ml diceroller.ml 

clean: clean_parser
	rm -f *.o *.cmo *.cmx *.cmi diceParser.ml diceLexer.ml diceroller *~

clean_parser:
	rm -f diceParser.mli
