# Makefile for development use

VERSION := $(shell sed -n 3p DESCRIPTION | sed 's/Version: //' | cat)
BINARY := dgodata_$(VERSION).tar.gz

all: build check install 

build: 
	R --no-site-file --no-environ  \
	  --no-save --no-restore --quiet CMD build .  \
	  --no-resave-data --no-manual

check: 
	R CMD check dgodata_$(VERSION).tar.gz

check-cran: 
	R CMD check --as-cran dgodata_$(VERSION).tar.gz

install: dgodata_$(VERSION).tar.gz
	R CMD INSTALL --no-multiarch --with-keep.source dgodata_$(VERSION).tar.gz

