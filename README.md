# dotfiles

### iTerm2
git clone https://github.com/rickhanlonii/Solarized-Darcula/

### zsh

 
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
