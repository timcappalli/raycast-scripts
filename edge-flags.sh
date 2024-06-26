#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edge with Flags
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon icons/edge-icon.svg
# @raycast.packageName me.timcappalli.raycast.edge.flags

# @raycast.argument1 { "type": "dropdown", "placeholder": "Version", "data" : [{"title" : "Stable", "value": "edge"}, {"title" : "Beta", "value": "beta"}, {"title" : "Dev", "value": "dev"}, {"title" : "Canary", "value": "canary"}], "optional": false}
# @raycast.argument2 { "type": "dropdown", "placeholder": "Flag", "data" : [{"title" : "All WebAuthn Flags", "value": "allwebauthn"}, {"title" : "WebAuthn Hints", "value": "WebAuthenticationHints"}, {"title" : "WebAuthn Related Origins", "value": "WebAuthenticationRelatedOrigin"}, {"title" : "WebAuthn LargeBlob Extension", "value": "WebAuthenticationLargeBlobExtension"}, {"title": "WebAuthn JSON Serialization", "value": "WebAuthenticationJSONSerialization"], "optional": false}

if [ $2 = "allwebauthn" ]; then
  flag="WebAuthenticationHints,WebAuthenticationRelatedOrigin,WebAuthenticationLargeBlobExtension,WebAuthenticationJSONSerialization"
else
  flag=$2
fi

if [ $1 = "edge" ]; then
  open /Applications/Microsoft\ Edge.app --args --enable-features=$flag
elif [ $1 = "beta" ]; then
  open /Applications/Microsoft\ Edge\ Beta.app --args --enable-features=$flag
elif [ $1 = "dev" ]; then
  open /Applications/Microsoft\ Edge\ Dev.app --args --enable-features=$flag
elif [ $1 = "canary" ]; then
  open /Applications/Microsoft\ Edge\ Canary.app --args --enable-features=$flag
else
  echo "No valid combos"
fi
