#!/bin/bash


python ~/lisk-api/python2/helper.py -o peer_list > ban_list/peer_list.json
python ~/lisk-api/python2/json_to_csv.py peers ban_list/peer_list.json ban_list/peer_list.csv


sed 's/peer.*//' ban_list/peer_list.csv > ban_list/peer_list1.csv
sed 's/"//g' ban_list/peer_list1.csv > ban_list/peer_list2.csv
sed '/^\s*$/d'  ban_list/peer_list2.csv > ban_list/peer_list_clean.csv

while IFS= read -r line
do
grep -w "$line" ban_list/peer_list_clean.csv | awk -F',' '{system ("sudo ipset add excluded_list " $1)}'
done < "versions"
rm -rf ban_list/*
