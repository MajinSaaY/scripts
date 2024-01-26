#!/bin/zsh

# Generate url list for all your downloaded music (works for yt music)

for i in *.mp3
  do echo $(mid3v2 -l "${i}" | grep TXXX=purl | cut -d'=' -f3-) >> ~/storage/music/.url-list.txt
done
