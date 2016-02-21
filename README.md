# dotfiles

### iTerm2
git clone https://github.com/rickhanlonii/Solarized-Darcula/

### zsh

#### prezto
// Zsh起動
$ zsh
 
// リポジトリをclone
$ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
 
// 既存の設定ファイルを退避(必要な場合)
$ mkdir zsh_orig && mv zshmv .zlogin .zlogout .zprofile .zshenv .zshrc zsh_orig
 
// 設定ファイルを作成
$ setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
 
// Shellのデフォルトに設定
$ chsh -s /bin/zsh

//Updating
git pull && git submodule update --init --recursive

#####powerline対応のRicty利用準備
$ brew tap sanemat/font
$ brew reinstall --powerline --vim-powerline ricty
$ cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
 Rictyを指定
