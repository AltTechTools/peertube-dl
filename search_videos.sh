#!/bin/sh
#SEARCHURL=$(echo "https://videos.lukesmith.xyz/search?search=$1&searchTarget=local")
SEARCHURL=$(echo "https://simpleertube.metalune.xyz/${1}/search/$2")
#echo $SEARCHURL
wget -nv -O "$2-index.html" $SEARCHURL
grep -A 5 -B 0 "/thumbnails/" "$2-index.html" | grep "<a href="  | awk '{print $2}' FS='>' | sed 's/<\/a//'


