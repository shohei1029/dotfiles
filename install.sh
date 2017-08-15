#!/bin/bash

#at the dotfiles dir

if [ ! `which zsh` ];then
    if [ ! `which brew` ];then
        brew install zsh
    fi
fi

#zplug
if [ ! `which zplug` ];then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
    ln -s `pwd`/.zshrc ~/.zshrc
    source ~/.zshrc
fi


