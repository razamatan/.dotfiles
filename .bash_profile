#This file is sourced by bash when you log in interactively.

export THIS_BOX=`hostname | sed 's/\..*$//'`
export THIS_DOMAIN=`hostname -f | sed 's/.*\.\(.*\..*\)$/\1/'`

# for mac's we need to override the domain with mac
[ `uname` == 'Darwin' ] && export THIS_DOMAIN='mac'

# include bashrc
[ -f ~/.bashrc ] && . ~/.bashrc
