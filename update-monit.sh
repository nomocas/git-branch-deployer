#!/bin/bash
# $1 : name, $2 : configurated monit.conf file path
echo "update monit as : $(whoami)"
cp $2 ~/monited/$1
chmod 640 ~/monited/$1
sudo service monit restart

