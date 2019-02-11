#!/bin/sh
set -euo pipefail



if [ `uname` = "Darwin" ]; then
    brew update
    brew tap neovim/neovim
    brew install --HEAD neovim
elif [ `uname` = "Linux" ]; then
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    mkdir -p ~/opt/bin
    mv nvim.appimage ~/opt/bin/nvim


#    if [ "$UID" -eq 0 ];then
#        sudo apt-get -y install software-properties-common
#        sudo add-apt-repository ppa:neovim-ppa/unstable
#        sudo apt-get update
#        sudo apt-get -y install neovim
#        sudo apt-get -y install python-dev python-pip python3-dev python3-pip
#    else
#        git clone https://github.com/neovim/neovim
#        cd neovim
#        make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=$HOME/opt"
#        make install
#        export PATH="$HOME/opt/bin:$PATH"
#    fi
fi

echo 'export XDG_CONFIG_HOME="~/.config"' >> ~/.zshenv
echo 'export XDG_CONFIG_HOME="~/.config"' >> ~/.bash_profile

pip install neovim

mkdir -p ~/.config
#cp -r ./nvim ~/.config
cp -r ../../.config/nvim ~/.config
