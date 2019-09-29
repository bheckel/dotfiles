#!/bin/bash

#  Created: 03 May 2015 (Bob Heckel) 
# Modified: 29 Sep 2019 (Bob Heckel)

# No leading dots!
majordots='bashrc vimrc tmux.conf inputrc minttyrc gitconfig'
  
if [ "$#" -ge 1 ]; then 
  cat <<EOT
Usage: $0
  Setup dotfiles in a new environment

  Assumes $HOME/dotfiles/ is where you cloned

  Alternatively: 
    $ echo 'source ~/dotfiles/_vimrc' >> ~/.vimrc && echo 'source ~/dotfiles/_bashrc' >> ~/.bashrc
EOT
  exit 1
fi

if [ -n "$1" ]; then
  # Debugging
  myhome=$1
else
  myhome=$HOME
fi

cd $myhome

echo
echo -n "Setup dotfiles in $myhome? Ctr-C to cancel "
read
echo
echo 'setting up dotfiles...'
echo

for f in $majordots; do
  echo setting up $myhome/.$f...
  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv -i $myhome/.$f $myhome/.$f.ORIG
    echo .$f was backed-up as .$f.ORIG
  else
    echo .$f does not yet exist
  fi
  ln -s $myhome/dotfiles/_$f $myhome/.$f
done

# 24-Aug-19 works on oracle VM so commenting out
# These won't source as a symlink:
# for f in inputrc; do
#   echo setting up $myhome/.$f...
#   if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
#     mv -i $myhome/.$f $myhome/.$f.ORIG
#     echo .$f was backed-up as .$f.ORIG
#   else
#     echo .$f does not yet exist
#   fi
#   cp $myhome/dotfiles/_$f $myhome/.$f
# done

# For vim swapfile
if [ ! -e $HOME/tmp ]; then
  mkdir $HOME/tmp
fi
if [ ! -e /cygdrive/c/temp ]; then
  echo 'consider running $ mkdir -p /cygdrive/c/temp'
fi

echo
echo ...completed $majordots installation
echo

ls -la ~

echo
echo "Consider installing:"
echo "$ sudo apt-get install tmux vim-nox w3m bc"
echo 'or'
echo "$ sudo apt-get install tmux vim-gtk3 w3m bc"
