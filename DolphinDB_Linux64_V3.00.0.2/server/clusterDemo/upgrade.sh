#!/bin/bash
set -e
clear
#
#This script is used to upgrade DolphinDB

#download DolphinDB online
function Download_Online() {  
    #download package
    echo "Start to wget DolphinDB_Linux64_V${realease}.zip"
    wget "https://www.dolphindb.cn/downloads/DolphinDB_Linux64_V${realease}.zip"
    if [ -e ./DolphinDB_Linux64_V${realease}.zip ];then
        echo -e "DolphinDB package download succeeded!" "\033[32m DownLoadSuccess\033[0m"
    else
        echo -e "DolphinDB Package download failed. Please make sure you enter the right version number." "\033[31m DownLoadFailure\033[0m"
        echo ""
        sleep 1
        exit
    fi
          
}

#install DolphinDB offline
function INSTALL_DDB_OFFLINE() {

    if [ -e ./DolphinDB_Linux64_V${realease}.zip ];then
        echo -e "DolphinDB package uploaded successfully!" "\033[32m UpLoadSuccess\033[0m"
    else
        echo -e "Unable to find DolphinDB package of the specified version. Please upload the package to this directory." "\033[31m UpLoadFailure\033[0m"
        echo ""
        sleep 1
        exit
    fi
    #Unzip package
    unzip "DolphinDB_Linux64_V${realease}.zip" -d "v${realease}" > /dev/null 2>&1
    if [ -d ./v${realease} ];then
    echo -e "DolphinDB package unzipped successfully!" "\033[32m UnzipSuccess\033[0m"
    else
    echo -e "Unzip of DolphinDB package failed. Please check whether the package is complete." "\033[31m UnzipFailure\033[0m"
    echo ""
    sleep 1
    exit
    fi
    #upgrade DolphinDB package
    cd $(pwd)/v${realease}/server  
    rm -rf clusterDemo dolphindb.cfg dolphindb.lic startSingle.sh stopSingle.sh
    if [[ -d clusterDemo || -e dolphindb.cfg || -e dolphindb.lic || -e startSingle.sh  || -e stopSingle.sh ]];then
    echo -e "Please check whether the package downloaded is correct." "\033[31m UpgradeFailure\033[0m"
    echo ""
    sleep 5
    exit
    else
    /bin/cp -rf ./* ../../../
    echo -e "DolphinDB upgraded successfully!" "\033[32m UpgradeSuccess\033[0m"
    fi   
    #Delete DolphinDB package
    rm -rf ../../v${realease} ../../DolphinDB_Linux64_V${realease}.zip
}

#Check whether operating system is Linux
case $(uname -s) in
    Linux|linux) os=linux ;;
    *) os= ;;
esac

if [ -z "$os" ]; then
    echo "OS $(uname -s) not supported." >&2
    exit 1
fi

#Check whether you have shut down DolphinDB process and backed up metadata
echo "Tip: please shut down dolphindb process!"
echo "Tip: please back up metadata before upgrade!"

read -p "Have you shut down dolphindb process and backed up metadata?(y/n)" answer
if [[ ${answer} != "y" ]];then
   	echo "please shut down dolphindb process and back up metadata before upgrade!"
    exit 0;	
fi

#script menu
clear
echo "##########################################"
echo "#                                        #"
echo "#        upgrade  dolphindb               #"
echo "#                                        #"
echo "##########################################"

echo -e "\033[36m1: OnlineUpgrade dolphindb\033[0m"
echo -e "\033[36m2: OfflineUpgrade dolphindb\033[0m"
echo -e "\033[36m3: EXIT\033[0m"
cur_dir=$(pwd)
# Choose to install DolphinDB online or offline
read -p  "Please enter one of the following numbers to select the mode: 1 means online, 2 means offline, 3 means quit" SELECT

if [ "${SELECT}" == "1" ];then
        #Select upgrade version
        read -p "Please select upgrade version, e.g., 2.00.3 :" realease  
        Download_Online $realease     
        INSTALL_DDB_OFFLINE $realease
elif [ "${SELECT}" == "2" ];then
        #Select upgrade version
        read -p "Please select upgrade version, e.g., 2.00.3 :" realease
        INSTALL_DDB_OFFLINE $realease
elif [ "${SELECT}" == "3" ];then
        echo "you choose exit!"
        exit 1;
else
        echo "input Error! Place input{1|2|3}"
        exit 0;
fi

