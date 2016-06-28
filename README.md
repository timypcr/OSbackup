# OSbackup local & offsite backup for osTicket installs hosted on VPS & dedicated servers.

OSbackup is a backup solution for osTicket. This folder contains two scripts

- osTicket_local_backup.sh: this script will create a local backup of the Ostickets install directory and MySQL database. This script is intended to run via a daily cronjob.

- osTicket_remote_backup_pull.sh: is intended to run via a daily cronjob on a remote backup server (not running osTicket) It simply uses rsync & ssh to remotley copy the backups created by osTicket_local_backup.sh from the osTicket server. This script & below documentation assumes that access to the osTicket server can be esstalished from the remote server using ssh keys. 

## Warning
osTicket_local_backup.sh exposes both the MySQL database name & password in plain text. YOU MUST keep this script saved outside of the osTicket web directory for security reasons. Example /root/script.

## Required pacakges (both servers)
- rsync
- openssh
- bzip2

## Installation 

**osTicket Server setup**
create a directory for osTicket_local_backup.sh

```
# mkdir /root/script
# cd /root/script
```
create a directory to store the backups
```
# mkdir /root/backups
```

copy  osTicket_local_backup.sh to the newly created script folder.
Edit  osTicket_local_backup.sh to match your environment: 
```
# nano osTicket_local_backup.sh
```

- change enterMYSQLrootPW to the MySQL database password
- change osticketDBname to the name of your osTicket database.
- change /var/www/osTicket to the path of your osTicket install folder
- Save and exit

Make the script excutable

```
# chown +x osTicket_local_backup.sh
```

Set a cronjab to run osTicket_local_backup.sh


```
crontab -e
```
In this example we will run the script everyday at midight. 

```
00 00 * * * /root/script/./osTicket_local_backup.sh  #backup osTicket

```
Save and exit crontab

**remote server setup**
create a directory for osTicket_remote_backup_pull.sh

```
# mkdir/root/script
cd /root/script
```
create a directory to store the backups
```
# mkdir /root/backups
# cd /root/backups
# mkdir osTicket
```
copy  osTicket_remote_backup_pull.sh to the newly created script folder.
Edit osTicket_remote_backup_pull.sh to match your environment: 
```
# nano  osTicket_remote_backup_pull.sh
```
- change osTicket.example.com to the IP address or domain of your osTicket server.

Make the script excutable

```
# chown +x  osTicket_remote_backup_pull.sh
```

Set a cronjab to run osTicket_remote_backup_pull.sh


```
crontab -e
```
In this example we will run the script everyday at 2am


```
* 2 * * * /root/script/./osTicket_remote_backup_pull.sh  #sync osTicket backups

```

Save and exit crontab


## Credits

Timothy DeBarbora

## License

GNU GENERAL PUBLIC LICENSE 
