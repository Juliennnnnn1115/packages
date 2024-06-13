#!/bin/sh
export LD_LIBRARY_PATH=$PWD/../:$LD_LIBRARY_PATH
nohup ./../dolphindb -console 0 -mode controller -home data -script dolphindb.dos -config config/controller.cfg -logFile log/controller.log -nodesFile config/cluster.nodes -clusterConfig config/cluster.cfg > controller.nohup 2>&1 &

