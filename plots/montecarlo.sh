export JAVA_OPTS="-d64 -server -Xms1g -Xmx1g"

CP=""
for f in *.jar
do
CP=$CP:${f}
done

scala -cp $CP montecarlo.scala
scala -cp $CP znsim.scala
scala -cp $CP e8sim.scala
