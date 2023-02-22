#!/bin/bash
#
# This script is used to generate url list for all your downloaded music (works for yt music)
#
# HOW TO USE
#
# Navigate to folder containing the mp3 files:
# -› cd ~/storage/music
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/get-music-url-list.sh)

for i in *.mp3
  do echo $(mid3v2 -l "${i}" | grep TXXX=purl | cut -d'=' -f3-) >> ~/storage/music/.url-list.txt
done
