#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Chrome with Flags
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon chrome-icon.svg
# @raycast.packageName me.timcappalli.raycast.chrome.flags

# @raycast.argument1 { "type": "dropdown", "placeholder": "Version", "data" : [{"title" : "Chrome", "value": "chrome"}, {"title" : "Chrome Beta", "value": "beta"}, {"title" : "Chrome Dev", "value": "dev"}, {"title" : "Chrome Canary", "value": "canary"}], "optional": false}
# @raycast.argument2 { "type": "dropdown", "placeholder": "Flag", "data" : [{"title" : "All WebAuthn Flags", "value": "allwebauthn"}, {"title" : "WebAuthn Hints", "value": "WebAuthenticationHints"}, {"title" : "WebAuthn Related Origins", "value": "WebAuthenticationRelatedOrigin"}, {"title" : "WebAuthn LargeBlob Extension", "value": "WebAuthenticationLargeBlobExtension"}], "optional": false}

if [ $2 = "allwebauthn" ]; then
  flag="WebAuthenticationHints,WebAuthenticationRelatedOrigin,WebAuthenticationLargeBlobExtension"
else
  flag=$2
fi

if [ $1 = "chrome" ]; then
  open /Applications/Google\ Chrome.app --args --enable-features=$flag
elif [ $1 = "beta" ]; then
  open /Applications/Google\ Chrome\ Beta.app --args --enable-features=$flag
elif [ $1 = "dev" ]; then
  open /Applications/Google\ Chrome\ Dev.app --args --enable-features=$flag
elif [ $1 = "canary" ]; then
  open /Applications/Google\ Chrome\ Canary.app --args --enable-features=$flag
else
  echo "No valid combos"
fi