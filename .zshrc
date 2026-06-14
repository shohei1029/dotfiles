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
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
case ${UID} in
	0)
		LANG=C
		;;
esac


# antidote (plugin manager) — replaces zplug.
# Plugin list lives in ~/.zsh_plugins.txt; a static bundle is cached for fast startup.
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if (( ${+commands[brew]} )); then
    source "$(brew --prefix)/share/antidote/antidote.zsh"

    # Regenerate the static bundle whenever the plugin list changes.
    if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
        antidote bundle <${zsh_plugins}.txt >| ${zsh_plugins}.zsh
    fi
    source ${zsh_plugins}.zsh

    # Autoload prezto module functions (git-info, etc.); antidote loads each
    # module's root but not its functions/ subdir like prezto's own init.zsh does.
    if [[ -n "$ZPREZTODIR" ]]; then
        fpath=(${ZPREZTODIR}/modules/*/functions(/FN) $fpath)
        autoload -Uz ${ZPREZTODIR}/modules/*/functions/^([_.]*|prompt_*_setup|README*)(-.N:t)
    fi
fi


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


# zcompile for faster zshell launch
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

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

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1


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

# Detect platform and load the matching OS-specific config.
#   mac   -> .zshrc.mac
#   wsl   -> .zshrc.wsl   (WSL is Linux but needs Windows interop tweaks)
#   linux -> .zshrc.linux (native Linux)
case "$(uname -s)" in
    Darwin) _os=mac ;;
    Linux)
        if grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null; then
            _os=wsl
        else
            _os=linux
        fi
        ;;
esac
[ -n "${_os}" ] && [ -f ~/.zshrc.${_os} ] && source ~/.zshrc.${_os}
unset _os

# load machine-local (untracked) overrides last
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

#Created by S.N.