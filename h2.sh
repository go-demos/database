#!/bin/sh
#
# Control H2 instance; assumes default port assignments
# Author: John B. Matthews
# License: http://www.h2database.com/html/license.html
#
base=${HOME}
classpath=.:./h2-1.3.167.jar
netstat=/bin/netstat
ps="ps axwww"
server=org.h2.tools.Server
webport=8082
defaultports="(5435\|${webport}\|9092\|9094)"

getpid() {
  pid=`${ps} | grep java | grep ${server} | awk '{ print $1 };'`
}

start() {
  java -cp ${classpath} ${server} -tcp -web -baseDir ${base} &
  READY=0
  while [ $READY -eq 0 ]
    do
      sleep 1
      READY=`${netstat} -an | grep ${webport} | wc -l`
    done
}

stop() {
  getpid
  if [ "${pid}x" = "x" ]
    then echo "No H2 Server running."
  else
    echo "Killing H2 Server process id: ${pid}"
    kill -9 ${pid}
  fi
}

status() {
  getpid
  if [ "${pid}x" = "x" ]
    then echo "No H2 Server running."
  else
    echo "H2 Server has process id: ${pid}"
    ${netstat} -an | grep ${defaultports} | grep -i listen
  fi
}

restart() {
    stop
    start
}

help() {
  java -cp ${classpath} ${server} -?
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  status)
    status
    ;;
  help)
    help
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart|status|help}"
    exit 1
esac

exit $?
