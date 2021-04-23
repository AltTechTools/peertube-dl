#!/bin/sh
WorkDir=$(pwd)
BaseURL=$1
VidID=$2
PicID=$2
[ "$4" = "" ] ||  PicID=$4
VidTitle=$3
#echo "PIC ID: $PicID"
#exit
#echo "VidID: $VidID"
#echo "BaseURL: $BaseURL"
#echo "VidTitle: $VidTitle"
#exit
[ -d "$VidTitle" ] && rm -r "$VidTitle"
mkdir "$VidTitle"
cd "$VidTitle"
PIC=$(echo "$BaseURL/static/thumbnails/$PicID.jpg")
T1080p=$(echo "$BaseURL/download/torrents/$VidID-1080.torrent")
T720p=$(echo "$BaseURL/download/torrents/$VidID-720.torrent")
T720pHLS=$(echo "$BaseURL/download/torrents/$VidID-720-hls.torrent")
T480p=$(echo "$BaseURL/download/torrents/$VidID-480.torrent")
T360p=$(echo "$BaseURL/download/torrents/$VidID-360.torrent")
echo "$PicID" > PicID.txt
echo "$VidID" > VidID.txt
echo "$BaseURL" > BaseUrl.txt
echo "$VidTitle" > VidTitle.txt


wget -nv -O "$PicID.jpg" $PIC || echo "failed"
notify-send -i "${PWD}/${PicID}.jpg" "$VidTitle" "$PicID.jpDownloading Torrent Fileg"
wget -q -O "$VidID.torrent" $T1080p || wget -q -O "$VidID.torrent" $T720p || wget -q -O "$VidID.torrent" $T480p || wget -q -O "$VidID.torrent" $T360p || wget -q -O "$VidID.torrent" $T720pHLS || echo "Torrent download failed"
#[ -f "$VidID.torrent" ] && xdg-open "$VidID.torrent"
[ -f "$VidID.torrent" ] && /home/sgjdoomer/scripts/tools/transtorrentadd-custom.sh "$VidID.torrent"

cd "$WorkDir"
echo ""
