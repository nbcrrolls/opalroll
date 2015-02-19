#!/bin/bash

EXEC="/usr/bin/mysqldump opaldb"

OUTPUTDIR=/share/backup/opal-db
FILENAME=$OUTPUTDIR/`date +%F`-backup.sql

echo Running the nightly backup 
echo "$EXEC > $FILENAME"

$EXEC > $FILENAME

echo Compressing file
/usr/bin/gzip $FILENAME


#binary dump of opal_db
cp -a /var/lib/mysql/opaldb $OUTPUTDIR/binarydump

find $OUTPUTDIR -maxdepth 1 -mtime +30 -type f -delete

# move 2+ months old backups to nas
#YEAR=`date +%Y`
# files=`find $OUTPUTDIR -type f -name "*backup.sql*" -mtime +60 -maxdepth 1 -print`
#for i in $files;
#do
#        mv $i /nas0/data1/backup/postgres_backup/$YEAR/
#done
#

