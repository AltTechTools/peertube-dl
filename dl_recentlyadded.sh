#!/bin/sh
#BaseSimpleURL="https://simpleertube.metalune.xyz"
#BaseHost="videos.lukesmith.xyz"
BaseHost="$1"
PageName="recently-added"
./dl_page "${BaseHost}" "${PageName}"
