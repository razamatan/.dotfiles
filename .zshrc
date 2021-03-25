# .zshrc

# ensures env was originally setup correctly
[ $THIS_BOX ] || . ~/.dotfiles/.zshenv

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

alias redot ". ~/.zshrc"

# cd dirstack
DIRSTACKSIZE=${DIRSTACKSIZE:-15}
setopt autopushd pushdminus pushdsilent pushdtohome pushd_ignore_dups
d() {
   local dir
   select dir in $dirstack; do
      echo $dir
      break
   done
   [ -d $dir ] && cd $dir
}

# colors for ls, etc.
if command_exists dircolors ; then
   local DIR_COLORS=${DIR_COLORS:-/etc/DIR_COLORS}
   [ -r $DIR_COLORS ] && eval "`dircolors -b $DIR_COLORS`" || eval "`dircolors -b`"
fi

# shell options
ulimit -c 0             # cores are for imperfect people ;)
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space hist_no_store hist_verify share_history
HISTSIZE=5000
SAVEHIST=HISTSIZE
HISTORY_IGNORE="(&|l|l?|cd|[bf]g|exit|h *)"
h() { fc -lim "*$@*" 1 }

# prompt
if [ "$TERM" != 'dumb' ] && [ $USER != 'root' ] ; then
   setopt prompt_subst
   autoload -Uz vcs_info
   precmd_functions+=(vcs_info)
   RPROMPT=\$vcs_info_msg_0_
   zstyle ':vcs_info:*' enable git
fi

# xterm title

# completion
FIGNORE="~:.o:.swp"
autoload -Uz compinit
compinit
