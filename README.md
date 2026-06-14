# dotfiles
for macOS or Ubuntu

※日本語localeじゃないと動かない
-> .zshrcにja-jp設定が書かれてしまっているため。zplugのインストールができないことで発覚。

## Setup
```sh
$ curl -sSL https://raw.githubusercontent.com/shohei1029/dotfiles/master/install.sh | sh
```

## Misc.

### iTerm2
`git clone https://github.com/rickhanlonii/Solarized-Darcula/`

### powerline対応のフォント (Ricty)利用準備
Nerd Font対応フォントであればPowerlineで利用する記号も含まれている
```sh
brew install font-hackgen-nerd
```
iTerm3設定で`HackGen Console NF`を指定

GitHubのmonaspace系もよさそう

### zsh
- Shellのデフォルトに設定  
`$ chsh -s /bin/zsh`
- Updating  
`git pull && git submodule update --init --recursive`

## References
- [優れた dotfiles を設計して、最速で環境構築する話](https://qiita.com/b4b4r07/items/24872cdcbec964ce2178)
- [PiroPiro](https://github.com/PiroHiroPiro/dotfiles)
