#!/bin/bash

user="centos"
List="34.242.35.243 34.245.4.212 34.245.95.60 176.34.156.28 34.244.118.147"
hosts=($List)
maxConnectionAttempts=200
up=false
instance_up=false
index=1


while [[ $up == false && $index -le $maxConnectionAttempts ]]
do
   sleep 2
   up=true
   echo -e "\n\n\nWaiting for hosts up"
   echo "Try" $index
   echo "Hosts up?"
   for host in "${hosts[@]}"
   do
     ssh -oStrictHostKeyChecking=no -q -o "BatchMode=yes" $user@$host "exit" && instance_up=true || instance_up=false
     if test $instance_up = false; then
        up=false;
     fi
     echo "$host: $instance_up";
   done
   ((index++))
done

echo -e "\n\nAll Instances are up and running"
echo -e "\n"
