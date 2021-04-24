#!/bin/sh
Action="$1"
BaseHost=$(./searchKnownChannel.sh "$2")||exit -1
#echo "$BaseHost"
#echo done

paramArr=()
for param in "$@"
do
  let "i+=1"
  case $i in
    1)
    ;;
    2)
    ;;
    *)
      paramArr+=("${param}")
    ;;
  esac
done
#echo "paramarr: ${#paramArr[@]}" 

case $Action in
  "search")
    ./search_videos.sh "$BaseHost" "${paramArr[@]}"
  ;;
  "dl"|"download")
    ./dlvideo.sh "$BaseHost" "${paramArr[@]}"
  ;;
  "dl-list"|"dllist")
    ./dlgetimage_torrent.sh "${paramArr[@]}"
  ;;
  "recently"|"dlrecently"|"recentlyadded")
    ./dl_recentlyadded.sh "$BaseHost"
  ;;
  "local")
    ./dl_allHostlocal.sh "$BaseHost"
  ;;
  "popular","mostliked")
    ./dl_allmostliked.sh "$BaseHost"
  ;;
  "trending")
    ./dl_alltrending.sh "$BaseHost"
  ;;
  *)
    echo "HELP"
    echo "Available Options: "
    echo "  search [Search-string] (Downloads the page listing the results)"
    echo "  download [videoid videotitle] (Downloads the specified video's torrent and adds it)"
    echo "  dl-list [listfile.html] (Downloads the Videos from the specified [previously downloaded] list)"
    echo "  recently [] (Downloads the page listing the recently added Videos)"
    echo "  local [] (Downloads the page listing the instances local Videos)"
    echo "  popular [] (Downloads the page listing the most liked Videos)"
    echo "  trending [] (Downloads the page listing the trending Videos)"
  ;;
esac

echo "paramarr: ${paramArr[@]}" 
