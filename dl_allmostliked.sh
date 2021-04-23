#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
BaseHost="videos.lukesmith.xyz"
wget -nv -O "mostliked-list.html" "${BaseSimpleURL}/${BaseHost}/videos/most-liked"
