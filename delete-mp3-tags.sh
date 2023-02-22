#!/bin/bash
#
# This script is used to delete some tags in all mp3 files within a folder.
# The process is straight foward with a single command to delete tags.
#
# HOW TO USE
#
# Navigate to folder containing the mp3 files:
# -› cd ~/storage/music
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/delete-mp3-tags.sh)

for i in *.mp3
  do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
  mid3v2 --delete-frame="COMM:ID3v1 Comment:eng,TALB,TCON,TDRC,TPE2,TRCK,TSSE,TXXX:comment,TXXX:Cover Artist,TXXX:description,TXXX:synopsis,TYER" "${name}.mp3"
  echo "${name}.mp3 done"
done
