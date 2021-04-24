#!/bin/sh
# Description
# Searches Channels.list for the String and returns the Matching Channel(or Instance) base URL
# No.	Parameters
# 1 	Search Term

MatchesList=$(awk '{print $2}' FS=';' Channels.list | grep "$1")
if [ $(echo "$MatchesList" | grep -c "") -gt 1 ]
then
   ChannelName=$(echo "$MatchesList" | dmenu -p "Select a Channel:")
else
  if [ $(echo "$MatchesList" | grep -c "") -lt 1 ]
  then
    exit -1
  else
    ChannelName=$MatchesList
  fi
fi

defChannel=$(grep "$ChannelName" Channels.list | awk '{print $1}' FS=';')
[ $(echo "$defChannel" | grep -c "") -eq 1 ] || exit -1
[ "$defChannel" = "" ] && exit -1
echo "$defChannel"
