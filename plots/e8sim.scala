/**
* Probability of error plots for the lattice Zn.
*/
import java.math.BigInteger
import pubsim.BigRational
import pubsim.lattices.E8
import pubsim.Util
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.distributions.GaussianNoise

/*
{
println
println("Running Monte-Carlo trials with the E8 lattice")

val lattice = new E8
val startdb = 5.5
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
  val v = 4.0*sm/snr/8
  pe = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),200).probError
  println(dbnow + "\t" + pe)
  efile.write(dbnow.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
  dbnow = dbnow + stepdb
}
efile.close
}
*/


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
  val snr = 929.0/3240.0/varnow
  val snrdb = 10*scala.math.log10(snr)
  pe = 240*(1 - pubsim.Util.erf(r2sdev.reciprocal, tol))
  varnow = varnow*varstep
  println(snrdb + "\t" + pe)
  mfile.write(snrdb.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
}
mfile.close
}


{
val varstart = 1.0/6.0
val varstep = 9.5/10.0
val tope = 1e-12

var pe = 1.0
var varnow = varstart 
val mfile = new java.io.FileWriter("LeechUnionBound")

val tol = new BigRational(BigInteger.ONE, BigInteger.TEN.pow(25));

println
println("Caculating union lower bound on the error probabilty of Leech lattice")
println
println("SNRdB \t Prob Error")
while(pe > tope){
  //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
  val r2sdev = new BigRational(scala.math.sqrt(varnow*2.0) ,20)
  val snr = 4*0.065771/varnow
  val snrdb = 10*scala.math.log10(snr)
  pe = 196560*(1 - pubsim.Util.erf(r2sdev.reciprocal, tol))
  varnow = varnow*varstep
  println(snrdb + "\t" + pe)
  mfile.write(snrdb.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
}
mfile.close
}


