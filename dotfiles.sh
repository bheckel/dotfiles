#!/bin/bash
##############################################################################
#     Name: dotfiles.sh
#
#  Summary: Build dotfile (and configuration) symlinks to ~ on a new box
#
#  Created: Sat 17 Mar 2012 14:13:44 (Bob Heckel)
# Modified: Sun 06 May 2012 13:32:15 (Bob Heckel)
##############################################################################

dryrun=1
symloc=$HOME/code/misccode

if [ $dryrun -eq 1 ]; then
  echo "!!!starting dryrun to $symloc !!!!"
  dryrun=echo
  $dryrun -n ok to dryrun [Y/n]? 
  read yn
  if [ $yn = n ];then
    exit
  fi
else
  dryrun=
fi

cd $symloc || echo -n "$symloc does not exist"; exit
  
underscores=(bashrc Xdefaults inputrc vimrc Xmodmap)
echo 'starting underscore symlinking...'
for f in ${underscores[*]}; do
  $dryrun mv -i $HOME/.$f $HOME/.$f.ORIG  # backup just in case
  $dryrun ln -s $symloc/_$f $HOME/.$f     # then overwrite it
done


echo; echo 'starting fluxbox symlinking...'
flux=(keys menu init startup)
for f in ${flux[*]}; do
  $dryrun mv -i $HOME/.fluxbox/$f $HOME/.fluxbox/$f.ORIG  # backup just in case
  $dryrun ln -s $symloc/fluxbox.$f $HOME/.fluxbox/$f      # then overwrite it
done


echo; echo 'starting xfe copy (must copy because xfe will overwrite symlinks)...'
$dryrun mv -i $HOME/.config/xfe/xferc $HOME/.config/xferc/xferc.ORIG  # backup just in case
$dryrun cp -i $HOME/code/misccode/xferc $HOME/.config/xferc/xferc     # then overwrite it


echo; echo 'starting conky symlinking...'
$dryrun mv -i $HOME/.conkyrc $HOME/.conkyrc.ORIG  # backup just in case
$dryrun ln -s $symloc/_conkyrc $HOME/.conkyrc     # then overwrite it
