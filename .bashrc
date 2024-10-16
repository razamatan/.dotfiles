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
[ -f ~/.dotfiles/$THIS_BOX.env ] && . ~/.dotfiles/$THIS_BOX.env

# environment
[ -f ~/.dotfiles/functions ] && . ~/.dotfiles/functions
[ -f ~/.dotfiles/functions.$THIS_OS ] && . ~/.dotfiles/functions.$THIS_OS
[ -f ~/.dotfiles/functions.$THIS_DOMAIN ] && . ~/.dotfiles/functions.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/functions ] && . ~/.dotfiles.$THIS_DOMAIN/functions
[ -f ~/.dotfiles/environment ] && . ~/.dotfiles/environment
[ -f ~/.dotfiles/environment.$THIS_OS ] && . ~/.dotfiles/environment.$THIS_OS
[ -f ~/.dotfiles/environment.$THIS_DOMAIN ] && . ~/.dotfiles/environment.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/environment ] && . ~/.dotfiles.$THIS_DOMAIN/environment
[ -f ~/.dotfiles/aliases ] && . ~/.dotfiles/aliases
[ -f ~/.dotfiles/aliases.$THIS_OS ] && . ~/.dotfiles/aliases.$THIS_OS
[ -f ~/.dotfiles/aliases.$THIS_DOMAIN ] && . ~/.dotfiles/aliases.$THIS_DOMAIN
[ -f ~/.dotfiles.$THIS_DOMAIN/aliases ] && . ~/.dotfiles.$THIS_DOMAIN/aliases

# bash specific
[ -f ~/.dotfiles/functions.bash ] && . ~/.dotfiles/functions.bash
[ -f ~/.dotfiles/aliases.bash ] && . ~/.dotfiles/aliases.bash

# colors for ls, etc.
if command_exists dircolors ; then
   DIR_COLORS=${DIR_COLORS:-/etc/DIR_COLORS}
   [ -r $DIR_COLORS ] && eval "`dircolors -b $DIR_COLORS`" || eval "`dircolors -b`"
fi

# shell options
ulimit -c 0             # cores are for imperfect people ;)
shopt -s checkwinsize   # check window size changes every time
shopt -s histappend     # append to history file
HISTFILESIZE=5000
HISTIGNORE="&:l:l?:cd:[bf]g:exit:h *:history"
HISTCONTROL="ignoreboth"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# prompt
if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ]  && [ $USER != 'root' ] ; then
   export PS1="\$(hg_branch_prompt)\$(git_branch_prompt)\[\e[${PRMT_COLOR}m\]\h\[\e[0;31m\]<\[\e[0m\]\! \W\[\e[0;31m\]>\[\e[0m\]\$ "
fi

# completion
FIGNORE="~:.o:.swp"
if ! shopt -oq posix; then
  bashcomp_script='/etc/profile.d/bash_completion.sh'
  if [ -f /opt/local/$bashcomp_script ] ; then
     . /opt/local/$bashcomp_script
  elif [ -f $bashcomp_script ] ; then
     . $bashcomp_script
  elif [ -f /usr/share/bash-completion/bash_completion ] ; then
     . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ] ; then
     . /etc/bash_completion
  fi
  unset bashcomp_script
fi

command_exists direnv && eval "$(direnv hook bash)"

# host-specific overrides
[ -f ~/.dotfiles/$THIS_BOX ] && . ~/.dotfiles/$THIS_BOX

# vim: set ft=bash:
