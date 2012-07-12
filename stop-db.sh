#!/bin/bash

process=org.h2.tools.Server
pid=`ps axwww | grep java | grep ${process} | awk '{ print $1 };'`

if [ "${pid}x" = "x" ]
then
 echo "No H2 Server running."
else
    echo "Shutting down H2 Server process id: ${pid}"
    java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:9092 -tcpPassword badger
    echo "Finished shutting"
fi
