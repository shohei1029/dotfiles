#!/bin/zsh

#Mostly pakuri from Piropiro
#信じがたいかもしれないが動作未確認

echo "Installing PowerLine fonts"
if test -z "$(ls ~/Library/Fonts/ | grep powerline)"; then
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
else
    echo "PowerLine fonts already exists"
fi
