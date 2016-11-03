#!/bin/bash

# Created: Tue 03 May 2015 09:01:11 (Bob Heckel) 
# Modified: Mon 23 May 2016 10:38:33 (Bob Heckel)
  
if [ "$#" -gt 1 ]; then 
  cat <<EOT
Usage: $0 [target dir for local dotfiles]
  Setup a new environment using $HOME/dotfiles/
  E.g. $0
  E.g. $0 /mnt/nfs/home/bheckel/tmp
EOT
  exit 1
fi

if [ -n "$1" ]; then
  myhome=$1
else
  myhome=$HOME
fi

echo
echo starting dotfile setup in $myhome...
echo
cd $myhome
echo "ls -a $myhome:"
ls -a $myhome
echo
echo -n 'ok? Ctl-c to cancel '
read

echo 'setting up directories (if needed)...'
if [ ! -e $myhome/bin ]; then mkdir $myhome/bin; fi
if [ ! -e $myhome/tmp ]; then mkdir $myhome/tmp; fi
if [ ! -e $myhome/code/misccode ]; then mkdir -p $myhome/code/misccode; fi

echo
echo 'setting up oneliners...'
ln -s $myhome/dotfiles/oneliners $myhome/code/misccode/

echo
echo 'setting up dotfiles...'
# No leading dots!
for f in bashrc vimrc tmux.conf Xdefaults; do
  echo setting up $myhome/.$f...
  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv -i $myhome/.$f $myhome/.$f.ORIG
    echo .$f was backed-up as .$f.ORIG
  else
    echo .$f does not yet exist
  fi
###  echo "source $myhome/dotfiles/_$f" >| ~/$f
  ln -s $myhome/dotfiles/_$f $myhome/.$f
done

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



echo
echo ...completed setup ls -la:
ls -la $myhome/
