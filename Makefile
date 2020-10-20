FILE=slides
LC=xelatex

all:
	$(LC) -synctex=1 -interaction=nonstopmode $(FILE).tex
	$(LC) -synctex=1 -interaction=nonstopmode $(FILE).tex

clean:
	rm $(FILE).aux $(FILE).log $(FILE).nav $(FILE).out $(FILE).pdf $(FILE).snm $(FILE).synctex.gz $(FILE).toc $(FILE).vrb

