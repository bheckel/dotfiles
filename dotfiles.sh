#!/bin/bash

# Modified: Mon 02 May 2016 13:39:43 (Bob Heckel)

echo starting dotfile setup in $HOME...
cd $HOME
ls -a $HOME
echo -n 'ok? Ctl-c to cancel '
read


echo 'setting up directories (if needed)...'
if [ ! -e $HOME/bin ]; then mkdir $HOME/bin; fi
if [ ! -e $HOME/tmp ]; then mkdir $HOME/tmp; fi
if [ ! -e $HOME/code/misccode ]; then mkdir -p $HOME/code/misccode; fi

echo 'setting up oneliners...'
cp -i $HOME/dotfile/oneliners $HOME/code/misccode/

# No leading dots!
for f in bashrc vimrc inputrc tmux.conf; do echo $f;
  echo setting up $f...
  if [ -e $HOME/.$f ]; then
    mv -i $HOME/.$f $HOME/.$f.ORIG
    echo .$f was backed up as .$f.ORIG
  else
    echo $f does not yet exist
  fi
###  echo "source $HOME/dotfiles/_$f" >| ~/$f
  ln -s $HOME/dotfiles/_$f $HOME/.$f
  ls -la $HOME/.$f*
done

echo ...completed setup

