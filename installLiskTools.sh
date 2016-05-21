#!/bin/bash

default_tools_location=~
default_backup_location=~
default_lisk_location=~/lisk

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

sed -i "s|backup_home|$backup_location|g" "liskBackupMan.sh"
sed -i "s|lisk_home|$lisk_location|g" "liskBackupMan.sh"
sed -i "s|tools_home|$tools_location|g" "liskBackupMan.sh"

# Remove old crontab entry for autobackup
crontab -u $USER -l | grep -v 'liskBackupMan.sh'  | crontab -u $USER - 
