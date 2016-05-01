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

This is tool is in testing for banning Lisk nodes using IPSET that are running versions prior to 0.2.0 and are peered to your node.

NOTE1: This tool relies on your kernel supporting the use of IPSET

NOTE2: This tool requires that python be installed due to the external tools used.

### Tool usage

cd Lisk_Management_Tools

bash banTool.sh

You can check the results with:  sudo ipset list

### Automated install 

Change directory to your home folder

cd ~

wget https://raw.githubusercontent.com/Isabello/Lisk_Management_Tools/master/installLiskTools.sh

bash installLiskTools.sh

The tools are now installed.



