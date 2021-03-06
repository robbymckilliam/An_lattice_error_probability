/**
* Probability of error plots for the lattice An.
*/
import pubsim.lattices.util.PowerOfEuclideanNorm
import pubsim.lattices.An.AnFastSelect
import pubsim.lattices.An.MomentComputer
import bignums.BigRational
import pubsim.Util

val ns = List(2,3,4,5)
//val lattice = new AnFastSelect(n)
val varstart = new BigRational(1,2)
val varstep = new BigRational(93,100)
val tope = 1e-12
val petol = 1e-17

print("Reading existing moment data, this might take a moment....")
val mc = new MomentComputer("momentstore")
println("finished")

for(n <- ns){
  var pe = 1.0
  var varnow = varstart 
  val mfile = new java.io.FileWriter("moment" + n)

  val V = scala.math.sqrt(n+1.0)

  println
  println("Now running n = " + n)
  println("SNRdB \t Prob Error")
  while(pe > tope){
    //val snrdb = lattice.noiseVarianceToSNRdB(varnow.doubleValue)
    val snr = scala.math.pow(V,2.0/n)/varnow.doubleValue/4
    val snrdb = 10*scala.math.log10(snr)
    pe = mc.ProbError(n,varnow,petol)
    varnow = varnow.multiply(varstep)
    println(snrdb + "\t" + pe + "\t" + mc.numberMomentsLastUsed)
    mfile.write(snrdb.toString.replace('E', 'e') + "\t" + pe.toString.replace('E', 'e') + "\n")
  }

  mfile.close

}

mc.save
