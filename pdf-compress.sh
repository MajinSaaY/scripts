#!/bin/zsh

# Compress all pdf files within a folder.

# create empty lists
touch .list-pdf.txt .to-compress-pdf.txt .compressed-pdf.txt

# replace white space on filename
for file in *.pdf; do mv "$file" ${file// /_}; done

# create pdf file list
ls *.pdf | rev | cut -d'.' -f2- | rev > .list-pdf.txt

# create to-compress list
diff --suppress-common-lines .list-pdf.txt .compressed-pdf.txt | grep "^<\|^>" | sed "s/^. //g" > .to-compress-pdf.txt

# delete .list-pdf.txt
rm -f .list-pdf.txt

# compress and add to compressed
tocom=$(cat .to-compress-pdf.txt)
for file in $tocom
do
   gs -dQUIET -dNOPAUSE -dBATCH -dSAFER -dOverPrint=/simulate -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dEmbedAllFonts=true -dSubsetFonts=true -dAutoRotatePages=/None -dColorImageDownsampleType=/Bicubic -dColorImageResolution=150 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=150 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=150 -sOutputFile="${file}-new.pdf" "${file}.pdf"
   touch -r "${file}.pdf" "${file}-new.pdf"
   rm "${file}.pdf"
   mv "${file}-new.pdf" "${file}.pdf"
   echo "${file}.pdf done"
   echo "${file}" >> .compressed-pdf.txt
done

# delete .to-compress-pdf.txt
rm -f .to-compress-pdf.txt
