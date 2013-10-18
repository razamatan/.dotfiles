#!/bin/sh

# keybpard repeat rate
xset r rate 200 40

# monitor
xset +dpms
xset s off

# korean input
ibus-daemon -d -x -r -n awesome

# awesome
.  /etc/X11/Sessions/awesome
