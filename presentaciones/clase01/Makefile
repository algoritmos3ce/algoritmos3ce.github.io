all: build

build: download-images
	typst compile clase01.typ

download-images:
	typst query --input prequery-fallback=true --field value clase01.typ '<web-resource>' | python3 download-web-resources.py
