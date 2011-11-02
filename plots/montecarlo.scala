/**
* Probability of error plots for the lattice An.
*/
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.lattices.An.AnFastSelect
import pubsim.distributions.GaussianNoise

val ns = List(2,3,4)

val startdb = 5.5
val stepdb = 0.5
val tope = 1e-6


for(n <- ns){
  val lattice = new AnFastSelect(n)
  var pe = 1.0
  var dbnow = startdb 
  val mfile = new java.io.FileWriter("pemontecarlo" + n)

  println
  println("Now running n = " + n)
  println("SNRdB \t Prob Error")
  while(pe > tope){
    //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
    val snr = scala.math.pow(10.0,dbnow/10.0)
    val v = (3.0+n)/3.0/scala.math.sqrt(n+1)/snr
    pe = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),500).probError
    println(dbnow + "\t" + pe)
    mfile.write(dbnow.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
    dbnow = dbnow + stepdb
  }

  mfile.close

}