#!/bin/fish
tput civis
printf "\033[2J\033[H"
read -n 1 -P ""
tput cvvis
