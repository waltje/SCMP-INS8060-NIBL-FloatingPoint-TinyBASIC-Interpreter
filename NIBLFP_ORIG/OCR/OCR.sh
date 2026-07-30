#!/bin/bash
input="niblfp"
output="tessed"
ocr_text="NIBLFP.ocr"
if [ -e "$ocr_text" ]
then
   rm -fv "$ocr_text"
fi
touch $ocr_text
ls -al $ocr_text
seite=0
for i in {0001..0012}
do
   echo -n "loop $i "
   magick "$input$i.jpg" -crop +236+118 -crop -354-0 cropped.png
   magick cropped.png -units PixelsPerInch -density 300 -monochrome "$input$i.tif"
   tesseract  --psm 6 "$input$i.tif" "$output$i" -l hex
   ((seite=seite+1))
   echo "Page $seite" >> $ocr_text
   cat "$output$i.txt" >> $ocr_text
   rm -fv "$input$i.tif"
   rm -fv "$output$i.txt"
done
rm -fv cropped.png

