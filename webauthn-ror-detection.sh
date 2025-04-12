#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title WebAuthn Related Origins Detection
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔐
# @raycast.argument1 { "type": "text", "placeholder": "Relying Party ID", "name": "baseURL" }
# @raycast.packageName me.timcappalli.raycast.script.webauthnror

# Documentation:
# @raycast.description Check whether an RP ID has the WebAuthn well-known for related origins
# @raycast.author Tim Cappalli

# --- Configuration ---
# Timeout for curl request in seconds
CURL_TIMEOUT=10

# --- Script Logic ---
#!/usr/bin/env bash

# --- Configuration ---
# Timeout for curl request in seconds
CURL_TIMEOUT=10

# --- Script Logic ---

# Function to print usage instructions
usage() {
  echo "Usage: $0 <url>"
  echo "  <url>: The base URL (e.g., https://example.com or example.com)"
  exit 1
}

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: 'curl' command not found. Please install curl."
  exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "Error: 'jq' command not found. Please install jq for JSON pretty-printing."
  # Alternative: Could fallback to 'python -m json.tool' or just cat the file
  # echo "Install jq or modify the script to use an alternative JSON formatter."
  exit 1
fi


# Check if URL argument is provided
if [ -z "$1" ]; then
  usage
fi

# --- Input Processing ---
input_url="$1"

# Ensure URL starts with http:// or https:// for curl
if [[ ! "$input_url" =~ ^https?:// ]]; then
  echo "Warning: URL does not start with http:// or https://. Assuming https://."
  input_url="https://$(echo "$input_url" | sed 's#^/*##')" # Add https:// and remove leading slashes if any
fi

# Remove trailing slash(es) from the input URL if present
input_url=$(echo "$input_url" | sed 's#/*$##')

# Construct the target URL
target_url="${input_url}/.well-known/webauthn"

# --- Fetch and Process ---
echo "Fetching: $target_url"

# Create temporary files safely
# We need one for the body and one for the headers to reliably get content-type
# Alternatively, use -w '%{content_type}' but parsing can be tricky if body has newlines at end
body_file=$(mktemp)
header_file=$(mktemp)

# Ensure temporary files are cleaned up on exit (normal or error)
trap 'rm -f "$body_file" "$header_file"' EXIT

# Perform the curl request
# -s : Silent mode (no progress meter)
# -L : Follow redirects
# -o "$body_file" : Write body output to the temp file
# -D "$header_file" : Write headers to the header temp file
# -m "$CURL_TIMEOUT": Set a timeout
# --fail: Make curl return non-zero on server errors (4xx, 5xx) - helps detect non-200 early
http_status=$(curl -s -L --fail -w "%{http_code}" -o "$body_file" -D "$header_file" -m "$CURL_TIMEOUT" "$target_url")
curl_exit_code=$?

# Check curl exit code first
if [ $curl_exit_code -ne 0 ]; then
  # Check specific curl errors if needed (e.g., 22 for 4xx/5xx with --fail)
  # Or just print the generic message
   if [ $curl_exit_code -eq 22 ] && [ ! -z "$http_status" ] && [ "$http_status" -ne 200 ]; then
       echo "WebAuthn well-known not detected (Status: $http_status)"
   elif [ $curl_exit_code -eq 28 ]; then
        echo "WebAuthn well-known not detected (Error: Request timed out after $CURL_TIMEOUT seconds)"
   elif [ $curl_exit_code -eq 6 ]; then
        echo "WebAuthn well-known not detected (Error: Could not resolve host)"
   else
        echo "WebAuthn well-known not detected (Error: curl failed with exit code $curl_exit_code)"
   fi
  exit 0 # Exit gracefully as per requirement
fi

# Check HTTP status code (though --fail should catch non-2xx)
if [ "$http_status" -eq 200 ]; then
  # Extract Content-Type header (case-insensitive search, extract value)
  # Use awk to handle potential carriage returns and variations
  content_type=$(grep -i '^Content-Type:' "$header_file" | head -n 1 | awk -F': ' '{print $2}' | awk -F';' '{print $1}' | tr -d '[:space:]')

  # Check if Content-Type is application/json
  if [[ "$content_type" == "application/json" || "$content_type" == "text/html" ]]; then
    echo "Status: 200 OK, Content-Type: $content_type"
    echo "Response Body:"
    # Pretty print using jq
    if jq '.' "$body_file"; then
      # jq succeeded
      : # do nothing more
    else
      echo "Warning: jq failed to parse the JSON body. Displaying raw content:"
      cat "$body_file"
    fi
  else
    echo "WebAuthn well-known not detected (Status: 200 OK, but Content-Type is '$content_type', not 'application/json')"
  fi
else
  # This part might be redundant if --fail is used effectively, but acts as a fallback.
  echo "WebAuthn well-known not detected (Status: $http_status)"
fi

# No need for explicit rm -f here due to the trap
exit 0