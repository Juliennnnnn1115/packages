#!/bin/bash
ps -o ruser=userForLongName -e -o pid,ppid,c,time,cmd |grep dolphindb|grep -v grep|grep $USER| awk '{print $2}'| xargs kill -TERM
