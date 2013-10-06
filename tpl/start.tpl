#!/bin/bash
cd { root }/{ src }/
echo "starting : { root }/{ src }"
while read pid
do
    /bin/kill -9 "$pid"
done < { root }/node.pid
echo 'starting { root } ({ mode })'
source ~/.nvm/nvm.sh
nvm use { node }
echo "will fire : { root }/{ src }/index.js { args } --settings.port { port } --settings.mode { mode }"
nohup node { root }/{ src }/index.js { args } --settings.port { port } --settings.mode { mode } &
PID=$!
echo $PID > { root }/node.pid
#/etc/init.d/monit restart
exit
