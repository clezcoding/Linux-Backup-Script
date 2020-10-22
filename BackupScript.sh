#!/bin/bash
echo "-------------------------------------------------------------"
echo " ____  _     _____ ____    ____  ____  ____  _  _      _____"
echo "/   _\/ \   /  __//_   \  /   _\/  _ \/  _ \/ \/ \  /|/  __/"
echo "|  /  | |   |  \   /   /  |  /  | / \|| | \|| || |\ ||| |  _"
echo "|  \_ | |_/\|  /_ /   /___|  \_ | \_/|| |_/|| || | \||| |_//"
echo "\____/\____/\____\\____/\/\____/\____/\____/\_/\_/  \|\____\ "
echo "                                                           "                                                           

echo "-------------------------------------------------------------"

 echo "$(tput setaf 1) This is my Backup Script.Your Backups are located in /opt/Backup/!
This Script ONLY makes a Backup of your files.
You have to download this backup via WinSCP or FileZilla after the script is finished"$(tput sgr0)
mkdir -p /opt/Backup/{Webserver,Home,Backup-Other,SQLBackup}
PS3='Please choose an Option: '
options=("Webserver" "Home" "Backup What You Want" "MQSQL Backup" "Import MQSQL Backup" "Import Webserver Backup" "Import Any Backup" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Webserver")
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/Backup/Webserver"
SOURCE="/var/www/html"
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
echo "Thanks for using my script."
exit
	;;
	
        "Home")       
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/Backup/Home"
SOURCE="/home"
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
echo "Thanks for using my script."
exit
	;;	
		 "Backup What You Want")
	        read -p "Please enter the directory you want to backup: " dir
			read -p "Please enter a name for the backup: " name
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/Backup/Backup-Other"
cd $dir
tar cfvz $name-$DATE.tar.gz * && mv $name-$DATE.tar.gz /opt/Backup/Backup-Other/
echo "Thanks for using my script."
exit
	;;
	
		 "MQSQL Backup")
	        read -p "Please enter your MQSQL admin username: " user
			read -p "Please enter your MQSQL admin password: " password
			read -p "Please enter the MQSQL database you want to backup: " database
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/SQLBackup"
mysqldump --no-tablespaces --host=localhost --user=$user --password=$password $database > $database-$DATE.sql 
mv $database-$DATE.sql /opt/Backup/SQLBackup/
echo "Thanks for using my script."
exit
	;;
	
		 "Import MQSQL Backup")
	        read -p "Please enter your MQSQL admin username: " user
			read -p "Please enter your MQSQL admin password: " password
			read -p "Please enter the name for the new MQSQL database " database
			mysql -e "CREATE DATABASE '$database';"
			read -p "Please enter the name of the Backup you want to import(Please the full file name without .sql!! " databasename
			
mysql --host=localhost --user=$user --password=$password $database < $databasename.sql 
echo "Thanks for using my script."
exit
	;;
	
	"Import Webserver Backup")
	        read -p "Enter the filename of your Backup File without the .zip: " filename
			cd /var/www/html/test
			tar -xvzf $filename
			echo "Thanks for using my script."
exit
	;;
	
		"Import Home Backup")
	        read -p "Enter the filename of your Backup File without the .zip: " filename
			cd /var/www/html/test/web
			tar -xvzf $filename
			echo "Thanks for using my script."
exit
	;;
	
			"Import Any Backup")
			cd /opt
			cp -r * /root
			read -p "Enter the directory where the Backup is located:" backuplocation
			cd $backuplocation
	        read -p "Enter the filename of your Backup File with the file type(.tar.gz) " filename
			read -p "Enter the directory with slashes where you want to import your Backup: " dir
			mv $filename $dir/
			cd $dir
			tar -xvzf $filename
			echo "Thanks for using my script."
exit
	;;
			 "Quit")
	        exit
    esac
done
