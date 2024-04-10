#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Android Mirroring
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon Android_Robot.svg
# @raycast.packageName me.timcappalli.raycast.android.mirroring

# @raycast.argument1 { "type": "dropdown", "placeholder": "Mode", "data" : [{"title" : "Mirror + Control", "value": "mc"}, {"title" : "Mirror + Audio", "value": "ma"},{"title" : "Mirror Only", "value": "m"}, {"title" : "Mirror + Control + Audio", "value": "mca"}], "optional": false}

if [ $1 = "mc" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --no-audio --keyboard=uhid
elif [ $1 = "m" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --no-audio
elif [ $1 = "mca" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60 --keyboard=uhid
elif [ $1 = "ma" ]; then
  scrcpy --video-codec=h265 --max-size=1920 --max-fps=60
else
  echo "No valid combos"
fi