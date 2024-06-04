#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Entra User Lookup
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon microsoft-entra-id.svg
# @raycast.packageName me.timcappalli.raycast.search.entraid

# Documentation:
# @raycast.description Look up Entra ID user
# @raycast.author Tim Cappalli

# @raycast.argument1 { "type": "text", "placeholder": "Username" }

username=$1

response=$(http POST https://login.microsoftonline.com/common/GetCredentialType\?mkt\=en-US username=$username --body --ignore-stdin)

if [[ $(echo $response | jq -r '.IfExistsResult') =~ ^1$ ]]
then
  echo "User not found"
  exit 0
else
  jq <<< $response
  exit 0
fi