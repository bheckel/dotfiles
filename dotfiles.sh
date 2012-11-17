#!/bin/bash
##############################################################################
#     Name: dotfiles.sh
#
#  Summary: Build dotfile (and configuration) symlinks to ~ on a new box
#
#           Cygwin prerequisite:
#           mount -f u:/code /home/rsh86800/code
#           mount -m >> /etc/fstab
#
#  Created: Sat 17 Mar 2012 14:13:44 (Bob Heckel)
# Modified: Thu 01 Nov 2012 11:05:45 (Bob Heckel)
##############################################################################

# Set to empty for real run, 'echo' otherwise
###dryrun=echo
dryrun=
symloc=$HOME/code/misccode

echo "!!! dryrun set to $dryrun !!!!"
echo "!!! dryrun set to $dryrun !!!!"
echo "!!! dryrun set to $dryrun !!!!"
echo 'empty is dangerous - is that ok? '
read
echo "'cannot stat' errors are to be expected"

cd $symloc || (echo -n "$symloc does not exist" && exit)
  
###underscores=(bashrc Xdefaults inputrc vimrc Xmodmap)
underscores=(bashrc Xdefaults inputrc vimrc)
echo 'starting underscore symlinking...'
for f in ${underscores[*]}; do
  $dryrun mv -i $HOME/.$f $HOME/.$f.ORIG  # backup just in case
  $dryrun ln -s $symloc/_$f $HOME/.$f     # then overwrite it
  echo
done


###echo; echo 'starting fluxbox symlinking...'
###flux=(keys menu init startup)
###for f in ${flux[*]}; do
###  $dryrun mv -i $HOME/.fluxbox/$f $HOME/.fluxbox/$f.ORIG  # backup just in case
###  $dryrun ln -s $symloc/fluxbox.$f $HOME/.fluxbox/$f      # then overwrite it
###done
###
###
###echo; echo 'starting xfe copy (must copy because xfe will overwrite symlinks)...'
###$dryrun mv -i $HOME/.config/xfe/xferc $HOME/.config/xferc/xferc.ORIG  # backup just in case
###$dryrun cp -i $HOME/code/misccode/xferc $HOME/.config/xferc/xferc     # then overwrite it
###
###
###echo; echo 'starting conky symlinking...'
###$dryrun mv -i $HOME/.conkyrc $HOME/.conkyrc.ORIG  # backup just in case
###$dryrun ln -s $symloc/_conkyrc $HOME/.conkyrc     # then overwrite it
