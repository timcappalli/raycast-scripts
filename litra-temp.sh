#!/bin/bash

# Raycast Script Command Template
#
# Duplicate this file and remove ".template." from the filename to get started.
# See full documentation here: https://github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Litra Temp
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 💡
# @raycast.packageName me.timcappalli.raycast.litra.temp

# @raycast.argument1 { "type": "text", "placeholder": "Color Temp" }

litra temperature --value $1