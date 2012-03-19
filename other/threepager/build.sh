#build figures
mpost -interaction=nonstopmode ../../plots/thpplot.mp 
ruby1.9.1 hexlatfig.rb 

#build tex 
latex threepager.tex 
bibtex threepager 
latex threepager.tex 
latex threepager.tex 

