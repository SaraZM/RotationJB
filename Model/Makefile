PROJECT1=Logistic_Regression
PROJECT2=Model_1_description
PROJECT3=Model_2_one_covariate
TEX=pdflatex
BIBTEX=bibtex
BUILDTEX1=$(TEX) $(PROJECT1).tex
BUILDTEX2=$(TEX) $(PROJECT2).tex
BUILDTEX3=$(TEX) $(PROJECT3).tex


.PHONY: help clean tics all bio pack


help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo " nocov, cov, or logistic to make LaTeX files, 
	@echo " you can set PAPER=a4 or PAPER=letter"
	@echo "  clean 	 to clean " 
	@echo "  all to make clean " 


cov:
	$(BUILDTEX3)
	#$(BIBTEX) $(PROJECT)
	$(BUILDTEX3)
	$(BUILDTEX3)
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
	-make clean
	-make nocov
	-make cov
	-make logistic

clean-all:
	rm -f *.dvi *.log *.bak *.aux *.bbl *.blg *.idx *.ps *.eps *.pdf *.toc *.out *~

clean:
	rm -f *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~

