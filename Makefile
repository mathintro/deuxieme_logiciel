STYLES := css/tufte-css/tufte.css \
	css/pandoc.css \
	css/pandoc-solarized.css \
	css/tufte-extra.css

OPTIONS = --toc
OPTIONS += --filter=pandoc-numbering
OPTIONS += --filter=pandoc-crossref
OPTIONS += --pdf-engine pdflatex

PDFOPTIONS = --highlight-style kate
PDFOPTIONS += --number-sections
PDFOPTIONS += --template=./default.latex


HTMLOPTIONS += -t html5
HTMLOPTIONS += -c css/styling.css
HTMLOPTIONS += --self-contained
HTMLOPTIONS += --mathjax=MathJax.js


SVG=$(wildcard figs/*.svg)
PNG=$(SVG:%.svg=%.png)
MD=$(wildcard *.md)
HTML=$(MD:%.md=%.html)
PDF=$(MD:%.md=%.pdf)


all: $(PNG) $(HTML) $(PDF)

figs/%.png: figs/%.svg
	convert \-flatten $< $@

%.pdf: %.md Makefile
	pandoc -s $(OPTIONS) $(PDFOPTIONS) -o $@ $<

%.html: %.md Makefile
	pandoc -s $(OPTIONS) $(HTMLOPTIONS) -o $@ $<

clean:
	rm -rf *.html *.pdf
