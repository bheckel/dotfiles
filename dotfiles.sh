#!/bin/bash

cd ~

mv -i .bashrc .bashrc.ORIG
ln -s ./dotfiles/_bashrc .bashrc

mv -i .vimrc .vimrc.ORIG
ln -s ./dotfiles/_vimrc .vimrc

mv -i .inputrc .inputrc.ORIG
ln -s ./dotfiles/_inputrc .inputrc

echo completed symlinking
