#!/bin/bash
echo "starting : { root } ({ mode })"
while read pid
do
    sudo /bin/kill -9 "$pid"
done < { root }/node.pid
source ~/.nvm/nvm.sh
nvm use { node }
echo "will fire : { root }/{ src }/index.js { args } --settings.port { port } --settings.mode { mode }"
cd { root }/{ src }
nohup node ./index.js { args } --settings.port { port } --settings.mode { mode } &
PID=$!
echo $PID > { root }/node.pid
chmod 644 node.pid
exit

