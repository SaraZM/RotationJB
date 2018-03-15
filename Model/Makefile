PROJECT=Logistic_Regression
TEX=pdflatex
BIBTEX=bibtex
BUILDTEX=$(TEX) $(PROJECT).tex

.PHONY: help clean tics all bio pack


help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  tics to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  clean 	 to clean " 
	@echo "  all to make clean, make tics, and launch " 

all:
	$(BUILDTEX)
	#$(BIBTEX) $(PROJECT)
	$(BUILDTEX)
	$(BUILDTEX)

clean-all:
	rm -f *.dvi *.log *.bak *.aux *.bbl *.blg *.idx *.ps *.eps *.pdf *.toc *.out *~

clean:
	rm -f *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~

