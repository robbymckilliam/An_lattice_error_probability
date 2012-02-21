#build figures
mpost -interaction=nonstopmode ../../plots/thpplot.mp 
ruby1.9.1 hexlatfig.rb

#build tex
pdflatex threepager.tex
bibtex threepager
pdflatex threepager.tex
pdflatex threepager.tex

