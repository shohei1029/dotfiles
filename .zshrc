#alias ls='ls -GF'
#alias la='ls -la'
alias f='ls -F'
alias l='ls -l'
alias a='ls -a'
alias lh='ls -lh'
alias ipynb='ipython notebook'
alias ipnb='ipynb'
alias jpnb='jupyter notebook'
alias nv='nvim'
alias vtop="vtop --theme seti" #brewもよかった


case "${OSTYPE}" in 
darwin*)
	alias ls='ls -G'
	alias ll='ls -lG'
	alias la='ls -laG'
	;;
linux*)
	alias ls='ls --color'
	alias ll='ls -l --color'
	alias la='ls -la --color'
	;;
esac

# LANG
# localeに該当項目がないと見えにくいエラーを引き起こす
export LANG=ja_JP.UTF-8
case ${UID} in
	0)
		LANG=C
		;;
esac


# zplug
if [[ ! -d ~/.zplug ]];then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

[ -f ~/.zplug/init.zsh ] && source ~/.zplug/init.zsh

## plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
### prezto modules
zplug "modules/environment", from:prezto #Sets general shell options and defines environment variables.
#zplug "modules/history", from:prezto #Sets history options and defines history aliases.
zplug "modules/directory", from:prezto #Sets directory options and defines directory aliases.
zplug "modules/spectrum", from:prezto #Provides for easier use of 256 colors and effects.
#zplug "modules/utility", from:prezto #Defines general aliases and functions.
zplug "modules/completion", from:prezto #Loads and configures tab completion and provides additional completions from the zsh-completions project.
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
#zplug "sorin-ionescu/prezto" #don't use this because now we have from:prezto

zplug "zsh-users/zsh-syntax-highlighting", defer:2 #load this before load zsh-history-substring-search
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
#zplug "zsh-users/zsh-completions" # use prezo version
zplug "felixr/docker-zsh-completion"
zplug "mollifier/anyframe"
zplug "peco/peco", as:command, from:gh-r #functionaly same as fzf
zplug "junegunn/fzf", as:command, from:gh-r, use:"*darwin*amd64*"
zplug "b4b4r07/enhancd", use:init.sh
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:"jq"
#zplug "b4b4r07/emoji-cli", if:"which jq" #installed jq by homebrew
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
 # type ^s to launch
#zplug "shohei1029/xiang", as:command, use:"bin/*"
zplug "shohei1029/xiang" # prompt seraph
##

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug issue #374, #480
if [ -f "$_zplug_lock" ]; then
    rm "$_zplug_lock"
fi

# Then, source plugins and add commands to $PATH
zplug load 
#zplug load --verbose

#peco, fzfにpathが通ってない問題の応急処置 (171012)
path=($HOME/.zplug/bin(N-/) $path)

#use prompt from prezto
autoload -Uz promptinit
promptinit
prompt seraph
zstyle ':prezto:module:prompt' pwd-length 'long' #do not abbreviate working directory path


# other settings

#path
path=(~/opt/bin(N-/) $path)
#path=($path ~/opt/bin(N-/))
manpath=(~/opt/share/man(N-/) $manpath)

if (( ${+commands[nvim]} )); then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

# nvim
export XDG_CONFIG_HOME=~/.config

# load user .zshrc configuration file
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# anyanv
if [ -d $HOME/.anyenv ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - --no-rehash zsh)"
    #eval "$(anyenv init - --no-rehash)"
fi

# zcompile for faster zshell launch
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# Iterms2 integration (macOS)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### load bash completions
#autoload bashcompinit
#bashcompinit
#[ -f ~/.bash_completion ] && source ~/.bash_completion

### Command history configuration (overwrite a part of prezto:history module settings)
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000000
#setopt hist_ignore_dups     # ignore duplication command history list
#setopt share_history        # share command history data
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

# history search with peco
peco-select-history() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#history-substring-search-
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

#anyframe
alias af=anyframe-widget-select-widget

#enhancd
ENHANCD_DISABLE_HOME=1
ENHANCD_FILTER=fzy:fzf:peco
ENHANCD_HOOK_AFTER_CD='ls -GFl'

#emoji-cli
EMOJI_CLI_FILTER=fzy:fzf:peco


# fzf
# fh - repeat history
# functionaly same with above script. tmp
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
#Created by S.N.

# aliases (Todo: create separate file)
alias sshazvm='ssh -i ~/.ssh/azure-vm.pem shohei@4.236.177.141'
