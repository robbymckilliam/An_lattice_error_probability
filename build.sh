cd plots   
mpost -interaction=nonstopmode peplots.mp   
cd ..   

latex paper.tex  
bibtex paper  
latex paper.tex  
latex paper.tex  
dvips paper.dvi  
ps2pdf paper.ps  