mkdir jpgOutputDir
mogrify -path jpgOutputDir -format jpg -flatten -resize 25% -quality 80 *.JPG
