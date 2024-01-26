#!/bin/zsh

# Generate url list for all your music from vimusic backup db

for db in *.db
  do sqlite3 -csv "${db}" "select id from Song;" > vimusic.csv
done

songs=$(cat vimusic.csv)
for id in $songs
  do echo "https://music.youtube.com/watch?v=${id}" >> vimusic.txt
done

rm -f vimusic.csv
