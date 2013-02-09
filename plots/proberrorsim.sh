export JAVA_OPTS="-Xprof -server -Xms1g -Xmx4g"
#export JAVA_OPTS="-d64 -server -Xms1g -Xmx1g"

CP=""
for f in *.jar
do
CP=$CP:${f}
done

scala -cp $CP proberrorsim.scala
