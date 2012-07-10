#!/bin/bash
if [ -f "nohup.out" ]; then
java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:9092 -tcpPassword badger
rm nohup.out
else
  echo "Sorry! No running H2 instances found"
fi
