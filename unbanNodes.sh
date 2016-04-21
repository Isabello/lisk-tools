#!/bin/bash


#Read peerlist from login.lisk.io
python ~/lisk-api/python2/helper.py -o peer_list --url https://login.lisk.io > ban_list/peer_list.json

#Convert peerlist json to csv
python ~/lisk-api/python2/json_to_csv.py peers ban_list/peer_list.json ban_list/peer_list.csv

#Sanitize peerlist json into CSV removing header, quotes and blank lines
sed 's/peer.*//' ban_list/peer_list.csv > ban_list/peer_list1.csv
sed 's/"//g' ban_list/peer_list1.csv > ban_list/peer_list2.csv
sed '/^\s*$/d'  ban_list/peer_list2.csv > ban_list/peer_list_clean.csv

#read in acceptable versions to unban and unban them
while IFS= read -r line
do
grep -w "$line" ban_list/peer_list_clean.csv | awk -F',' '{system ("sudo ipset del excluded_list " $1)}'
done < "unban_versions"

#cleanup files
rm -rf ban_list/*
