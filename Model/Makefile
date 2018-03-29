PROJECT1=Logistic_Regression
PROJECT2=Model_1_description
TEX=pdflatex
BIBTEX=bibtex
BUILDTEX1=$(TEX) $(PROJECT1).tex
BUILDTEX2=$(TEX) $(PROJECT2).tex

.PHONY: help clean tics all bio pack


help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  tics to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  clean 	 to clean " 
	@echo "  all to make clean, make tics, and launch " 


nocov:
	$(BUILDTEX2)
	#$(BIBTEX) $(PROJECT)
	$(BUILDTEX2)
	$(BUILDTEX2)
logistic:
	$(BUILDTEX1)
	#$(BIBTEX) $(PROJECT)
	$(BUILDTEX1)
	$(BUILDTEX1)

all: 
	nocov
	logistic

clean-all:
	rm -f *.dvi *.log *.bak *.aux *.bbl *.blg *.idx *.ps *.eps *.pdf *.toc *.out *~

clean:
	rm -f *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~

