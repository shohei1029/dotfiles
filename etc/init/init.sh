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

#pyenv
if [ ! `which pyenv` ];then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshenv
fi
#pyenv-update (pyenv plugin)
git clone git://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update



#tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
