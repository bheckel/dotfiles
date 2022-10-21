#!/bin/bash

#  Created: 03-May-2015 (Bob Heckel) 
# Modified: 17-Oct-2022 (Bob Heckel)

# No leading dots!
#if [ -z WSL_DISTRO_NAME ]; then
#  majordots='bashrc vimrc tmux.conf inputrc minttyrc gitconfig'
#else
  majordots='bashrc vimrc tmux.conf inputrc minttyrc gitconfig'
#fi
  
myhome=$HOME
# Debug toggle
#myhome=$(pwd)

if [ "$#" -ge 1 ]; then 
  cat <<EOT
Usage: $0
  Setup dotfiles ($majordots) in a new environment

  Assumes $HOME/dotfiles/ is where we cloned

  Alternatively for specific dotfiles only e.g.: 
    $ echo 'source ~/dotfiles/_vimrc' >> ~/.vimrc && echo 'source ~/dotfiles/_bashrc' >> ~/.bashrc
EOT
  exit 1
fi

cd $myhome

echo
echo -n "Setup dotfiles in $myhome? "
read
echo

for f in $majordots; do
  echo -n "setting up "
  echo -n "$myhome/.$f     "
  echo -n ".............	 "
  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv $myhome/.$f $myhome/.$f.ORIG
    #echo .$f was backed-up as .$f.ORIG
  #else
    #echo .$f does not yet exist
  fi
  ln -s $myhome/dotfiles/_$f $myhome/.$f && echo "[[0;32m  OK  [0m]"
export fg_green="[0;32m"
done

# 24-Aug-19 works on Oracle VM so commenting out
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

if [ -e /cygdrive ]; then
  mkdir -p /cygdrive/c/temp && cd ~ && ln -s /cygdrive/c/temp .
fi

echo
echo "Consider installing:"
echo "$ sudo apt-get install tmux vim-nox w3m bc ssh"
echo 'or'
echo "$ sudo apt-get install tmux vim-gtk3 w3m bc ssh"
echo

