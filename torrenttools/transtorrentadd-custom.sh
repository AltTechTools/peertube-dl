#!/bin/sh
#kill $(ps -e | grep "transmission-da"  | awk '{print $1}')
#kill $(pgrep -x "transmission-da")
#pkill -x "transmission-da"
#[ $(ps -e | awk '{print $4}' | grep -c "CMD") -gt 0 ] && echo "true"
#[ $(ps -e | awk '{print $4}' | grep -c "transmission-da") -gt 0 ] && echo "true"
#[ $(ps -e | awk '{print $4}' | grep -c "transmission-da") -gt 0 ] || echo "false"

#[ $(ps -e | awk '{print $4}' | grep -c "transmission-da") -gt 0 ] || (transmission-daemon && notify-send "Starting Torrent Daemon ...")

#pgrep -x "transmission-da" || (transmission-daemon && notify-send "Starting Torrent Daemon ...")
[ $(pgrep -x "transmission-da" | grep -c "") -gt 0 ] || (transmission-daemon && notify-send -i process-working "Starting Torrent Daemon ...")

Result=$(transmission-remote -a "$@" -g all -s -w "$PWD" && notify-send -i document-save-as.png "Transmission-Remote:" " - Torrent added")
notify-send -i document "Transmission-Remote Custom:" " - ${Result}"
#rm "$@"
