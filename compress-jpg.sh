#!/bin/bash
#
# This script is used to compress all jpg/jpeg files within a folder.
#
# HOW TO USE
#
# Navigate to folder containing the jpg/jpeg files:
# -› cd ~/storage/dcim/camera
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/compress-jpg.sh)

#Create empty lists
touch .list-i.txt .to-compress-i.txt .compressed-i.txt

#Rename jpeg to jpg
for i in *.jpeg
do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
   echo "${name} (jpeg > jpg)"
   mv "${name}.jpeg" "${name}.jpg"
done

#Replace white space on filename
for file in *; do mv "$file" ${file// /_}; done

#Create jpg file list
ls *.jpg | rev | cut -d'.' -f2- | rev > .list-i.txt

#Create to-compress-i list
diff --suppress-common-lines .list-i.txt .compressed-i.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress-i.txt

#Compress and add to compressed-i
tocom=$(cat .to-compress-i.txt)
for file in $tocom
do
   convert -sampling-factor 4:2:0 -interlace Plane -quality 85 "${file}.jpg" "${file}-magic.jpg"
   rm "${file}.jpg"
   mv "${file}-magic.jpg" "${file}.jpg"
   echo "${file}.jpg done"
   echo "${file}" >> .compressed-i.txt
done
