#!/bin/sh
WorkDir=$PWD
WorkDate="$(date +%Y%m%d)"
VidID=""
 
while read -r line
do
  echo "$line"
  wget -O rssfeed.xml "$line"
  #grep "<media:peerLink type=\"application/x-bittorrent\" " rssfeed.xml | grep "isDefault=\"true\"" | sed 's/<media:peerLink type="application\/x-bittorrent"//' | sed 's/isDefault="true"//' | sed 's/ //g' | sed 's/<//g' | sed 's/>//g' | awk '{print $2}' FS='"'
  #grep -e "<media:peerLink type=\"application/x-bittorrent\" " -e "<link>"  rssfeed.xml #| grep "isDefault=\"true\"" | sed 's/<media:peerLink type="application\/x-bittorrent"//' | sed 's/isDefault="true"//' | sed 's/ //g' | sed 's/<//g' | sed 's/>//g' | awk '{print $2}' FS='"'
  #grep -e "isDefault=\"true\"" -e "<link>" -e "<enclosure type=\"application/x-bittorrent\"" rssfeed.xml | sed 's/ //g' | sed 's/<link>//' | sed 's/<\/link>//' | sed 's/<media:peerLinktype="application\/x-bittorrent"href="//' | sed 's/"isDefault="true">//'
  #grep -e "<link>" -e "<enclosure type=\"application/x-bittorrent\"" rssfeed.xml | sed 's/ //g' | sed 's/<link>//' | sed 's/<\/link>//' | sed 's/<media:peerLinktype="application\/x-bittorrent"href="//' | sed 's/<enclosuretype="application\/x-bittorrent"url="//' | sed 's/"isDefault="true">//' | sed 's/"length="/{;}/' | awk '{print $1}' FS='{;}'| grep -e "/watch" -e ".torrent"
  [ -d "${WorkDate}" ] || mkdir "${WorkDate}"
  cd "$WorkDir"
  while read -r urlline
  do
    cd "$WorkDir"
    if [ $(echo "$urlline" | grep -c ".torrent") -gt 0 ]; then
      [ -f downloaded.list ] || touch downloaded.list
      if [ $(grep -c "${VidID}" downloaded.list) -lt 1 ]; then
        cd "$WorkDate"
        wget -nv -O "${VidID}.torrent" "$urlline"
        [ -f "${VidID}.torrent" ] && /home/sgjdoomer/scripts/tools/transtorrentadd-custom.sh "${VidID}.torrent"
        cd "${WorkDir}"
        echo "${VidID}" >> downloaded.list
        # test
        tac rssfeed.xml | grep -A 100 -m 1 "${VidID}"
      fi
    else
      VidID="$(echo "$urlline" | awk '{print $2}' FS='/videos/watch/')"
    fi
  done <<< $(grep -e "<link>" -e "<enclosure type=\"application/x-bittorrent\"" rssfeed.xml | sed 's/ //g' | sed 's/<link>//' | sed 's/<\/link>//' | sed 's/<media:peerLinktype="application\/x-bittorrent"href="//' | sed 's/<enclosuretype="application\/x-bittorrent"url="//' | sed 's/"isDefault="true">//' | sed 's/"length="/{;}/' | awk '{print $1}' FS='{;}'| grep -e "/watch" -e ".torrent")
  cd "$WorkDir"
  rm rssfeed.xml
done <<< $(grep -v "#" rssfeeds.list)
