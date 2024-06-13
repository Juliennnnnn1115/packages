#!/bin/bash
ps -o ruser=userForLongName -e -o pid,ppid,c,time,cmd |grep "mode controller"|grep -v grep|grep $USER| awk '{print $2}'| xargs kill -TERM
