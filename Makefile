all: .tested

.tested: $(shell find src tests -type f -name '*.elm' -o -name '*.js')
	$(MAKE) -C tests
	touch $@
