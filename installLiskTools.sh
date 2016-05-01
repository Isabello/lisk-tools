#!/bin/bash

sudo apt-get -qqy install ipset

sudo ipset create excluded_list hash:net

cd ~

wget https://github.com/slasheks/lisk-api/archive/master.zip

unzip master.zip

mv lisk-api-master lisk-api

rm -f master.zip

cd lisk-api/python2/

wget https://raw.githubusercontent.com/vinay20045/json-to-csv/master/json_to_csv.py

cd ~

wget https://github.com/Isabello/Lisk_Management_Tools/archive/master.zip

unzip master.zip

mv Lisk_Management_Tools-master/ Lisk_Management_Tools

rm -f master.zip

cd Lisk_Management_Tools

mkdir ban_list
