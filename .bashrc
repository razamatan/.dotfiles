# .bashrc
unset -f alias
unalias -a

# global definitions
#[ -f /etc/profile ] && . /etc/profile
#[ -f /etc/bashrc ] && . /etc/bashrc
#[ -f /etc/bash/bashrc ] && . /etc/bash/bashrc

# load up THIS_BOX THIS_DOMAIN THIS_OS
[ $THIS_BOX ] || . ~/.dotfiles/.bash_profile

# host specific (mainly for colors)
[ -f ~/.dotfiles/$THIS_BOX ] && . ~/.dotfiles/$THIS_BOX

# environment
[ -f ~/.dotfiles/functions ] && . ~/.dotfiles/functions
[ -f ~/.dotfiles/functions.$THIS_OS ] && . ~/.dotfiles/functions.$THIS_OS
[ -f ~/.dotfiles/functions.$THIS_DOMAIN ] && . ~/.dotfiles/functions.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/functions ] && . ~/.dotfiles.$THIS_DOMAIN/functions
[ -f ~/.dotfiles/environment.$THIS_OS ] && . ~/.dotfiles/environment.$THIS_OS
[ -f ~/.dotfiles/environment ] && . ~/.dotfiles/environment
[ -f ~/.dotfiles/environment.$THIS_DOMAIN ] && . ~/.dotfiles/environment.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/environment ] && . ~/.dotfiles.$THIS_DOMAIN/environment
[ -f ~/.dotfiles/aliases ] && . ~/.dotfiles/aliases
[ -f ~/.dotfiles/aliases.$THIS_OS ] && . ~/.dotfiles/aliases.$THIS_OS
[ -f ~/.dotfiles/aliases.$THIS_DOMAIN ] && . ~/.dotfiles/aliases.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/aliases ] && . ~/.dotfiles.$THIS_DOMAIN/aliases

# colors for ls, etc.
DIR_COLORS=${DIR_COLORS:-/etc/DIR_COLORS}
#DIR_COLORS=${DIR_COLORS:-~/.dotfiles/dircolors.ansi-universal}
[ -f $DIR_COLORS ] && hash dircolors 2>&- && eval `dircolors -b $DIR_COLORS`

# shell options
ulimit -c 0             # cores are for imperfect people ;)
shopt -s checkwinsize   # check window size changes every time
shopt -s histappend     # append to history file
HISTFILESIZE=5000
HISTIGNORE="&:l:l?:cd:[bf]g:exit:h *:history"
HISTCONTROL="ignoreboth"
FIGNORE=".o:~:.swp"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# prompt
if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ]  && [ $USER != 'root' ] ; then
   export PS1="\$(hg-branch-prompt)\$(git-branch-prompt)\[\e[${BASH_COLOR}m\]\h\[\e[0;31m\]<\[\e[0m\]\! \W\[\e[0;31m\]>\[\e[0m\]\$ "
fi

# xterm title
[ $SSH_TTY ] && IS_SSH="[ssh] "
case $TERM in
   rxvt|*term|xterm*)
      PROMPT_COMMAND='echo -ne "\033]0;${IS_SSH}${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}\007"'
   ;;
   screen)
      PROMPT_COMMAND='echo -ne "\033_${IS_SSH}${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
   ;;
esac

# color term attempt
if [ "$COLORTERM" == "gnome-terminal" ] ; then
  export TERM='xterm-256color'
fi
# specific for mac
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] ; then
   update_terminal_cwd() {
      # Identify the directory using a "file:" scheme URL,
      # including the host name to disambiguate local vs.
      # remote connections. Percent-escape spaces.
      local SEARCH=' '
      local REPLACE='%20'
      local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
      printf '\e]7;%s\a' "$PWD_URL"
   }
   export TERM='xterm-256color'
   PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

# bash completion
bashcomp_script='/etc/profile.d/bash_completion.sh'
if hash brew 2>&- && [ -f `brew --prefix`$bashcomp_script ] ; then
   . `brew --prefix`$bashcomp_script
elif [ -f /opt/local/$bashcomp_script ] ; then
   . /opt/local/$bashcomp_script
elif [ -f $bashcomp_script ] ; then
   . $bashcomp_script
elif [ -f /etc/bash_completion ] ; then
   . /etc/bash_completion
fi
unset bashcomp_script

# vim: set ft=sh:
