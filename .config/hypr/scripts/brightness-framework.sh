#!/usr/bin/bash

readonly command=$1

case $command in

"up")
    if [ $(brightnessctl g) -lt 13 ]; then
        $(brightnessctl s 1%+)
    else
        brightnessctl s 5%+
    fi
    ;;

"down")
    if [ $(brightnessctl g) -le 13 ]; then
        brightnessctl s 1%-
    else
        brightnessctl s 5%-
    fi
    ;;

*)
    echo "No command specified."
    echo -e "\nAvailable commands :\n
        up \n
        down"
    exit 1
    ;;
esac
