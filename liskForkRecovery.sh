#!/bin/bash
while true; do
s1=`curl -s "http://127.0.0.1:7000/api/loader/status/sync"| jq '.height'`
sleep 50
s2=`curl -s "http://127.0.0.1:7000/api/loader/status/sync"| jq '.height'`


if [ "$s1" == "$s2" ]
then
echo "$s1" " " "$s2"
echo "Block Height is hung. Restoring from most recent backup"
cd /home/lisk/lisk/
bash lisk.sh rebuild
sleep 300

else
echo "" "$s1" " " "$s2"
echo "everything is fine"
sleep 10
fi

done
