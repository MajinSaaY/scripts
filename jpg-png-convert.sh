#!/bin/zsh

# Convert all jpg to png.

# rename jpeg to jpg
for i in *.jpeg
   do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
   echo "${name} (jpeg > jpg)"
   mv "${name}.jpeg" "${name}.jpg"
done

# replace white space on filename
for file in *.jpg; do mv "$file" ${file// /_}; done

# convert jpg to png
for i in *.jpg
   do file=`echo "$i" | rev | cut -d'.' -f2- | rev`
   convert "${file}.jpg" "${file}.png"
   touch -r "${file}.jpg" "${file}.png"
   rm "${file}.jpg"
   echo "${file}.png done"
done
