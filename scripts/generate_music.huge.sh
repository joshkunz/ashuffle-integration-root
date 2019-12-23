#!/bin/bash

set -e

HUGE_LIBRARY_SIZE=20000         # 20k tracks
HUGE_LIBRARY_DEST=/music.huge/

declare -a REQUIRED_PACKAGES
REQUIRED_PACKAGES+=( "ffmpeg" "libmp3lame0" )
declare -a REQUIRED_LIBS
REQUIRED_LIBS+=( "mutagen" "attrs" )

apt-get install --no-install-recommends -y "${REQUIRED_PACKAGES[@]}"
pip3 install "${REQUIRED_LIBS[@]}" 

python3 /opt/helpers/generate-huge-library "${HUGE_LIBRARY_DEST}" "${HUGE_LIBRARY_SIZE}" 

pip3 uninstall -y "${REQUIRED_LIBS[@]}"
apt-get remove -y "${REQUIRED_PACKAGES[@]}"
apt-get autoremove -y
apt-get clean
