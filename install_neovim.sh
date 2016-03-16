#!/bin/bash
set -euo pipefail



if [ `uname` = "Darwin" ]; then
    brew tap neovim/neovim
    brew install --HEAD neovim
elif [ `uname` = "Linux" ]; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get install neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
fi

echo 'export XDG_CONFIG_HOME="~/.config"' >> .zshenv
echo 'export XDG_CONFIG_HOME="~/.config"' >> .bash_profile

mkdir -p ~/.config
cp -r ./nvim ~/.config

pip install neovim
