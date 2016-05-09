#!/bin/bash

backup_location=backup_home
lisk_location=lisk_home

#Thanks Oliver for these pieces
export PATH="$lisk_location/bin:$lisk_location/pgsql/bin:$PATH"
export LD_LIBRARY_PATH="$lisk_location/pgsql/lib:$LD_LIBRARY_PATH"

UNAME=$(uname)
DB_USER=$USER
DB_NAME="lisk_test"
DB_PASS="password"
DB_DATA="$lisk_location/pgsql/data"
DB_LOG_FILE="$lisk_location/pgsql.log"

case "$UNAME" in
"Darwin")
  DB_SUPER=$USER
  ;;
"FreeBSD")
  DB_SUPER="pgsql"
  ;;
"Linux")
  DB_SUPER="postgres"
  ;;
*)
  echo "Error: Failed to detect platform."
  exit 0
  ;;
esac


create_user() {
 dropuser --if-exists "$DB_USER" &> /dev/null
 createuser --createdb "$DB_USER" &> /dev/null
 psql -qd postgres -c "ALTER USER "$DB_USER" WITH PASSWORD '$DB_PASS';" &> /dev/null
  if [ $? != 0 ]; then
    echo "X Failed to create postgres user."
    exit 0
  else
    echo "√ Postgres user created successfully."
  fi
}

create_database() {
  dropdb --if-exists "$DB_NAME" &> /dev/null
  createdb "$DB_NAME" &> /dev/null
  if [ $? != 0 ]; then
    echo "X Failed to create postgres database."
    exit 0
  else
    echo "√ Postgres database created successfully."
  fi
}

start_postgresql() {
  pg_ctl -D $DB_DATA -l $DB_LOG_FILE start &> /dev/null
  if [ $? != 0 ]; then
    echo "X Failed to start postgresql."
    exit 1
  fi
}

#End Thanks Oliver for these pieces

##DB Restore
restore_db() {

echo "Select snapshot to restore or type exit to quit"
select FILENAME in $backup_location/pg_backup/*;
        do
        case $FILENAME in
                "$EXIT" )
                echo "Exiting without restore"
                exit
                ;;

                *)
                echo "Restore backup $FILENAME"
                restore_file=$FILENAME
                break
                ;;
        esac
done

bash $lisk_location/lisk.sh stop

start_postgresql
sleep 2

create_user

create_database

gunzip -c $restore_file | psql -q -U "$DB_USER" -d "$DB_NAME" &> /dev/null

echo "Restore Complete!"

bash $lisk_location/lisk.sh start

}

##Remote DB Snap
remote_snap() {

echo "Select snapshot to grab or type exit to quit"
remote_servers=("https://downloads.lisk.io/lisk/test/blockchain.db.gz" "https://lisktools.io/backups/lisk_pg_backup.gz" "https://liskwallet.net/backup/lisk_pg_backup.gz")
select SERVER in "${remote_servers[@]}" ;
        do
        case $SERVER in
                "$EXIT" )
                echo "Exiting without restore"
                exit 0
                ;;

                *)
                rm -rf $backup_location/pg_backup/blockchain.db.gz &> /dev/null
                rm -rf $backup_location/pg_backup/lisk_pg_backup.gz &> /dev/null
                wget $SERVER -P $backup_location/pg_backup/
                echo "Grabbed Remote Backup!"
                break
                ;;
        esac
done
restore_db

}

list_backups() {
ls -ltrA $backup_location/pg_backup
}

case $1 in
"restore")
  restore_db
  ;;
"_backup")
  backup_db
  ;;
"list")
  list_backups
  ;;
"remote")
 remote_snap
 ;;
*)
  echo "Error: Unrecognized command."
  echo ""
  echo "Available commands are: list restore remote "
  ;;
esac

