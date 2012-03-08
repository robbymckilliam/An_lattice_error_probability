require 'rubygems'
require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

file = RubyPost::File.new('hexlatfig')

def dround(x)
  (2056*x).round/2056
end

scaler = 1.7

M = scaler*Matrix[ [1,0.5], [0, 0.5*(3**(0.5))] ]
R = Matrix[[Math.cos(Math::PI/3), -Math.sin(Math::PI/3)],[Math.sin(Math::PI/3), Math.cos(Math::PI/3)]]
v = (M*Vector[1,0] + M*Vector[0,1])*(1/3)
vorpath = Path.new
6.times do
  vorpath.add_pair(Pair.new(dround(v[0]).cm, dround(v[1]).cm))
  v = R*v
end
vorpath.add_pair('cycle')

pic = Picture.new('picL')
circ = Picture.new('circ')
vorpic = Picture.new('vor')
inrad = 1.0
(-3..3).each do |x|
	(-3..3).each do |y|
		v = M*Vector[x,y]
		pic.add_drawable(Fill.new(Circle.new()).scale(0.1.cm).translate(v[0].cm,v[1].cm))
    circ.add_drawable(Draw.new(Circle.new()).scale((scaler*inrad).cm).translate(v[0].cm,v[1].cm))
    vorpic.add_drawable(Draw.new(vorpath).translate(v[0].cm,v[1].cm))
	end
end

#figure 2 is the same but with packing circles added
fig = Figure.new
cliprect = "((3.5cm,2.5cm)--(-3.5cm,2.5cm)--(-3.5cm,-2.5cm)--(3.5cm,-2.5cm)--cycle)"
fig.add_drawable(Clip.new(cliprect, pic))
fig.add_drawable(Clip.new(cliprect, vorpic))
fig.add_drawable(Clip.new(cliprect, circ))
fig.add_drawable(Draw.new(vorpic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Draw.new(circ))
file.add_figure(fig)

file.compile
