bind-key '&' neww -n dev -t 7 -c '#{pane_current_path}'
bind-key '*' neww -n 8003 -t 8 -c '#{pane_current_path}'

# vim: set ft=tmux :
