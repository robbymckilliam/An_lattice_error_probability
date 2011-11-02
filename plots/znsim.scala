/**
* Probability of error plots for the lattice Zn.
*/
import java.math.BigInteger
import pubsim.BigRational
import pubsim.lattices.Zn
import pubsim.Util
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.distributions.GaussianNoise

/*
{
println
println("Running Monte-Carlo trials with the Zn lattice")

val lattice = new Zn(1)
val startdb = 0.0
val stepdb = 0.5
val tope = 1e-6

var pe = 1.0
var dbnow = startdb 
val efile = new java.io.FileWriter("pemontecarlo1")

println
println("SNRdB \t Prob Error")
while(pe > tope){
  //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
  val snr = scala.math.pow(10.0,dbnow/10.0)
  val v = 2.0/3.0/snr
  pe = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),1000).probError
  println(dbnow + "\t" + pe)
  efile.write(dbnow.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
  dbnow = dbnow + stepdb
}
efile.close
}
*/


{
val varstart = 1.0/2.0
val varstep = 9.0/10.0
val tope = 5e-11
val petol = 1e-16

var pe = 1.0
var varnow = varstart 
val mfile = new java.io.FileWriter("moment1")

val tol = new BigRational(BigInteger.ONE, BigInteger.TEN.pow(15));

println
println("Caculating 'exact' error probabilty using the error function")
println
println("SNRdB \t Prob Error")
while(pe > tope){
  //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
  val r2sdev = new BigRational(scala.math.sqrt(varnow*8.0) ,25)
  val snr = 2.0/3.0/varnow
  val snrdb = 10*scala.math.log10(snr)
  pe = 1.0 - pubsim.Util.erf(r2sdev.reciprocal, tol)
  varnow = varnow*varstep
  println(snrdb + "\t" + pe)
  mfile.write(snrdb.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
}
mfile.close
}



