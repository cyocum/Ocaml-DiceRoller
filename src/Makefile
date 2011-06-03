interfaces:
	ocamlc -c randomPool.mli diceRoller.mli

program: interfaces
	ocamlyacc diceParser.mly
	ocamlc -c diceParser.mli
	ocamllex diceLexer.mll
	ocamlfind ocamlopt -o diceroller -linkpkg -package pcre,unix,netclient,batteries randomPool.ml diceRoller.ml diceLexer.ml diceParser.ml diceroller.ml 

clean: clean_parser
	rm -f *.o *.cmo *.cmx *.cmi diceParser.ml diceLexer.ml diceroller *~

clean_parser:
	rm -f diceParser.mli
