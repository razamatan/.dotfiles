bind-key '#' neww -n irc 'ssh -t mustafa.hopto.org irssi'
bind-key '&' neww -n dev -t 7
bind-key '*' neww -n 8003 -t 8

#  vim: set ft=tmux :
