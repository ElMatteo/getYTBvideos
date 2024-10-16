#!/bin/bash

#GOOGLE API KEY
API_KEY="YOU_API_KEY"

# https://www.streamweasels.com/tools/youtube-channel-id-and-user-id-convertor/
CHANNEL_ID="CHANNEL_ID"

VIDEOS_URL="https://www.googleapis.com/youtube/v3/search?key=$API_KEY&channelId=$CHANNEL_ID&part=snippet,id&order=date&maxResults=50"
RESPONSE=$(curl -s "$VIDEOS_URL")
ERROR_MESSAGE=$(echo "$RESPONSE" | jq -r '.error.message')
if [ "$ERROR_MESSAGE" != "null" ]; then
  echo "Erreur: $ERROR_MESSAGE"
  exit 1
fi
VIDEO_TITLES=$(echo "$RESPONSE" | jq -r '.items[] | select(.id.kind=="youtube#video") | .snippet.title')
if [ -z "$VIDEO_TITLES" ]; then
  echo "Aucun titre de vidéo trouvé."
else
  echo "$VIDEO_TITLES"
fi
