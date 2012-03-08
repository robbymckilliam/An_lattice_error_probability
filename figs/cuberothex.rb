require 'rubygems'
require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

file = RubyPost::File.new('cuberothex')

def dround(x)
  (2056*x).round/2056
end

scaler = 1.7

#the vertices of a cube
v1 = Vector[1,1,1]/2.0
v2 = Vector[1,1,-1]/2.0
v3 = Vector[1,-1,1]/2.0
v4 = Vector[1,-1,-1]/2.0
v5 = Vector[-1,1,1]/2.0
v6 = Vector[-1,1,-1]/2.0
v7 = Vector[-1,-1,1]/2.0
v8 = Vector[-1,-1,-1]/2.0

#put the vertices in a array
vertices = [v1,v2,v3,v4,v5,v6,v7,v8]

#collect hypercube graph edges into an array
edges = Array.new
(0..7).each do |i|
  ((i+1)..7).each do |j|
    if (vertices[i] - vertices[j]).r <= 1.01  
      edges.push([vertices[i],vertices[j]]) 
    end
  end
end

picsideon = Picture.new
edges.each do |e|
  vi = e[0]; vj = e[1];
  path = Path.new
  path.add_pair(Pair.new(vi[0].cm,vi[1].cm))
  path.add_pair(Pair.new(vj[0].cm,vj[1].cm))
  picsideon.add_drawable(Draw.new(path))
end

picvertexon = Picture.new
oc = Vector[-1/2.0,-1/2.0,-1/2.0]; #the occluded vertex
r1 = Vector[1.0,1.0,1.0]; r1 = r1/r1.r #setup for a householder reflection
r2 = Vector[0.0,0.0,1.0]; r2 = r2/r2.r
rv = r1 + r2
nrv = rv/rv.r;
rm = Matrix[[nrv[0],nrv[1],nrv[2]]]
R = Matrix.identity(3) - (rm.t*rm)*2 
edges.each do |e|
  vi = R*e[0]; vj = R*e[1];
  path = Path.new
  path.add_pair(Pair.new(vi[0].cm,vi[1].cm))
  path.add_pair(Pair.new(vj[0].cm,vj[1].cm))
  if  (e[0] + oc).r <= 0.01 || (e[1] + oc).r <= 0.01
    print('true')
    picvertexon.add_drawable(Draw.new(path).add_option(Dashed.new))
  else
    picvertexon.add_drawable(Draw.new(path))
  end
end

picmiddle1 = Picture.new
oc = Vector[1/2.0,1/2.0,1/2.0]; #the occluded vertex
r1 = Vector[1.0,1.0,1.0]; r1 = r1/r1.r/2.0 #setup for a householder reflection
r2 = Vector[0.0,0.0,1.0]; r2 = r2/r2.r
rv = r1 + r2
nrv = rv/rv.r;
rm = Matrix[[nrv[0],nrv[1],nrv[2]]]
R = Matrix.identity(3) - (rm.t*rm)*2 
edges.each do |e|
  vi = R*e[0]; vj = R*e[1];
  path = Path.new
  path.add_pair(Pair.new(vi[0].cm,vi[1].cm))
  path.add_pair(Pair.new(vj[0].cm,vj[1].cm))
  if  (e[0] + oc).r <= 0.01 || (e[1] + oc).r <= 0.01
    print('true')
    picmiddle1.add_drawable(Draw.new(path).add_option(Dashed.new))
  else
    picmiddle1.add_drawable(Draw.new(path))
  end
end

picmiddle2 = Picture.new
#oc = Vector[1/2.0,1/2.0,-1/2.0]; #the occluded vertex
r1 = Vector[1.0,1.0,1.0]; r1 = r1/r1.r/1.3 #setup for a householder reflection
r2 = Vector[0.0,0.0,1.0]; r2 = r2/r2.r
rv = r1 + r2
nrv = rv/rv.r;
rm = Matrix[[nrv[0],nrv[1],nrv[2]]]
R = Matrix.identity(3) - (rm.t*rm)*2 
edges.each do |e|
  vi = R*e[0]; vj = R*e[1];
  path = Path.new
  path.add_pair(Pair.new(vi[0].cm,vi[1].cm))
  path.add_pair(Pair.new(vj[0].cm,vj[1].cm))
  if  (e[0] + oc).r <= 0.01 || (e[1] + oc).r <= 0.01
    print('true')
    picmiddle2.add_drawable(Draw.new(path).add_option(Dashed.new))
  else
    picmiddle2.add_drawable(Draw.new(path))
  end
end

#R = Matrix[[Math.cos(Math::PI/3), -Math.sin(Math::PI/3)],[Math.sin(Math::PI/3), Math.cos(Math::PI/3)]]
#v = (M*Vector[1,0] + M*Vector[0,1])*(1/3)
#vorpath = Path.new
#6.times do
#  vorpath.add_pair(Pair.new(dround(v[0]).cm, dround(v[1]).cm))
#  v = R*v
#end
#vorpath.add_pair('cycle')

#pic = Picture.new('picL')
#circ = Picture.new('circ')
#vorpic = Picture.new('vor')
#inrad = 1.0
#(-3..3).each do |x|
#	(-3..3).each do |y|
#		v = M*Vector[x,y]
#		pic.add_drawable(Fill.new(Circle.new()).scale(0.1.cm).translate(v[0].cm,v[1].cm))
#    circ.add_drawable(Draw.new(Circle.new()).scale((scaler*inrad).cm).translate(v[0].cm,v[1].cm))
#    vorpic.add_drawable(Draw.new(vorpath).translate(v[0].cm,v[1].cm))
#	end
#end

#figure 2 is the same but with packing circles added
fig = Figure.new
fig.add_drawable(Draw.new(picsideon))
fig.add_drawable(Draw.new(picmiddle1).translate(2.0.cm,0.0.cm))
fig.add_drawable(Draw.new(picmiddle2).translate(4.0.cm,0.0.cm))
fig.add_drawable(Draw.new(picvertexon).translate(6.0.cm,0.0.cm))
#cliprect = "((3.5cm,2.5cm)--(-3.5cm,2.5cm)--(-3.5cm,-2.5cm)--(3.5cm,-2.5cm)--cycle)"
#fig.add_drawable(Clip.new(cliprect, pic))
#fig.add_drawable(Clip.new(cliprect, vorpic))
#fig.add_drawable(Clip.new(cliprect, circ))
#fig.add_drawable(Draw.new(vorpic))
#fig.add_drawable(Draw.new(pic))
#fig.add_drawable(Draw.new(circ))
file.add_figure(fig)

file.compile
