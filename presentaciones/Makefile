pdfs := $(foreach dir, $(wildcard clase*), $(dir)/$(dir).pdf)

all: $(pdfs)

%.pdf: %.typ defs.typ
	typst query --root . --input prequery-fallback=true --field value $< '<web-resource>' | python3 download-web-resources.py $(<D)
	typst compile --root . $<
