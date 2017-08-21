#!/bin/bash

#at the dotfiles dir

#Homebrew (osx)
if [ `uname` = "Darwin" ]; then
    echo "installing homebrew..."
    which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    formulae=(
        autoconf
        automake
        brew-cask
        cmake
        curl
        htop
        lua
        luajit
        neovim
        openssl
        pyenv
        ricty
        rsync
        sqlite
        the_silver_searcher
        tmux
        trash
        "vim --with-python3 --with-lua --with-luajit"
        wget
        xz
        zsh
        zsh-completions
        reattach-to-user-namespace # for tmux-yank
    )

    echo "brew tap..."
    brew tap caskroom/cask 
    brew tap caskroom/fonts
    brew tap homebrew/core
    brew tap homebrew/science

    echo "brew install apps..."
    for formula in "${formulae[@]}"; do
        brew install $formula || brew upgrade $formula
    done

    brew cleanup
fi


#zplug
if [ ! `which zplug` ];then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi


#tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
