cd plots 
mpost -interaction=nonstopmode peplots.mp 
cd .. 

cd figs 
mpost -interaction=nonstopmode cuberothex.mp 
mpost -interaction=nonstopmode hexlatfig.mp 
cd .. 

pdflatex paper.tex
bibtex paper
pdflatex paper.tex
pdflatex paper.tex
