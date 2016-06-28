#AUTHOR: YPCR.com

#!/bin/bash
#cd /root/backups
#tar -cvf "backup_$(date +%Y%m%d_%H%M%S).tar.gz" /var/www/osticket
#mysqldump -u root -paltlan76 osticket | bzip2 -c > backupSQL$(date +%d-%m-%Y-%H.%M.%S).sql
#rsync -r /root/backups /media/synology

# backup osticket database
cd /root/backups
Now=$(date +%m-%d-%Y)
File=osticketdb-$Now.sql
echo "Backing up osticket database"
mysqldump -u root -p'enterMYSQLrootPW' osticketDBname  > $File
echo "Your Database osticket Successfully Completed"


echo "backing up osticket data"
tar -cvf "osticket-data_$(date +%m-%d-%Y).tar.gz" /var/www/osticket
echo "Your  osticket data and database  backup Successfully Completed"

