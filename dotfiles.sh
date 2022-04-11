#!/bin/bash

#  Created: 03-May-2015 (Bob Heckel) 
# Modified: 08-Apr-2022 (Bob Heckel)

# No leading dots!
if [ -z WSL_DISTRO_NAME ]; then
  majordots='bashrc vimrc tmux.conf inputrc minttyrc gitconfig'
else
  majordots='bashrc vimrc tmux.conf inputrc gitconfig'
fi
  
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

if [ -n "$1" ]; then
  # Debugging
  myhome=$1
else
  myhome=$HOME
fi

cd $myhome

echo
echo -n "Setup dotfiles in $myhome? "
read
echo

for f in $majordots; do
  echo '........................'
  echo setting up $myhome/.$f...
  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv -i $myhome/.$f $myhome/.$f.ORIG
    echo .$f was backed-up as .$f.ORIG
  else
    echo .$f does not yet exist
  fi
  ln -s $myhome/dotfiles/_$f $myhome/.$f
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

#%ls -la ~

echo
echo "Consider installing:"
echo "$ sudo apt-get install tmux vim-nox w3m bc git ssh"
echo 'or'
echo "$ sudo apt-get install tmux vim-gtk3 w3m bc git ssh"
echo

echo 'Consider running:'
if [ -e /cygdrive ]; then
  echo '$ mkdir -p /cygdrive/c/temp'
fi
echo 'git config --global user.email "b.heckel@gmail.com"'
echo 'git config --global user.name "Bob Heckel"'

