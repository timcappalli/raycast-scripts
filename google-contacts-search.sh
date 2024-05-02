#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Google Contacts Search
# @raycast.mode silent

# Optional parameters:
# @raycast.icon google-contacts.svg
# @raycast.argument1 { "type": "text", "placeholder": "name" }

# Documentation:
# @raycast.author Tim Cappalli
# @raycast.packageName me.timcappalli.raycast.search.googlecontacts

open "https://contacts.google.com/search/$1"
