#!/bin/zsh

# Crop thumbnails in all mp3 files within a folder.

for i in *.mp3
  do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
  ffmpeg -i "${name}.mp3" -an -vcodec copy "${name}.jpg"
  ffmpeg -i "${name}.jpg" -vf crop="'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'",scale="720:720" "${name}-new.jpg"
  ffmpeg -i "${name}.mp3" -i "${name}-new.jpg" -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" "${name}-new.mp3"
  touch -r "${name}.mp3" "${name}-new.mp3"
  rm -f "${name}.mp3" "${name}.jpg" "${name}-new.jpg"
  mv -f "${name}-new.mp3" "${name}.mp3"
  echo "${name}.mp3 done"
done
