# bindings
#bind '@' screen -t mail /home/jin/bin/mutt
bind '#' screen -t irc  ssh -t mustafa.hopto.org irssi

bind '&' screen -t dev 7
bind '*' screen -t 8003 8
#  vim: set ft=screen :
