
### Manual Install Instructions
You will need the following software:

IPSet - Install and create an ipset

sudo apt-get install ipset


sudo ipset create excluded_list hash:net



lisk-api tools (in home dir) by slaskeks: https://github.com/slasheks/lisk-api

install using the documenation on their page



json-to-csv by vinay20045: https://raw.githubusercontent.com/vinay20045/json-to-csv/master/json_to_csv.py

install by the following

cd ~/lisk-api/python2/

wget https://raw.githubusercontent.com/vinay20045/json-to-csv/master/json_to_csv.py



To install this tool run the following

cd ~

git clone https://github.com/isabello/lisk-ban-tool.git

cd lisk-ban-tool

mkdir ban_list


please ensure you have authenticated for sudo at this point as the script directly relies on it not prompting for password

to ban execute

bash banNodes.sh

to unban

execute bash unbanNodes.sh
