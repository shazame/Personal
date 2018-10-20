mkdir outputDir
mogrify -path outputDir -format jpg -flatten -quality 80 *.png
