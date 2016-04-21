#!/bin/bash
mkdir ban_testing
python ~/lisk-api/python2/helper.py -o peer_list > ~/ban_testing/peer_list.json
python ~/lisk-api/python2/json_to_csv.py peers ~/ban_testing/peer_list.json ~/ban_testing/peer_list.csv


sed 's/peer.*//' ~/ban_testing/peer_list.csv > ~/ban_testing/peer_list1.csv
 sed 's/"//g' ~/ban_testing/peer_list1.csv > ~/ban_testing/peer_list2.csv
sed '/^\s*$/d'  ~/ban_testing/peer_list2.csv > ~/ban_testing/peer_list_clean.csv

while IFS= read -r line
do
grep $line ~/ban_testing/peer_list_clean.csv | awk -F',' '{system ("sudo ipset add excluded_list " $1)}'
done < "versions"
