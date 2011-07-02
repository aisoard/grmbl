.PHONY: developer-manual clean reset

PDFLATEX_OPTIONS=-halt-on-error -interaction nonstopmode

all: developer-manual

developer-manual:
	pdflatex $(PDFLATEX_OPTIONS) -output-directory build developer-manual.tex > build/first.log
	pdflatex $(PDFLATEX_OPTIONS) -output-directory build developer-manual.tex > build/second.log
	mv build/developer-manual.pdf developer-manual.pdf
	ln -n -f -s developer-manual/developer-manual.pdf ../developer-manual.pdf

clean:
	@rm -v -f *~
	@rm -v -f build/*

reset: clean
	@rm -v -f developer-manual.pdf
	@rm -v -f ../developer-manual.pdf
