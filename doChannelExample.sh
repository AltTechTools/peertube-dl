#!/bin/sh
#could also be looped through Channels.list --> do for automation 
./doChannel.sh search 'Luke Smith' "RSS" || echo "failed"

