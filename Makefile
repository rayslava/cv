FILENAME=cv
PDFMAKER=pdflatex
PDFOPTS=
HTMLMAKER=latex2html
HTML_PROLOGUE=moderncv.perl
CSS=moderncv.css
HTMLOPTS=-split 0 -nonavigation -info 0 -init_file $(HTML_PROLOGUE) -noindex_in_navigation -style cv.css -title "Slava Barinov"

all: html pdf deploy

$(FILENAME).pdf: $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex

$(FILENAME)/$(FILENAME).html: $(FILENAME).tex $(HTML_PROLOGUE)
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	cp ${CSS} $(FILENAME)/$(FILENAME).css
	rm $(FILENAME)/index.html $(FILENAME)/labels.pl $(FILENAME)/WARNINGS

html: $(FILENAME)/$(FILENAME).html
pdf: $(FILENAME).pdf

css: $(CSS) $(FILENAME)/$(FILENAME).html
	cp $(CSS) $(FILENAME)/$(FILENAME).css

clean:
	rm -rf *.log *.aux *.pdf *.dvi *.out $(FILENAME)
