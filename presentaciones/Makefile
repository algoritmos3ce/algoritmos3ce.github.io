pdfs := $(foreach dir, $(wildcard clase*), $(dir)/$(dir).pdf)

all: $(pdfs)

%.pdf: %.typ defs.typ
	typst compile --root . $< $@

clase03/clase03-presentar.pdf: clase03/clase03.typ defs.typ
	typst compile --root . --input presentar=1 $< $@
