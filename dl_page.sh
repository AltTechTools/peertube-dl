#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
#BaseHost="videos.lukesmith.xyz"
#PageName="recently-added"
BaseHost="$1"
PageName="$2"

wget -nv -O "${PageName}-${BaseHost}-list.html" "${BaseSimpleURL}/${BaseHost}/videos/${PageName}"
