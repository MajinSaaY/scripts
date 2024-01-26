#!/bin/zsh

# Delete some tags in all mp3 files within a folder.

for i in *.mp3
  do name=`echo "$i" | rev | cut -d'.' -f2- | rev`
  mid3v2 --delete-frame="COMM:ID3v1 Comment:eng,TALB,TCON,TDRC,TPE2,TRCK,TSSE,TXXX:comment,TXXX:Cover Artist,TXXX:description,TXXX:synopsis,TYER" "${name}.mp3"
  echo "${name}.mp3 done"
done
