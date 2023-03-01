#!/bin/bash
#
# This script is used to generate url list for all your music from vimusic backup db
#
# HOW TO USE
#
# Navigate to folder containing the vimusic backup db file:
# -› cd ~/backups/vimusic
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/get-vimusic-url-list.sh)

for db in *.db
  do sqlite3 -csv "${db}" "select id from Song;" > vimusic.csv
done

songs=$(cat vimusic.csv)
for id in $songs
  do echo "https://music.youtube.com/watch?v=${id}" >> vimusic.txt
done

rm -f vimusic.csv
