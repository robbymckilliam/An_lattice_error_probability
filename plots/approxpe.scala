/**
* Brute force an approximation for probabilty of correct decoding with the lattice An
*/
import pubsim.lattices.util.ProbabilityOfCodingError
import pubsim.lattices.An.AnFastSelect
import pubsim.distributions.GaussianNoise

val n = 8
val lattice = new AnFastSelect(n)
val mfile = new java.io.FileWriter("n" + n + "approxpc")

println("var \t prob correct" )

for( v <- (0 to 60).map(1/scala.math.pow(15.0/14.0,_)) ){
    val probc = new ProbabilityOfCodingError(lattice,new GaussianNoise(0,v),1000).probError;
    println(v + "\t" + probc )
    mfile.write(v + "\t" +  probc.toString.replace('E', 'e') + "\n")
 }
  mfile.close
