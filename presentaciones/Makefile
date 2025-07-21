pdfs := $(foreach dir, $(wildcard clase*), $(dir)/$(dir).pdf)

all: $(pdfs)

%.pdf: %.typ defs.typ
	typst compile --root . $<
