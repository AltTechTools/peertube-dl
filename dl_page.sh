#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
#BaseHost="videos.lukesmith.xyz"
#PageName="recently-added"
BaseHost="$1"
PageName="$2"

HtmlName=$(./getChanelPageName.sh "${BaseHost}" "${PageName}")

#echo "Test htmlname: ${HtmlName}"

wget -nv -O "${HtmlName}" --no-check-certificate  "${BaseSimpleURL}/${BaseHost}/videos/${PageName}"
