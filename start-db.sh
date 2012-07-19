#!/bin/bash
[ ! -z $DB_DIR ] || DB_DIR=/usr/local/database
cp h2*.jar $DB_DIR
cd $DB_DIR
nohup java -cp h2*.jar org.h2.tools.Server -tcp -tcpAllowOthers -tcpPassword badger >>nohup.out 2>&1 &
