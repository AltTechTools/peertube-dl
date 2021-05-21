#!/bin/sh
# Params:
# 1	BaseUrl (creator's peertube instance)
# 2	VidID (in url after /videos/watch/... )
# 3	VidTitle (The title to use for the Folder, doesn't need to be the original Title)
# 4	PicID [Optional; "" to not specify] (Thumbnail ID, often the same as VideoID, but can differ)
# 5	Handle Existing [Optional; "" to not specify] (Defines how to handle allready existing Folders)
#	  -Availbale Options: 'overwrite', 'timestamp'
WorkDir=$(pwd)
BaseURL="https://${1}"
#echo "$BaseURL"
#echo "exit"
#exit
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
case "$5" in 
  "overwrite")
    [ -d "$VidTitle" ] && rm -f -r "$VidTitle" || { echo "Can't remove old version"; exit -1; }
  ;;
  "timestamp")
    [ -d "$VidTitle" ] && VidTitle=$(echo "$(date +%Y%m%d)_${VidTitle}")
  ;;
  "always-timestamp")
    VidTitle=$(echo "$(date +%Y%m%d)_${VidTitle}")
  ;;
  *)
    [ -d "$VidTitle" ] && { echo "Directory allready exits"; exit -1; }
  ;;
esac

#echo "before mkdir"
mkdir "${VidTitle}/" || { echo "mkdir failed! exiting & skipping this Download ${VidID}/${VidTitle}"; exit; }
cd "$VidTitle" || { echo "cd failed! exiting & skipping this Download ${VidID}/${VidTitle}"; exit; }
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

TwgetOpt=$(echo "-q -O ${VidID}.torrent --no-check-certificate")
IwgetOpt=$(echo "-nv -O ${PicID}.jpg --no-check-certificate")
#echo ${IwgetOpt} $PIC
#exit

wget ${IwgetOpt} "${PIC}" || echo "failed to download Thumbnail"
#echo "after pic wget"
notify-send -i "${PWD}/${PicID}.jpg" "${VidTitle}" "${PicID}.jpg"
#echo "before torrent wget"
wget ${TwgetOpt} "${T1080p}" || wget ${TwgetOpt} "${T720p}" || wget ${TwgetOpt} "${T480p}" || wget ${TwgetOpt} "${T360p}" || wget ${TwgetOpt} "${T720pHLS}" || { echo "Torrent download failed"; exit 1; }
echo "after torrent wget"
#[ -f "$VidID.torrent" ] && xdg-open "$VidID.torrent"
[ -f "${VidID}.torrent" ] && /home/sgjdoomer/scripts/tools/transtorrentadd-custom.sh "${VidID}.torrent"
echo "after Torrent add"

cd "$WorkDir"
echo ""
