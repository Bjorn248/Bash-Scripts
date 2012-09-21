#! /bin/bash

# This bash script will print out the read and write disk IO for a particular running process. 
# You can either run the script with the PID as a parameter 
# (i.e. IObyPID.sh 15535) or enter it after you start the script (it will prompt you).

if [ -z "$1" ];
then
    echo "Enter PID:"
    read -e PID 
    else
    PID=$1
fi

while [ true ]
do
    R=$(echo `cat /proc/$PID/io` | cut -d' ' -f10)
    R=$(($R/1024));
    W=$(echo `cat /proc/$PID/io` | cut -d' ' -f12)
    W=$(($W/1024));
    sleep 1;
    R2=$(echo `cat /proc/$PID/io` | cut -d' ' -f10)
    R2=$(($R2/1024));
    W2=$(echo `cat /proc/$PID/io` | cut -d' ' -f12)
    W2=$(($W2/1024));
    rKB=$(($R2 - $R));
    wKB=$(($W2 - $W));
    echo "$rKB KB/s read $wKB KB/s write"
done
