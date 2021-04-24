# peertube-dl
Manage peertube Downloads(Torrents through Transmission)

#Produces html Page, with the Vidoes Listed:

./doChannel.sh recently Luke            -> prompts to select the exact Channel, when more than 1 Options are found

./doChannel.sh recently "Luke Smith"    -> when just this one Option is Found, the action is executed, without prompt

./doChannel.sh search Luke "RSS"

#Downloads from this List(add file name)
./doChannel.sh dl-list Luke <RSS-...>
./doChannel.sh dl-list Luke <recently-...>

#Downloads specific Video
./doChannel.sh dl Luke <videoid> <videotitle>
