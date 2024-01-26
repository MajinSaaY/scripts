#!/bin/zsh

# Compress all mp4 files within a folder. (x264)

# create empty lists
touch .list.txt .to-compress.txt .compressed.txt

# replace white space on filename
for file in *.mp4; do mv "$file" ${file// /_}; done

# create mp4 file list
ls *.mp4 | rev | cut -d'.' -f2- | rev > .list.txt

# create to-compress list
diff --suppress-common-lines .list.txt .compressed.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress.txt

# delete .list.txt
rm -f .list.txt

# compress and add to compressed
tocom=$(cat .to-compress.txt)
for file in $tocom
do
   ffmpeg -i "${file}.mp4" -map_metadata 0 -movflags +faststart -pix_fmt yuv420p -vcodec libx264 -preset veryfast -crf 24 -c:a aac -b:a 160k "${file}-recoded.mp4"
   touch -r "${file}.mp4" "${file}-recoded.mp4"
   rm "${file}.mp4"
   mv "${file}-recoded.mp4" "${file}.mp4"
   echo "${file}.mp4 done"
   echo "${file}" >> .compressed.txt
done

# delete .to-compress.txt
rm -f .to-compress.txt
