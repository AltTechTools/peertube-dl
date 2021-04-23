#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
BaseHost="videos.lukesmith.xyz"
wget -nv -O "trending-list.html" "${BaseSimpleURL}/${BaseHost}/videos/trending"
