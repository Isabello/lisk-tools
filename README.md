# Lisk Backup Tool

This tool will backup the PG database with a time stamp. You can also use it to restore the database from the same tool.

Usage:

Backup Database
bash liskBackupMan.sh backup

Restore Database
bash liskBackupMan.sh restore

List Backups
bash liskBackupMan.sh list

# Lisk-Ban-Tool Description

This is tool is in testing for banning Lisk nodes using IPSET that are running versions prior to 0.1.4 and are peered to your node.

NOTE: This install guide assumes you have git installed. Install it by running: sudo apt-get install git

NOTE2: This tool relies on your kernel supporting the use of IPSET

NOTE3: This tool requires that python be installed due to the external tools used.

### Automated install - To Do Rewrite Install Instructions

Change directory to your home folder

cd ~

wget https://raw.githubusercontent.com/Isabello/Lisk_Management_Tools/master/*

chmod 700 installBanTool.sh

bash installBanTool.sh

The tool is now installed.


### Tool usage

cd lisk-ban-tool

bash banTool.sh

You can check the results with:  sudo ipset list
