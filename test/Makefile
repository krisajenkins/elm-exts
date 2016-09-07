all: tests.js

tests.js: FORCE
	elm-make Test.elm --yes --warn --output=$@
	@node $@

FORCE:
