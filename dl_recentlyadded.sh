#!/bin/sh
BaseSimpleURL="https://simpleertube.metalune.xyz"
BaseHost="videos.lukesmith.xyz"
wget -nv -O "recentlyadded-list.html" "${BaseSimpleURL}/${BaseHost}/videos/recently-added"
