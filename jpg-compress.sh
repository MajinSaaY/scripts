#!/bin/zsh

# Compress all jpg/jpeg files within a folder.

# create empty lists
touch .list-i.txt .to-compress-i.txt .compressed-i.txt

# rename jpeg to jpg
for i in *.jpeg
do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
   echo "${name} (jpeg > jpg)"
   mv "${name}.jpeg" "${name}.jpg"
done

# replace white space on filename
for file in *.jpg; do mv "$file" ${file// /_}; done

# create jpg file list
ls *.jpg | rev | cut -d'.' -f2- | rev > .list-i.txt

# create to-compress-i list
diff --suppress-common-lines .list-i.txt .compressed-i.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress-i.txt

# delete .list-i.txt
rm -f .list-i.txt

# compress and add to compressed-i
tocom=$(cat .to-compress-i.txt)
for file in $tocom
do
   convert -sampling-factor 4:2:0 -interlace Plane -quality 80 "${file}.jpg" "${file}-magic.jpg"
   touch -r "${file}.jpg" "${file}-magic.jpg"
   rm "${file}.jpg"
   mv "${file}-magic.jpg" "${file}.jpg"
   echo "${file}.jpg done"
   echo "${file}" >> .compressed-i.txt
done

# delete .to-compress-i.txt
rm -f .to-compress-i.txt
