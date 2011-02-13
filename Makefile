all: clean program

interfaces:
	ocamlc -c randomPool.mli diceRoller.mli rollHistory.mli

program: interfaces
	ocamlyacc diceParser.mly
	ocamlc -c diceParser.mli
	ocamllex diceLexer.mll
	ocamlfind ocamlopt -o diceroller -linkpkg -package pcre,unix,netclient,batteries randomPool.ml diceRoller.ml rollHistory.ml diceLexer.ml diceParser.ml diceroller.ml 

clean: clean_parser
	rm -f *.o *.cmo *.cmx *.cmi DiceParser.ml DiceLexer.ml diceroller *~

clean_parser:
	rm -f DiceParser.mli