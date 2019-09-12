bind-key '*' neww -n dev -t 8 -c '#{pane_current_path}'

# vim: set ft=tmux :
