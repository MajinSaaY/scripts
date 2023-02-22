#!/bin/bash
#
# This script is used to check integrity of all mp4 files within a folder.
# The process is to recode video to null, forcing it to just read and report any errors.
#
# HOW TO USE
#
# Navigate to folder containing the mp4 files:
# -› cd ~/storage/movies
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/check-mp4-integrity.sh)

for i in *.mp4
  do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
  echo "$name"
  ffmpeg -v error -i "${name}.mp4" -f null - 2>"${name}.log"
  echo "${name} log:" >> error.log
  cat "${name}.log" >> error.log
  echo -e "\n" >> error.log
  find -name "${name}.log" -delete
  echo "${name}.mp4 done"
done
