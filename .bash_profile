# This file is sourced by bash when you log in interactively.

# $OSTYPE (linux-gnu, darwin13, solaris2.11)
# $HOSTTYPE (x86_64, i386)
# $MACHTYPE (x86_64-pc-linux-gnu, x86_64-apple-darwin13, i386-pc-solaris2.11)

case $OSTYPE in
   *solaris*)
      fqdn=`/usr/sbin/check-hostname | awk '{print $NF}'`
      ;;
   *)
      fqdn=`hostname -f`
esac
THIS_BOX=$(cut -d. -f1 <<< $fqdn)
THIS_DOMAIN=$(awk -F. 'NF>1{print $(NF-1)"."$NF} NF<2{print "retral.net"}' <<< $fqdn)
THIS_OS=`uname -s`
export THIS_BOX THIS_DOMAIN THIS_OS
unset fqdn

# include bashrc
[ -f ~/.bashrc ] && . ~/.bashrc
