#!/bin/zsh
#
# This script is used to resize (vertically) and compress all mp4 files within a folder. (x264)
#
# HOW TO USE
#
# Navigate to folder containing the mp4 files:
# -› cd ~/storage/dcim/camera
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/resize-mp4-720p-vertical.sh)

#Create empty lists
touch .list.txt .to-compress.txt .compressed.txt

#Replace white space on filename
for file in *; do mv "$file" ${file// /_}; done

#Create mp4 file list
ls *.mp4 | rev | cut -d'.' -f2- | rev > .list.txt

#Create to-compress list
diff --suppress-common-lines .list.txt .compressed.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress.txt

#Compress and add to compressed
tocom=$(cat .to-compress.txt)
for file in $tocom
do
   ffmpeg -i "${file}.mp4" -vcodec libx264 -preset veryfast -crf 22 -vf scale=720:-2 "${file}-recoded.mp4"
   rm "${file}.mp4"
   mv "${file}-recoded.mp4" "${file}.mp4"
   echo "${file}.mp4 done"
   echo "${file}" >> .compressed.txt
done
