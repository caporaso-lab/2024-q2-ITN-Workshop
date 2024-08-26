default: serve_full

clean:
	jb clean book/ --all

build_full: clean
	jb build book/ --all

serve_full: build_full
	cd book/_build/html && python -m http.server && cd -

preview: build_preview

build_preview:
	Q2DOC_NO_EXEC=1 jb build book/

serve_preview: build_preview
	cd book/_build/html && python -m http.server && cd -
