all: tests.js

tests.js: FORCE $(shell find src tests -type f -name '*.elm' -o -name '*.js')
	elm-make --yes --warn
	elm test

FORCE:
