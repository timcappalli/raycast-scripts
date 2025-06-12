#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Android Mirroring
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon icons/android-robot.svg
# @raycast.packageName me.timcappalli.raycast.android.mirroring

# @raycast.argument1 { "type": "dropdown", "placeholder": "Mode", "data" : [{"title" : "Mirror + Control", "value": "mc"}, {"title" : "Mirror + Audio", "value": "ma"},{"title" : "Mirror Only", "value": "m"}, {"title" : "Mirror + Control + Audio", "value": "mca"}, {"title" : "Record: Video Only", "value": "rv"}, {"title" : "Record", "value": "v"}], "optional": false}

cd ~/zWorkFolder/

if [ $1 = "mc" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --no-audio --keyboard=uhid
elif [ $1 = "m" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --no-audio
elif [ $1 = "mca" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --keyboard=uhid
elif [ $1 = "ma" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60
elif [ $1 = "rv" ]; then
  scrcpy --no-audio --record=android-recording.mp4 --record-format=mp4 --max-size=1920 --max-fps=60 --show-touches
elif [ $1 = "r" ]; then
    scrcpy --no-audio --record=android-recording.mp4 --record-format=mp4 --max-size=1920 --max-fps=60 --show-touches
else
  echo "No valid combos"
fi