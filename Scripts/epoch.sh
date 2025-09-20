#! /usr/bin/env bash

URL="https://project-epoch-status.com/api/status/realms"
was_online="false"

while true; do
    response=$(curl -s "$URL")
    is_online=$(echo "$response" | jq -r '.realms[] | select(.name=="Kezan") | .worldServerOnline')

    if [ "$is_online" = "true" ] && [ "$was_online" = "false" ]; then
        notify-send "Kezan Realm is Online"
        was_online="true"
    elif [ "$is_online" = "false" ]; then
        was_online="false"
    fi

    sleep 10
done
