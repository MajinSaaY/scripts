#!/bin/bash
#
# Script used to backup some dirs to rclone remote named 'Scrt' by using 'sync' option.
#
# HOW TO USE
#
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/rclone-backup.sh)

curdate=`date +%Y%m%d`
rclone sync -P --log-file=/data/data/com.termux/files/home/logs/rcsb-${curdate}.log --log-level INFO --create-empty-src-dirs Termux:home/storage/shared Scrt:Backup --filter-from /data/data/com.termux/files/home/.files.txt --backup-dir Scrt:Backup_old/$curdate

#Get keep list
echo "$(date +%Y%m%d)/" > ~/.keep.txt
for i in {1..6}
do
    echo "$(date +%Y%m%d -d "$(date) - $i day")/" >> ~/.keep.txt
done

#Purge old backup folders from Backup_old
rclone delete --rmdirs -P --log-file=/data/data/com.termux/files/home/logs/rcsb-${curdate}.log --log-level INFO --exclude-from /data/data/com.termux/files/home/.keep.txt Scrt:Backup_old

#Purge old logs
find ~/logs -mtime +7 -delete
