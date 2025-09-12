#!/bin/sh
vopono -v exec --custom-netns-name JPN --provider custom --custom /etc/wireguard/jpn-d4rk-JP-237.conf --protocol wireguard $*

