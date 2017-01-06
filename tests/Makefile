all: FORCE

FORCE: $(shell find . -type f -name '*.elm' -o -name '*.js')
	elm-make Main.elm --yes --warn --output=/dev/null
	( cd .. ; elm test )
