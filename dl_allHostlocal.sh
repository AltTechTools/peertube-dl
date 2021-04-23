#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
BaseHost="videos.lukesmith.xyz"
wget -nv -O "local-list.html" "${BaseSimpleURL}/${BaseHost}/videos/local"
