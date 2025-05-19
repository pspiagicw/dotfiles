#!/bin/sh


alacritty --class system-window -e btm &


sleep 0.2s


alacritty --class system-window -e cava &

sleep 0.2s

alacritty --class system-window -e tty-clock -c -D &

sleep 0.2s

alacritty --class system-window -e sptlrx &



