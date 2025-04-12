#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quick CSR
# @raycast.mode silent 

# Optional parameters:
# @raycast.icon 🔑
# @raycast.argument1 { "type": "text", "placeholder": "Common Name" }
# @raycast.packageName me.timcappalli.raycast.quickcsr
# @raycast.needsConfirmation false

# Documentation:
# @raycast.author Tim Cappalli
# @raycast.authorURL https://timcappalli.me

cd ~/zWorkFolder
openssl req -nodes -newkey rsa:2048 -keyout $1.key -out $1.csr -subj "/CN=$1"
open .