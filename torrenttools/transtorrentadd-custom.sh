#!/bin/sh

[ $(pgrep -x "transmission-da" | grep -c "") -gt 0 ] || (transmission-daemon && notify-send -i process-working "Starting Torrent Daemon ...")

Result=$(transmission-remote -a "$@" -g all -s -w "$PWD" && notify-send -i document-save-as.png "Transmission-Remote:" " - Torrent added")
notify-send -i "info" "Transmission-Remote Custom:" " - ${Result}"
