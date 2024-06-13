#!/bin/sh
export LD_LIBRARY_PATH=$PWD/../:$LD_LIBRARY_PATH
nohup ./../dolphindb -console 0 -mode agent -home data -script dolphindb.dos -config config/agent.cfg -logFile log/agent.log  > agent.nohup 2>&1 &

