all: clean program

interfaces:
	ocamlc -c randomPool.mli diceRoller.mli rollHistory.mli

program: interfaces
	ocamlyacc DiceParser.mly
	ocamlc -c DiceParser.mli
	ocamllex DiceLexer.mll
	ocamlfind ocamlopt -o diceroller -linkpkg -package pcre,unix,netclient,batteries randomPool.ml diceRoller.ml rollHistory.ml DiceLexer.ml DiceParser.ml diceroller.ml 

clean: clean_parser
	rm -f *.o *.cmo *.cmx *.cmi DiceParser.ml DiceLexer.ml diceroller *~

clean_parser:
	rm -f DiceParser.mli