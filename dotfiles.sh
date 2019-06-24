#!/bin/bash

#  Created: Tue 03 May 2015 09:01:11 (Bob Heckel) 
# Modified: Sat 29 Dec 2018 11:30:03 (Bob Heckel)

# No leading dots!
#majordots='bashrc vimrc tmux.conf gitconfig'
majordots='bashrc vimrc tmux.conf'
  
if [ "$#" -gt 1 ]; then 
  cat <<EOT
Usage: $0
  Setup dotfiles in a new environment

  Assumes $HOME/dotfiles/ is where you cloned
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
echo -n "Setup dotfiles in $myhome? Ctl-c to cancel "
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

# 02-Jun-18 breaks WSL mintty
# These won't source as a symlink:
for f in inputrc; do
  echo setting up $myhome/.$f...
  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv -i $myhome/.$f $myhome/.$f.ORIG
    echo .$f was backed-up as .$f.ORIG
  else
    echo .$f does not yet exist
  fi
  cp $myhome/dotfiles/_$f $myhome/.$f
done

# For vim swapfile
mkdir $HOME/tmp

echo
echo ...completed $majordots
echo

ls -la ~

#echo "Consider installing:"
#echo "sudo apt-get install tmux vim-nox w3m bc"
#echo "sudo apt-get install tmux vim-gtk3 w3m bc"
