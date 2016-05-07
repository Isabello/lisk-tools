#!/bin/bash

default_tools_location=~
default_backup_location=~
default_lisk_location=~/lisk-0.2.1-Linux-x86_64
REPLY=Y

read -r -p "Where do you want to install to? (Default $default_tools_location):  " tools_location
tools_location=${tools_location:-$default_tools_location}
if [[ ! -r "$tools_location" ]]
then
echo "$tools_location is not valid, please check and re-excute"
exit 2;
fi


read -r -p "Where do you want backups to go? (Default $default_backup_location):  " backup_location
backup_location=${backup_location:-$default_backup_location}
if [[ ! -r "$backup_location" ]]
then
echo "$backup_location is not valid, please check and re-excute"
exit 2;
fi

read -r -p "Where do you have lisk installed to? (Default $default_lisk_location):  " lisk_location
lisk_location=${lisk_location:-$default_lisk_location}
if [[ ! -r "$lisk_location" ]]
then
echo "$lisk_location is not valid, please check and re-excute"
exit 2;
fi


#read -p "Do you want to install the Ban Tool? Y or N: " -n 1 -r -i "N"
#if [[ $REPLY =~ ^[Yy]$ ]]
#then

#sudo apt-get -qqy install ipset

#sudo ipset create excluded_list hash:net

#cd $tools_location

#wget https://github.com/slasheks/lisk-api/archive/master.zip

#unzip master.zip

#mv lisk-api-master lisk-api

#rm -f master.zip

#cd lisk-api/python2/

#wget https://raw.githubusercontent.com/vinay20045/json-to-csv/master/json_to_csv.py

#fi

rm -rf $tools_location/Lisk_Management_Tools &> /dev/null
rm -rf $tools_location/lisk-tools &> /dev/null

cd $tools_location

wget https://github.com/Isabello/lisk-tools/archive/master.zip

unzip master.zip

mv lisk-tools-master/ lisk-tools

rm -f master.zip

cd lisk-tools

mkdir -p $tools_location/lisk-tools/ban_list
mkdir -p $backup_location/pg_backup

sed -i "s|backup_location|$backup_location|g" "liskBackupMan.sh"
sed -i "s|lisk_home|$lisk_location|g" "liskBackupMan.sh"
sed -i "s|tools_location|$tools_location|g" "liskBackupMan.sh"

read -r -p -n 1 "Do you want to automatically take backups? (Default Y): " $REPLY
REPLY=${REPLY:-$REPLY}
if [[  $REPLY =~ ^[Yy]$ ]]
then
bash $tools_location/lisk_tools/liskBackupMan.sh schedule
fi

read -r -p -n 1 "Do you want to automatically recover from forks? (Default Y): " $REPLY
REPLY=${REPLY:-$REPLY}
if [[  $REPLY =~ ^[Yy]$ ]]
then
sudo apt-get install jq curl
nohup tools_location/liskForkRecovery.sh 0<&- &>/dev/null &

fi

sed -i "s|lisk_home|$lisk_location|g" "liskForkRecovery.sh"
