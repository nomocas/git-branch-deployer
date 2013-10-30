#!/bin/bash
while read pid
do
    sudo /bin/kill -9 "$pid"
done < { root }/node.pid
exit

