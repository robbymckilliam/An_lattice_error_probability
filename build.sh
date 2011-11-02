cd plots
mpost -interaction=nonstopmode peplots.mp
cd ..

pdflatex paper.tex
bibtex paper
pdflatex paper.tex
pdflatex paper.tex