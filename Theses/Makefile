all: clean BSc MSc PhD

BSc:
	latexmk BScThesis

MSc:
	latexmk MScThesis

PhD:
	latexmk PhDThesis

gogo:
	latexmk -gg BScThesis
	latexmk -gg MScThesis
	latexmk -gg PhDThesis

clean:
	latexmk -c

distclean: clean
	latexmk -C
	rm -fr auto/
