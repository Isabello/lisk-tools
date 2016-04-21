#!/bin/bash

#Get peerlist from local host
python ~/lisk-api/python2/helper.py -o peer_list > ban_list/peer_list.json

#Convert peerlist json to csv
python ~/lisk-api/python2/json_to_csv.py peers ban_list/peer_list.json ban_list/peer_list.csv

#Sanatize peerlist csv removing Quotes, Blank Lines and header
sed 's/peer.*//' ban_list/peer_list.csv > ban_list/peer_list1.csv
sed 's/"//g' ban_list/peer_list1.csv > ban_list/peer_list2.csv
sed '/^\s*$/d'  ban_list/peer_list2.csv > ban_list/peer_list_clean.csv

#Read in and ban unnacceptable versions
while IFS= read -r line
do
grep -w "$line" ban_list/peer_list_clean.csv | awk -F',' '{system ("sudo ipset add excluded_list " $1)}'
done < "versions"

#clean up files
rm -rf ban_list/*
