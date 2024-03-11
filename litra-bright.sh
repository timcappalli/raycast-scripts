#!/bin/bash

# Raycast Script Command Template
#
# Duplicate this file and remove ".template." from the filename to get started.
# See full documentation here: https://github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Litra Brightness
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 💡
# @raycast.packageName me.timcappalli.raycast.litra.bright

# @raycast.argument1 { "type": "text", "placeholder": "Brightness" }

litra brightness --percentage $1