all: clean PhDThesis

PhDThesis:
	pdflatex PhDThesis
	biber PhDThesis
	pdflatex PhDThesis
	pdflatex PhDThesis
clean:
	rm -f *.aux *.bbl *.blg *-blx.bib *.log *.out *.run.xml *.toc *.bcf *~\
		*.lot *.lof

distclean: clean
	rm -f PhDThesis.pdf
	rm -rf auto/
