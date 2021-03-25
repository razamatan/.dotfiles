pushd() {
   export DIRMAX=${DIRMAX:-15}
   local verbose=0
   local ret
   if [ "$1" == "-v" ] ; then
      verbose=1
      shift
   fi
   if [ $# -eq 0 ] ; then
      builtin cd
      ret=$?
      builtin pushd -n $OLDPWD > /dev/null
   elif [ "$1" == "-" ] ; then
      builtin cd -
      ret=$?
      builtin pushd -n $OLDPWD > /dev/null
   else
      builtin pushd "$@" > /dev/null
      ret=$?
   fi
   local len=${#DIRSTACK[@]}
   for i in `seq 1 $len`; do
      eval p=~$i
      if [ "$p" = "$PWD" ] ; then
         builtin popd -n +$i > /dev/null
         break
      fi
   done
   [ $len -gt $DIRMAX ] && builtin popd -n -0 > /dev/null
   [ $verbose -eq 1 ] && builtin dirs -v
   return $ret
}

popd() {
   local verbose=0
   if [ "$1" == "-v" ] ; then
      verbose=1
      shift
   fi
   builtin popd "$@" > /dev/null
   local ret=$?
   [ $verbose -eq 1 ] && builtin dirs -v
   return $ret
}

cdp() {
   pushd +$1
}

# helper for showing current git branch in prompt
git_branch_prompt() {
   [ "$PWD" == "/zhome" ] && return
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "(${ref#refs/heads/})"
}

# helper for showing current hg branch in prompt
hg_branch_prompt() {
   [ "$PWD" == "/zhome" ] && return
   branch=$(hg branch 2> /dev/null) || return
   echo "(${branch})"
}
