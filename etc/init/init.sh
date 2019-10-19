#!/usr/bin/sh

#at the dotfiles dir

#試験中
#動作自信無

#手動箇所
# pyenvでpythonのインストール
# pip install neovim

#Homebrew
if [ $(uname) = "Darwin" ]; then
    echo "installing homebrew..."
    if test -z $(which brew); then
        which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

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
        #        pyenv
        ricty
        rsync
        sqlite
        the_silver_searcher
        tmux
        trash
        "vim --with-python3 --with-luajit"
        wget
        xz
        zsh
        #        zsh-completions
        reattach-to-user-namespace # for tmux-yank
    )

    echo "brew tap..."
    brew tap caskroom/cask
    brew tap caskroom/fonts
    brew tap homebrew/homebrew-core

    echo "brew install apps..."
    for formula in "${formulae[@]}"; do
        brew install $formula || brew upgrade $formula
    done

    brew cleanup

elif [ $(uname) = "Linux" ]; then
    if test -z $(which zsh); then
        echo "installing zsh"
        sudo apt install -y zsh
    fi

    # neovim #-> brewよりさらに楽で確実に入れられる
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    mkdir -p ~/opt/bin
    mv nvim.appimage ~/opt/bin/nvim
fi

echo 'export XDG_CONFIG_HOME="~/.config"' >>~/.zshenv
echo 'export XDG_CONFIG_HOME="~/.config"' >>~/.bash_profile
mkdir -p ~/.config

#zplug
if [ ! $(which zplug) ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

#anyenv
if test -z $(which anyenv); then
    echo "installing anyenv.."
    git clone https://github.com/riywo/anyenv ~/.anyenv
    export PATH="$HOME/.anyenv/bin:$PATH"
    anyenv init
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
    #ln -s ~/.anyenv/envs/pyenv ~/.pyenv #一応

    #一応bashの方にも入れておく
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >>~/.bash_profile
    echo 'eval "$(anyenv init - --no-rehash)"' >>~/.bash_profile

    if test -z $(which pyenv); then
        echo "installing pyenv..."
        anyenv install pyenv
        pyenv init
        [ ! -d $(pyenv root)/plugins/pyenv-virtualenv ] && git clone https://github.com/yyuu/pyenv-virtualenv $(pyenv root)/plugins/pyenv-virtualenv
    fi
fi

##pyenv (deprecated, use anyenv)
#if [ ! `which pyenv` ];then
#    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
#    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
#    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
#    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
#    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
#    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshenv
#fi
##pyenv-update (pyenv plugin)
#git clone git://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update

#for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#fonts
zsh ./font-installer.sh

#pip install neovim
