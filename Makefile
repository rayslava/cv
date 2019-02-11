FILENAME=barinov-cv
PDFMAKER=pdflatex
PDFOPTS=
HTMLMAKER=latex2html
HTML_PROLOGUE=moderncv.perl
CSS=moderncv.css
PHOTO=photo.jpg
HTMLOPTS=-split 0 -nonavigation -info 0 -init_file $(HTML_PROLOGUE) -noindex_in_navigation -style ${FILENAME}.css -title "Slava Barinov"
REPO_PATH:=$(shell echo "https://rayslava:${GIT_TOKEN}@github.com/rayslava/cv.git")

all: clean css html pdf

$(FILENAME).pdf: $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex
	$(PDFMAKER) $(PDFOPTS) $(FILENAME).tex

latex2htmlstyle:
	git clone https://github.com/rayslava/moderncv2html.git
	ln -sf moderncv2html/moderncv.perl
	ln -sf moderncv2html/moderncv.css

$(FILENAME)/$(FILENAME).html: $(FILENAME).pdf latex2htmlstyle $(HTML_PROLOGUE) $(PHOTO)
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	$(HTMLMAKER) $(HTMLOPTS) $(FILENAME).tex
	cp $(PHOTO) $(FILENAME)/$(PHOTO)
	cp $(FILENAME).pdf $(FILENAME)/$(FILENAME).pdf
	rm $(FILENAME)/index.html $(FILENAME)/labels.pl $(FILENAME)/WARNINGS

$(CSS): latex2htmlstyle

html: $(FILENAME)/$(FILENAME).html
pdf: $(FILENAME).pdf

css: $(CSS) $(FILENAME)/$(FILENAME).html
	cp $(CSS) $(FILENAME)/$(FILENAME).css

deploy: $(FILENAME)/$(FILENAME).html css
	@cd $(FILENAME) && git init && \
		git config user.name "Travis CI" && \
		git config user.email "rayslava@gmail.com" && \
		git add . && git commit -m "Deploy to GitHub Pages" && \
		git push --force --quiet "$(REPO_PATH)" master:gh-pages > /dev/null 2>&1

clean:
	rm -rf *.log *.aux *.pdf *.dvi *.out $(FILENAME) moderncv*
