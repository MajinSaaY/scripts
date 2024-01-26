#!/bin/zsh

# Compress all png files within a folder.

# create empty lists
touch .list-png.txt .to-compress-png.txt .compressed-png.txt

# replace white space on filename
for file in *.png; do mv "$file" ${file// /_}; done

# create png file list
ls *.png | rev | cut -d'.' -f2- | rev > .list-png.txt

# create to-compress-png list
diff --suppress-common-lines .list-png.txt .compressed-png.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress-png.txt

# delete .list-png.txt
rm -f .list-png.txt

# compress and add to compressed-png
tocom=$(cat .to-compress-png.txt)
for file in $tocom
do
   convert -depth 24 -quality 00 "${file}.png" "${file}-magic.png"
   touch -r "${file}.png" "${file}-magic.png"
   rm "${file}.png"
   mv "${file}-magic.png" "${file}.png"
   echo "${file}.png done"
   echo "${file}" >> .compressed-png.txt
done

# delete .to-compress-png.txt
rm -f .to-compress-png.txt
