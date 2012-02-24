/**
* Probability of error plots for the lattice An.
*/
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.lattices.An.AnFastSelect
import pubsim.distributions.GaussianNoise

val ns = List(2,3,4,5,8)

val startdb = 10.0
val stepdb = 0.5
val tope = 1e-6

val toerrors = 5000 //this will take a while!

println("Running Monte-Carlo trials with An lattices")


println("n \t SNRdB \t Prob Error")
//run each value of n in it's own thread
ns.par foreach { n => 

  val lattice = new AnFastSelect(n)
  var pe = 1.0
  var dbnow = startdb 
  val mfile = new java.io.FileWriter("pemontecarlo" + n)
  val V = scala.math.sqrt(n+1.0)

  while(pe > tope){
    //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
    val snr = scala.math.pow(10.0,dbnow/10.0)
    //val v = (3.0+n)/3.0/scala.math.sqrt(n+1)/snr
    val v  = scala.math.pow(V,2.0/n)/snr/4
    pe = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),toerrors).probError
    println(n + "\t" + dbnow + "\t" + pe)
    mfile.write(dbnow.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
    dbnow = dbnow + stepdb
  }

  mfile.close

}
