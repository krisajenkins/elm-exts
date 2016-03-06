all: build/.tested 

build:
	@mkdir $@

build/.tested: build/tests.js build
	node $<

build/tests.js: build/raw-test.js build
	sh elm-stuff/packages/laszlopandy/elm-console/1.1.0/elm-io.sh $< $@

build/raw-test.js: $(shell find src test -type f -name '*.elm' -o -name '*.js') build
	elm-make --yes --warn
	elm-make test/Main.elm --yes --warn --output=$@
