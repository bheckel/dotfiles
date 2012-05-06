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

if [ $dryrun -eq 1 ]; then
  echo dryrun!!!!
  echo dryrun!!!!
  echo dryrun!!!!
  dryrun=echo
  $dryrun -n ok to dryrun [Y/n]? 
  read yn
  if [ $yn = n ];then
    exit
  fi
else
  dryrun=
fi

cd $HOME/code/misccode || exit
  
underscores=(bashrc Xdefaults inputrc vimrc Xmodmap)
echo 'starting underscore symlinking...'
for f in ${underscores[*]}; do
  $dryrun mv -i ~/.$f ~/.$f.ORIG
  $dryrun ln -s _$f ~/.$f
done


echo; echo 'starting fluxbox symlinking...'
flux=(keys menu init startup)
for f in ${flux[*]}; do
  $dryrun mv -i ~/.fluxbox/$f ~/.fluxbox/$f.ORIG
  $dryrun ln -s fluxbox.$f ~/.fluxbox/$f
done


echo; echo 'starting xfe copy (must copy because xfe will overwrite symlinks)...'
$dryrun mv -i ~/.config/xfe/xferc ~/.config/xferc/xferc.ORIG
$dryrun cp -i ~/code/misccode/xferc ~/.config/xferc/xferc


echo; echo 'starting conky symlinking...'
$dryrun mv -i ~/.conkyrc ~/.conkyrc.ORIG
$dryrun ln -s .conkyrc ~/.conkyrc
