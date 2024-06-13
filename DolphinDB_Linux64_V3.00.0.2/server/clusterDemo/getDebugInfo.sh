#!/bin/bash

function rmLink() {
    objcopy --remove-section .gnu_debuglink dolphindb
    objcopy --remove-section .gnu_debuglink libDolphinDB.so
}

function setupLink() {
    objcopy --strip-debug ../dolphindb
    objcopy --strip-debug ../libDolphinDB.so
    objcopy --add-gnu-debuglink ../dolphindb.debug ../dolphindb
    objcopy --add-gnu-debuglink ../libDolphinDB.so.debug ../libDolphinDB.so
}

function UnpackDebugInfo() {
    tar -xvzf $1 -C ../
    setupLink
}

read -p "Please enter current DolphinDB version: " version

# current only support Linux package. only store in cn website
DEBUGINFO_FNAME=DolphinDB_Linux64_V$version.debuginfo.tar.gz
DEBUG_DOWNLOAD_DIR=https://cdn.dolphindb.cn/downloads/debuginfo/$DEBUGINFO_FNAME

if [ -e $DEBUGINFO_FNAME ];then
    echo "DebugInfo package: $DEBUGINFO_FNAME found. try unpack..."
else
    echo "DebugInfo package: $DEBUGINFO_FNAME not found. try downloading..."
    wget $DEBUG_DOWNLOAD_DIR ./
fi

UnpackDebugInfo $DEBUGINFO_FNAME
