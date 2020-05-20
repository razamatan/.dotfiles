bind-key '*' neww -n dev -t 8 -c '#{pane_current_path}'
bind-key '$' switch-client -Tremote
bind-key -Tremote '!' neww 'ssh jung'
bind-key -Tremote '1' neww 'ssh fromm'

# vim: set ft=tmux :
