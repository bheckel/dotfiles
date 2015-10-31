#!/bin/bash

cd ~

if [ ! -e ~/bin ]; then mkdir ~/bin; fi
if [ ! -e ~/tmp ]; then mkdir ~/tmp; fi

mv -i .bashrc .bashrc.ORIG
ln -s ./dotfiles/_bashrc .bashrc

mv -i .vimrc .vimrc.ORIG
ln -s ./dotfiles/_vimrc .vimrc

mv -i .inputrc .inputrc.ORIG
ln -s ./dotfiles/_inputrc .inputrc

mv -i .tmux.conf .tmux.conf.ORIG
ln -s ./dotfiles/_tmux.conf .tmux.conf

echo completed symlinking
