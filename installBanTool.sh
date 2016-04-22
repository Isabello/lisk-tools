#!/bin/bash

sudo apt-get -qqy install ipset

sudo ipset create excluded_list hash:net

cd ~

git clone https://github.com/slasheks/lisk-api.git

cd lisk-api/python2/

wget https://raw.githubusercontent.com/vinay20045/json-to-csv/master/json_to_csv.py

cd ~

git clone https://github.com/isabello/lisk-ban-tool.git

cd lisk-ban-tool

mkdir ban_list
