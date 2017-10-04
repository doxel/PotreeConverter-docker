all: build
	$(MAKE) -C bin

build:
	./build.sh

install:
	$(MAKE) -C bin install

uninstall:
	$(MAKE) -C bin uninstall

.PHONY: all build install uninstall
