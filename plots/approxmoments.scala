/**
* Brute force an for powers of the Euclidean norm of An
*/
import pubsim.lattices.util.PowerOfEuclideanNorm
import pubsim.lattices.An.AnFastSelect

for( m <- List(1,2,3,4,5) ){
  val mfile = new java.io.FileWriter("m" + m + "approx")
  println(m + " moment test")
  for( n <- 1 to 40 ) {
    val lattice = new AnFastSelect(n)
    val latticeprops = new PowerOfEuclideanNorm(lattice,m)
    latticeprops.uniformlyDistributed(100000)
    println(n + "\t" + latticeprops.moment() )
    mfile.write(n + "\t" +  latticeprops.moment().toString.replace('E', 'e') + "\n")
  }
  mfile.close
  println
}

//~ println("4th moment test")
//~ for( n <- 1 to 40 ) {
  //~ val lattice = new AnFastSelect(n)
  //~ val latticeprops = new MomentApproximator(lattice,4)
  //~ latticeprops.uniformlyDistributed(100000)
  //~ //val moment = n*(-10 + 33*n + 22*n*n + 3*n*n*n)/(240.0*(1 + n)*(1 + n)*(1 + n))
  //~ println(n + "\t" + latticeprops.moment() )
//~ }
//~ println
//~ println("6th moment test")
//~ for( n <- 1 to 40 ) {
  //~ val lattice = new AnFastSelect(n)
  //~ val latticeprops = new MomentApproximator(lattice,6)
  //~ latticeprops.uniformlyDistributed(100000)
  //~ println(n + "\t" + latticeprops.moment() )
//~ }
//~ println
//~ println("8th moment test")
//~ for( n <- 1 to 40 ) {
  //~ val lattice = new AnFastSelect(n)
  //~ val latticeprops = new MomentApproximator(lattice,8)
  //~ latticeprops.uniformlyDistributed(100000)
  //~ println(n + "\t" + latticeprops.moment() )
//~ }
//~ println
//~ println("10th moment test")
//~ for( n <- 1 to 40 ) {
  //~ val lattice = new AnFastSelect(n)
  //~ val latticeprops = new MomentApproximator(lattice,10)
  //~ latticeprops.uniformlyDistributed(100000)
  //~ println(n + "\t" + latticeprops.moment() )
//~ }
