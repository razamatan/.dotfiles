#!/bin/sh
export XSESSION=awesome

# keybpard repeat rate
# use /etc/X11/xinit/xserverrc instead: -ardelay 275 -arinterval 25
#xset r rate 275 40

# monitor
#xset +dpms
#xset s off
#xrandr --rate 144
xrandr --output DP-1 --mode 5120x1440

. /etc/X11/xinit/xinitrc
