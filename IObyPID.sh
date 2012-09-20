#! /bin/bash
while [ true ]
    do
        if [ -z "$1" ];
            then
                echo "Enter PID:"
                read -e PID 
                else
                PID=$1
        fi
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
