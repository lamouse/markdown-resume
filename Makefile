OUT_DIR=output
IN_DIR=markdown
STYLES_DIR=style
STYLE=base

all: html pdf

html: init
	for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.html; \
		pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
			--lua-filter=pdc-links-target-blank.lua \
			--from markdown --to html \
			--output $(OUT_DIR)/$$FILE_NAME.html $$f \
			--metadata pagetitle=$$FILE_NAME;\
	done

pdf: html
	for f in $(OUT_DIR)/*.html; do \
		FILE_NAME=`basename $$f | sed 's/.html//g'`; \
		echo $$FILE_NAME.html; \
		wkhtmltopdf $$f $$FILE_NAME.pdf; \
	done

init: dir

dir:
	mkdir -p $(OUT_DIR)
