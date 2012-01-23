/**
* Probability of error plots for the lattice Zn.
*/
import java.math.BigInteger
import pubsim.BigRational
import pubsim.lattices.E8
import pubsim.Util
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.distributions.GaussianNoise


{
println
println("Running Monte-Carlo trials with the E8 lattice")

val lattice = new E8
val startdb = 10.0
val stepdb = 0.5
val tope = 1e-6

val sm = lattice.secondMoment

var pe = 1.0
var dbnow = startdb 
val efile = new java.io.FileWriter("pemontecarlo_E8")

println
println("SNRdB \t Prob Error")
while(pe > tope){
  //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
  val snr = scala.math.pow(10.0,dbnow/10.0)
  val v = 1/snr/4
  pe = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),500).probError
  println(dbnow + "\t" + pe + "\t"  + v)
  efile.write(dbnow.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
  dbnow = dbnow + stepdb
}
efile.close
}


{
val varstart = 1.0/6.0
val varstep = 9.5/10.0
val tope = 1e-12

var pe = 1.0
var varnow = varstart 
val mfile = new java.io.FileWriter("E8UnionBound")

val tol = new BigRational(BigInteger.ONE, BigInteger.TEN.pow(25));

println
println("Caculating union lower bound on the error probabilty of E8")
println
println("SNRdB \t Prob Error")
while(pe > tope){
  //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
  val r2sdev = new BigRational(scala.math.sqrt(varnow*4.0) ,20)
  val snr = 1/varnow/4
  val snrdb = 10*scala.math.log10(snr)
  pe = 240*(1 - pubsim.Util.erf(r2sdev.reciprocal, tol))
  varnow = varnow*varstep
  println(snrdb + "\t" + pe)
  mfile.write(snrdb.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
}
mfile.close
}
