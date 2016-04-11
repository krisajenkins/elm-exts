all: tests.js

tests.js: FORCE $(shell find src test -type f -name '*.elm' -o -name '*.js')
	elm-make --yes --warn
	elm-make test/Main.elm --yes --warn --output=$@
	echo "var worker = Elm.worker(Elm.Main);" >> $@
	node $@

FORCE:
