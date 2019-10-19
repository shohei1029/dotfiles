# dotfiles
for macOS or Ubuntu

## Setup
```sh
$ curl -sSL https://raw.githubusercontent.com/shohei1029/dotfiles/master/install.sh | sh
```

## Misc.

### iTerm2
`git clone https://github.com/rickhanlonii/Solarized-Darcula/`

#### powerline対応のフォント (Ricty)利用準備
```sh
$ brew tap sanemat/font
$ brew reinstall --powerline --vim-powerline ricty
$ cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
 #Rictyを指定
```

### zsh
- Shellのデフォルトに設定  
`$ chsh -s /bin/zsh`
- Updating  
`git pull && git submodule update --init --recursive`

## References
- [優れた dotfiles を設計して、最速で環境構築する話](https://qiita.com/b4b4r07/items/24872cdcbec964ce2178)
- [PiroPiro](https://github.com/PiroHiroPiro/dotfiles)
