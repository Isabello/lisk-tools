#!/bin/bash
#initialize array variables and get current local node version

python ~/lisk-api/python2/helper.py -o  peer_version > ban_list/my_version.json
sed 's/,//g' ban_list/my_version.json > ban_list/my_version_clean.json

acceptable_version=`grep version ban_list/my_version_clean.json | awk -F': ' '{system ("echo " $2)}'`

#Get peerlist from local host
python ~/lisk-api/python2/helper.py -o peer_list > ban_list/peer_list.json

#Convert peerlist json to csv
python ~/lisk-api/python2/json_to_csv.py peers ban_list/peer_list.json ban_list/peer_list.csv

#Sanatize peerlist csv removing Quotes, Blank Lines and header
sed 's/peer.*//' ban_list/peer_list.csv > ban_list/peer_list1.csv
sed 's/"//g' ban_list/peer_list1.csv > ban_list/peer_list2.csv
sed '/^\s*$/d'  ban_list/peer_list2.csv > ban_list/peer_list_clean.csv

#Read in and ban unnacceptable versions

grep -v $acceptable_version ban_list/peer_list_clean.csv | awk -F',' '{system ("sudo ipset add excluded_list " $1)}'

#clean up files
rm -rf ban_list/*

#Read peerlist from login.lisk.io
python ~/lisk-api/python2/helper.py -o peer_list --url https://login.lisk.io > ban_list/peer_list.json

#Convert peerlist json to csv
python ~/lisk-api/python2/json_to_csv.py peers ban_list/peer_list.json ban_list/peer_list.csv

#Sanitize peerlist json into CSV removing header, quotes and blank lines
sed 's/peer.*//' ban_list/peer_list.csv > ban_list/peer_list1.csv
sed 's/"//g' ban_list/peer_list1.csv > ban_list/peer_list2.csv
sed '/^\s*$/d'  ban_list/peer_list2.csv > ban_list/peer_list_clean.csv

#read in acceptable versions to unban and unban them
grep -w "$acceptable_version" ban_list/peer_list_clean.csv | awk -F',' '{system ("sudo ipset del excluded_list " $1)}'
rm -rf ban_list/*
