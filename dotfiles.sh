#!/bin/bash

# Created: Tue 03 May 2015 09:01:11 (Bob Heckel) 
# Modified: Mon 02 May 2016 13:39:43 (Bob Heckel)
  
if [ "$#" -gt 1 ]; then 
  cat <<EOT
Usage: $0 [mydir]
  Setup a new environment based on dotfiles/
  Defaults to $HOME
  E.g. $0
  E.g. $0 /mnt/nfs/home/bheckel/tmp
EOT
  exit 1
fi

if [ -n "$1" ]; then
###  myhome=/mnt/nfs/home/bheckel/tmp/1462213010_02May16
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
for f in bashrc vimrc inputrc tmux.conf Xdefaults; do
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

echo
echo ...completed setup ls -Rla:
ls -Rla $myhome/
