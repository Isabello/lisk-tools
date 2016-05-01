#!/bin/bash

##create backup folder
mkdir -p ~/pg_backup

backup_db() {
## backup DB
sudo -u postgres pg_dumpall > ~/pg_backup/lisk_backup-`date '+%Y-%m-%d-%H.%M.%S'`
}

restore_db() {
## Restore DB

select FILENAME in ~/pg_backup/*;
        do
        case $FILENAME in
                "$EXIT" )
                echo "Exiting without restore"
                end
                ;;

                *)
                echo "Restore backup $FILENAME"
                restore_file=$FILENAME
                break
                ;;
        esac
done

bash ~/lisk-0.2.0-Linux-x86_64/lisk.sh stop

sudo -u postgres dropdb lisk_test
sudo -u postgres psql < $restore_file

bash ~/lisk-0.2.0-Linux-x86_64/lisk.sh start

}

list_backups() {
ls -ltra ~/pg_backup
}

case $1 in
"restore")
  restore_db
  ;;
"backup")
  backup_db
  ;;
"list")
  list_backups
  ;;
*)
  echo "Error: Unrecognized command."
  echo ""
  echo "Available commands are: list backup restore"
  ;;
esac

