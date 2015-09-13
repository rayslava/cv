FILENAME=barinov-cv
PDFMAKER=pdflatex
PDFOPTS=
HTMLMAKER=latex2html
HTML_PROLOGUE=moderncv.perl
CSS=moderncv.css
PHOTO=photo.jpg
HTMLOPTS=-split 0 -nonavigation -info 0 -init_file $(HTML_PROLOGUE) -noindex_in_navigation -style ${FILENAME}.css -title "Slava Barinov"

all: clean css html pdf

$(FILENAME).pdf: $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex

$(FILENAME)/$(FILENAME).html: $(FILENAME).pdf $(HTML_PROLOGUE) $(PHOTO)
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	cp $(PHOTO) $(FILENAME)/$(PHOTO)
	cp $(FILENAME).pdf $(FILENAME)/$(FILENAME).pdf
	rm $(FILENAME)/index.html $(FILENAME)/labels.pl $(FILENAME)/WARNINGS

html: $(FILENAME)/$(FILENAME).html
pdf: $(FILENAME).pdf

css: $(CSS) $(FILENAME)/$(FILENAME).html
	cp $(CSS) $(FILENAME)/$(FILENAME).css

clean:
	rm -rf *.log *.aux *.pdf *.dvi *.out $(FILENAME)
