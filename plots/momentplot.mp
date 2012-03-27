prologues := 2;
filenametemplate "%j-%c.mps";
input TEX; 
TEXPRE("%&latex" & char(10) & 
"\documentclass{minimal}\begin{document}"); 
TEXPOST("\end{document}"); 


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
label.rt(btex Approximate etex, (1cm,sh));
draw (sx,sh)--(1cm,sh);

label.rt(btex Exact etex, (1cm,sh + ups));
draw dot shifted 1/2[(sx,sh + ups),(1cm,sh + ups)];

legend := currentpicture; currentpicture := ORIGINAL_PICTURE;

plotheight = 15cm;
plotwidth = 10cm;

legendx = 6cm;

beginfig(1);
draw begingraph(plotwidth, plotheight);
 setcoords(linear,log);
 glabel.bot(btex $n$ etex, OUT);
 glabel.lft(btex $V_m$ etex, OUT) rotated 90;
 
  %setrange(whatever,"1e-6", whatever,0.05);

  gdraw "m2approx";
  gdraw "m4approx";
  gdraw "m6approx";
  gdraw "m8approx";
  gdraw "m10approx";
  
  gdraw "m2" plot(dot); glabel.bot(btex $V_2$ etex, 38);
  gdraw "m4" plot(dot); glabel.bot(btex $V_4$ etex, 38);
  gdraw "m6" plot(dot); glabel.bot(btex $V_6$ etex, 38);
  gdraw "m8" plot(dot); glabel.bot(btex $V_8$ etex, 38);
  gdraw "m10" plot(dot); glabel.bot(btex $V_{10}$ etex, 38);

draw legend shifted(legendx,0.1cm);

endgraph;

clip currentpicture to (-10cm,-10cm)--(-10cm,plotheight)--(plotwidth+5cm,plotheight)--(plotwidth+5cm,-10cm)--cycle

endfig;

end;