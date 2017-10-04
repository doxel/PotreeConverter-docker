PREFIX ?= /usr/local
SHELL := /bin/bash

all: clean build

clean:
	find . -maxdepth 1 -type l -exec rm \{} \;

build:
	ln -sf docker-potreeConverter PotreeConverter

install:
	find -maxdepth 1 -name 'docker-potreeConverter' -o -type l -exec install \{} ${PREFIX}/bin/\{} \;

uninstall:
	find -maxdepth 1 -name 'docker-potreeConverter' -o type l -exec rm ${PREFIX}/bin/\{} \;

.PHONY: all clean build install uninstall
