#!/bin/zsh

# Check integrity of all mp4 files within a folder.

for i in *.mp4
  do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
  ffmpeg -v error -i "${name}.mp4" -f null - 2>"${name}.log"
  echo "${name} log:" >> error.log
  cat "${name}.log" >> error.log
  echo -e "\n" >> error.log
  find -name "${name}.log" -delete
  echo "${name}.mp4 done"
done
