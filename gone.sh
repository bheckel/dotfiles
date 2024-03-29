#!/bin/bash
##############################################################################
#     Name: gone.sh (grep oneliners)
#
#  Summary: grep $HOME/code/misccode/oneliners, highlight the search word and 
#           display context surrounding each hit.  Optionally allow searching
#           only specific sections of oneliners file.
#
#           NOTE: Keep 2 blank lines before the xxFOOxx lines in oneliners
#           to avoid seeing the tag in search results.
#
#           Depends on .bashrc's $fg_... 
#
#           TODO fix inability to pass -c -0
#
#  Created: 20-Nov-2002 (Bob Heckel)
# Modified: 15-Apr-2023 (Bob Heckel)
##############################################################################
  
F="$HOME/dotfiles/oneliners"

#IGCASE=--ignore-case
IGCASE=-i  # for busybox grep

Usage() {
  echo "Usage: `basename $0` [-c] PERLREGEX [ (d)atabase | (s)as | s(c)ripting | (u)nix | (v)im | (m)isc ]
             -c   case sensitive search (default is INsensitive)
             -0   no before and after context from grep(1)

                    `basename $0` findme
                    `basename $0` '\bfindme\b'
                    `basename $0` 'find me' vim
                    `basename $0` -c findme vim
                    `basename $0` -c findme v
                    `basename $0` '\-eq'  <---needs a backslash due to dash!

Searches the 'database' ($F) for string
matches, optionally looking in a particular section

Must backslash any literal regex characters (e.g. 'sql\*plus')"

  exit 0
}

if [ "$#" -lt 1 -o "$#" -gt 3 ]; then 
  Usage
elif [ "${1:0:1}" = '-' ];then
  echo Please escape your dash.  Exiting.
  exit
elif [ "${1:0:1}" = '*' ];then
  echo Please escape your asterisk.  Exiting.
  exit
fi


BEFORECONTEXT=1  # for grep(1)
AFTERCONTEXT=2  # for grep(1)
while getopts c0 opt; do
  shift `expr $OPTIND - 1`
  case "$opt" in
     c )  IGCASE=
          ;;
     C )  CANONICAL=1
          ;;
     0 )  BEFORECONTEXT=0
          AFTERCONTEXT=0
          ;;
   esac
done

if test "$2" = 'vim' || test "$2" = 'sas' || test "$2" = 'scripting' || test "$2" = 'unix' || test "$2" = 'misc'; then
  s=$2
  echo
# Shortcut the >3 char section tags
elif test "$2" = 'p'; then  # perl
  s=scripting
elif test "$2" = 'c'; then
  s=scripting
elif test "$2" = 'u'; then
  s=unix
elif test "$2" = 'o'; then
  s=misc
elif test "$2" = 'm'; then
  s=misc
elif test "$2" = 's'; then
  s=sas
elif test "$2" = 'v'; then
  s=vim
elif test "$2" = 'd'; then
  s=database
else
  # An incorrect section was specified (skip if no section specified)
  if [ ! -z "$2" ]; then
    echo "ERROR:  available sections are (d)atabase, (s)as, s(c)ripting, (u)nix, (v)im, (o)ther/(m)isc"
    exit 1
  fi
fi

# If we get a section string, we need to build a mini-oneliners temp file
if test "x$s" != "x"; then
  SECT=`echo "$s" | tr '[a-z]' '[A-Z]'`
  # TODO why does this fail if we're in $HOME/tmp ??
  awk "/^xx${SECT}xx START/,/^xx${SECT}xx END/ {print}" $F > $HOME/tmp/gone.tmp
  # Override F=...oneliners
  F=$HOME/tmp/gone.tmp
  echo ${fg_darkgray}xxxxxxxxxxx $s only ${normal}
else
  echo ${fg_darkgray}xxxxxxxxxxx${normal}
fi


# Red search term highlight comes from grep's --color=always
###if test $CANONICAL -ne 1; then
grep $IGCASE --before-context=$BEFORECONTEXT --after-context=$AFTERCONTEXT --color=always "$1" $F
###else
###grep $IGCASE --before-context=$BEFORECONTEXT --after-context=$AFTERCONTEXT --color=always "canonical.*$1" $F
###fi

rc=`grep $IGCASE --count "$1" $F`
echo ${fg_darkgray}xxxxxxxxxxx $rc hits${normal}
echo
