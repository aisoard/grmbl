.PHONY: user-manual clean reset

PDFLATEX_OPTIONS=-halt-on-error -interaction nonstopmode

all: user-manual

user-manual:
	pdflatex $(PDFLATEX_OPTIONS) -output-directory build user-manual.tex > build/first.log
	pdflatex $(PDFLATEX_OPTIONS) -output-directory build user-manual.tex > build/second.log
	mv build/user-manual.pdf user-manual.pdf
	ln -n -f -s user-manual/user-manual.pdf ../user-manual.pdf

clean:
	@rm -v -f *~
	@rm -v -f build/*

reset: clean
	@rm -v -f user-manual.pdf
	@rm -v -f ../user-manual.pdf
