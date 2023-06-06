#!/bin/bash

# Set your domain, host, API key, and API secret
domain="your-domain.com"
host="@"
APIKey="your-api-key"
APISecret="your-api-secret"

WanIP=$(curl -s "https://api.ipify.org")
GDIP=$(curl -s -X GET -H "Authorization: sso-key ${APIKey}:${APISecret}" "https://api.godaddy.com/v1/domains/${domain}/records/A/${host}" | cut -d'[' -f 2 | cut -d']' -f 1)

if [ "$WanIP" != "$GDIP" ] && [ "$WanIP" != "" ]; then
    curl -s -X PUT "https://api.godaddy.com/v1/domains/${domain}/records/A/${host}" -H "Authorization: sso-key ${APIKey}:${APISecret}" -H "Content-Type: application/json" -d "[{\"data\": \"${WanIP}\"}]"
fi
