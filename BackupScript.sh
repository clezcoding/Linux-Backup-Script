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
mkdir -p /opt/Backup/{Webserver,Home,Backup-Other,}
PS3='Please choose an Option: '
options=("Webserver" "Home" "BackupWhatYouWant" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Webserver")
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/Backup/Webserver"
SOURCE="/var/www/html"
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
exit
	;;
	
        "Home")       
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
BACKUP_DIR="/opt/Backup/Home"
SOURCE="/home"
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
exit
	;;	
		 "BackupWhatYouWant")
	        read -p "Please enter the directory you want to backup: " directory
DATE=$(date +%Y-%m-%d-%H-%M-%-S)
mkdir /opt/Other-Backups
BACKUP_DIR="/opt/Backup-$directory"
SOURCE="$directory"
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
exit
	;;
			 "Quit")
	        exit
    esac
done