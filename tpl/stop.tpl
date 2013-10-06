#!/bin/bash
while read pid
do
    /bin/kill -9 "$pid"
done < { root }/node.pid
exit

