#!/bin/fish
curl \
    -H "Authorization: Bearer $(cat ~/hatoken)" \
    -H "Content-Type: application/json" \
    -X POST \
    http://192.168.1.137:8123/api/services/script/$argv
