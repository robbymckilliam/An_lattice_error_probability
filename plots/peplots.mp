prologues := 2;
filenametemplate "%j-%c.mps";
verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex

input graph;
input sarith;
picture ORIGINAL_PICTURE;
ORIGINAL_PICTURE := currentpicture;

picture dd; dd :=
dashpattern(on 4bp off 2bp on 1bp off 2bp);

picture diamond;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm rotated 45;
diamond := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture square;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm;
square := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture circle; 
draw fullcircle scaled 0.19cm;
circle := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture cross; 
draw (-0.09cm,0.0)--(0.09cm,0.0);
draw (0,-0.09cm)--(0,0.09cm);
cross := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture dot; 
fill fullcircle scaled 0.15cm;
dot := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture times; times := cross rotated 45;

picture legend;
sx = 0.2cm;
sh = 0.2cm;
ups = 0.35cm;

label.rt(btex Union bound etex, (1cm,sh - ups));
draw (sx,sh - ups)--(1cm,sh - ups) dashed evenly;

label.rt(btex Exact etex, (1cm,sh));
draw (sx,sh)--(1cm,sh);

label.rt(btex Monte Carlo etex, (1cm,sh + ups));
draw dot shifted 1/2[(sx,sh + ups),(1cm,sh + ups)];


legend := currentpicture; currentpicture := ORIGINAL_PICTURE;

plotheight = 10cm;
plotwidth = 14cm;

legendx = plotwidth - 4cm;
legendy = plotheight - 1cm;

beginfig(1);
draw begingraph(plotwidth, plotheight);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex $P_E$ etex, OUT) rotated 90;
 
  %setrange(whatever,"1e-6", whatever,0.05);
  setrange(7.7,"1e-13", 21.5,2);

%  gdraw (0, "1e-13")--(0, 2) dashed evenly; %glabel.bot(btex AWGN channel capacity etex, 0) rotated 90;

  gdraw "moment1"; glabel.bot(btex $A_1$ etex, 1000);
  gdraw "moment2"; glabel.bot(btex $A_2$ etex, 1000);
  gdraw "moment3"; glabel.bot(btex $A_3$ etex, 1000);
  gdraw "moment4"; glabel.lrt(btex $A_4$ etex, 1000);
 % gdraw "moment5"; glabel.lrt(btex $A_5$ etex, 1000);

  gdraw "pemontecarlo1" plot(dot);
  gdraw "pemontecarlo2" plot(dot);
  gdraw "pemontecarlo3" plot(dot);
  gdraw "pemontecarlo4" plot(dot);
  %gdraw "pemontecarlo5" plot(dot);
 % gdraw "pemontecarlo8" plot(dot);

  gdraw "pemontecarlo_E8" plot(dot); 
  gdraw "E8UnionBound" dashed evenly; glabel.rt(btex $E_8$ etex, 1000);

 %gdraw "pemontecarlo_Leech" plot(dot);
  gdraw "LeechUnionBound" dashed evenly; glabel.lrt(btex $\Lambda_{24}$ etex, 1000);
  
 % gdraw "class.lattices.E8_8";
 % gdraw "class.lattices.P48_48";
 % gdraw "class.lattices.leech.Leech_24";
 % gdraw "class.lattices.Shimada86_86";
 % gdraw "class.lattices.Zn_10";

  
draw legend shifted(legendx,legendy);

endgraph;

clip currentpicture to (-10cm,-10cm)--(-10cm,plotheight)--(plotwidth+5cm,plotheight)--(plotwidth+5cm,-10cm)--cycle

endfig;

end;