#!/bin/sh
#SEARCHURL=$(echo "https://videos.lukesmith.xyz/search?search=$1&searchTarget=local")
SEARCHURL=$(echo "https://simpleertube.metalune.xyz/videos.lukesmith.xyz/search/$1")
#echo $SEARCHURL
wget -nv -O "$1-index.html" $SEARCHURL
grep -A 5 -B 0 "/thumbnails/" "$1-index.html" | grep "<a href="  | awk '{print $2}' FS='>' | sed 's/<\/a//'


