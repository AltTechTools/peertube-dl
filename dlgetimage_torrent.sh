#!/bin/sh
# Parameters
# 1	Html Video List path
# 2	Optional Existing Handling, according to ./dlvideo.sh


#grep "/thumbnails/" RSS-index.html
#https://videos.lukesmith.xyz/download/torrents/d02433a8-0358-43b3-a5f3-77a91e1298eb-1080.torrent
#echo $1
if [ ! -f "$1" ]; then
  echo "file not valid"
  exit
fi
#echo "test"
TEXT=""
WorkDir=$(pwd)
#echo $WorkDir

while read -r line
do
#grep -B 1 "cd07b9a5-c27a-444a-b32a-dfd8368690e9" Seeking-index.html | grep -m 1 ""
#grep -B 1 "cd07b9a5-c27a-444a-b32a-dfd8368690e9" Seeking-index.html | grep -m 1 "" | sed 's/\/videos\/watch\//;/' | sed 's/<a href=\"\//https:\/\//' | sed 's/\">//'
    #echo "$line" | sed 's/<img src="//' | sed 's/\/static\/thumbnails\//;/g' | sed 's/.jpg" /;/g' | awk '{print $2,$1}' FS=';'
    TEXT=$(echo "$line" | sed 's/<img src="//' | sed 's/\/static\/thumbnails\//;/g' | sed 's/.jpg" /;/g' | awk '{print $2,$1}' FS=';')
    PicID=$(awk '{print $1}'<<<$TEXT)
    BaseURL=$(awk '{print $2}'<<<$TEXT | sed 's/https:\/\///')
#echo "--grep"
#grep -B 1 -A 3 "$PicID" $1 | grep -m 1 "/watch/"
#echo "++grep"
    TEXT2=$(grep -B 1 -A 3 "$PicID" $1 | grep -m 1 "/watch/" | sed 's/\/videos\/watch\//;/' | sed 's/<a href=\"\//https:\/\//' | sed 's/\">/;/' | sed 's/<\/a>//')
    #TEXT2=$(grep -B 1 "PicID" "$1" | grep -m 1 "")
    VidID=$(awk '{print $2}' FS=';'<<<$TEXT2)
    [ "$VidID" = "" ] && VidID=$PicID
    VidTitle=$(awk '{print $3}' FS=';'<<<$TEXT2)
    [ "$VidTitle" = "" ] && VidTitle=$(grep "$VidID\">." $1 | awk '{print $2}' FS='>' | sed 's/<\/a//')
    #echo "PicID: $PicID"
    #echo "VidID: $VidID"
    #echo "BaseURL: $BaseURL"
    #echo "VidTitle: $VidTitle"
    #echo "Text: $TEXT"
    #echo "Text2: $TEXT2"
    #echo ""
    #exit
    ./dlvideo.sh "$BaseURL" "$VidID" "$VidTitle" "$PicID" "$2"
    ##echo "VidID: $VidID"
    ##echo "BaseURL: $BaseURL"
    ##echo "VidTitle: $VidTitle"
    #mkdir "$VidTitle"
    #cd "$VidTitle"
    #PIC=$(echo "$BaseURL/static/thumbnails/$VidID.jpg")
    #T1080p=$(echo "$BaseURL/download/torrents/$VidID-108x0.torrent")
    #T720p=$(echo "$BaseURL/download/torrents/$VidID-720.torrent")
    #T480p=$(echo "$BaseURL/download/torrents/$VidID-480.torrent")
    #T360p=$(echo "$BaseURL/download/torrents/$VidID-360.torrent")
    ##COUNT="$COUNT 1"
    ##echo $COUNT
    #notify-send -i "stock_alert" " test:" " - $PIC"
    ##notify-send -i "$line" " test:" " - $line"
    #wget -nv -O "$VidID.jpg" $PIC || echo "failed"
    ##wget -q -O "$VidID.torrent" $T1080p || echo "Torrent download failed"
    #wget -q -O "$VidID.torrent" $T1080p || wget -q -O "$VidID.torrent" $T720p || wget -q -O "$VidID.torrent" $T480p || wget -q -O "$VidID.torrent" $T360p || echo "Torrent download failed"
    #[ -f "$VidID.torrent" ] && xdg-open "$VidID.torrent"
    #cd $WorkDir
  
done <<< $(grep "/thumbnails/" $1)
#exit
#echo '#mv "$1" "old_$1"'
mv "$1" "old_$1"
echo "renamed file to old_"
#echo $TEXT

#echo '<img src="https://videos.lukesmith.xyz/static/thumbnails/551a1bfb-8a05-4cdb-b5d3-a42758991d83.jpg" height="150"/>' | sed 's/<img src="//' | sed 's/\/static\/thumbnails\//;/g' | sed 's/.jpg" /;/g'
#https://videos.lukesmith.xyz/download/torrents/d02433a8-0358-43b3-a5f3-77a91e1298eb-1080.torrent

#wget -nv -O "$1-index.html"
