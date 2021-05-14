#!/bin/sh

#    ytfetch scrapes YouTube channels and playlists based on a list of URLS contained
#    within a URL file.
#    Copyright (C) 2021 Dr. Scintist 
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License version 3 as
#    published by the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


if [[ -z $XDG_CONFIG_HOME  ]] ; then
    CONFIG_DIR=$HOME/.config
else
    CONFIG_DIR=${XDG_CONFIG_HOME}
fi

DOWNLOAD_DIR=$HOME/Videos/ytfetch
mkdir -p $DOWNLOAD_DIR

scrape() {
    #Download a channel's RSS information
    mkdir -p /tmp/ytfetch/
    INPUT="$1"
    if [ $(echo "$INPUT" | grep "playlist?list=") ] ; then
        PLAYLIST_ID="$(echo $INPUT | cut -d'=' -f 2 )"
        curl "https://www.youtube.com/feeds/videos.xml?playlist_id=${PLAYLIST_ID}" -o /tmp/ytfetch/videos.xml
        scrape_playlist $PLAYLIST_ID
    elif [ $(echo "$INPUT" | grep "/channel/") ] ; then
        CHANNEL_ID="$(echo $1 | cut -d'/' -f 5)"
        curl "https://www.youtube.com/feeds/videos.xml?channel_id=${CHANNEL_ID}" -o /tmp/ytfetch/videos.xml
        scrape_channel $CHANNEL_ID
    fi

}

scrape_playlist() {
    PLAYLIST_NAME="$(grep title /tmp/ytfetch/videos.xml | cut -d'>' -f 2 | cut -d'<' -f 1 | head -n1 )"
    mkdir -p "$DOWNLOAD_DIR/$PLAYLIST_NAME"
    cd "$DOWNLOAD_DIR/$PLAYLIST_NAME"
    youtube-dl "https://www.youtube.com/playlist?list=$1"
}

scrape_channel() {
    CHANNEL_NAME="$(grep name /tmp/ytfetch/videos.xml | cut -d'>' -f 2 | cut -d'<' -f 1 | head -n1 )"
    mkdir -p "$DOWNLOAD_DIR/$CHANNEL_NAME"
    cd "$DOWNLOAD_DIR/$CHANNEL_NAME"
    youtube-dl "https://www.youtube.com/channel/$1"
}

input="$CONFIG_DIR/ytfetch/urls"
while IFS= read -r line ; do
    scrape $line
done < $input
