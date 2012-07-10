#!/bin/bash
nohup java -cp h2*.jar org.h2.tools.Server -tcp -tcpAllowOthers -tcpPassword badger >>nohup.out 2>&1 &
