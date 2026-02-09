#!/bin/bash

#  Created: 03-May-2015 (Bob Heckel) 
# Modified: 09-Feb-2026 (Bob Heckel)

# No leading dots!
majordots='bashrc vimrc tmux.conf inputrc minttyrc gitconfig'
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

function strlen {
  echo ${#1}     
}                

cd $myhome
echo
echo -n "Setup dotfiles in $myhome? "
read

#maxlen=0                                  
#for f in $majordots; do                   
#  len=$(strlen "$myhome/.$f")             
#  if (( len > maxlen )); then             
#    maxlen=$len                           
#  fi                                      
#done                                      
                                          
for f in $majordots; do                   
  echo -n "setting up "                   
#  len=$(strlen "$myhome/.$f")             
#  padding=$((maxlen-len))                 
#  printf "%s%*s" "$myhome/.$f " $padding "" 

  if [ -e $myhome/.$f ] || [ -L $myhome/.$f ]; then
    mv $myhome/.$f $myhome/.$f.ORIG
  fi

  #TODO
  #export fg_green="[0;32m"
  line='.........................'
  #ln -s $myhome/dotfiles/_$f $myhome/.$f && echo "[[0;32m  OK  [0m]"
  ln -s $myhome/dotfiles/_$f $myhome/.$f && printf "%s %s [[0;32m  OK  [0m]\n" $f "${line:${#f}}"
done

if [ ! -e $HOME/bin ]; then
  mkdir $HOME/bin
fi

# For vim swapfile
if [ ! -e $HOME/tmp ]; then
  mkdir $HOME/tmp
fi

if [ -e /cygdrive ]; then
  mkdir -p /cygdrive/c/temp && cd ~ && ln -s /cygdrive/c/temp .
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  if [[ "${ID:-}" == "ol" || "${ID_LIKE:-}" == *"ol"* ]]; then
    echo "Version: ${VERSION_ID:-unknown}"
    echo "Pretty name: ${PRETTY_NAME:-unknown}"
    sudo timedatectl set-timezone America/New_York
  else
    echo "Not Oracle Linux (ID=${ID:-unset})"
  fi
fi

echo
echo "Consider installing:"
echo "$ sudo apt-get install git tmux vim-nox w3m bc"
echo "$ sudo dnf install git tmux vim-nox w3m bc"
echo

