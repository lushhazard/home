#!/bin/fish
vopono -v exec --custom-netns-name QBIT --provider custom --custom $argv --protocol wireguard --custom-port-forwarding protonvpn --port-forwarding-callback ~/scripts/qbitport.sh qbittorrent
