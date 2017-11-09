alias ls='ls -GF'
alias la='ls -la'
alias f='ls -F'
alias l='ls -l'
alias a='ls -a'
alias lh='ls -lh'
alias smith1='ssh smith1'
alias smith2='ssh smith2'
alias smith3='ssh smith3'
alias smith4='ssh smith4'
alias smith5='ssh smith5'
alias iris='ssh iris'
alias tarall='find ./ -type f -name "*.tar.gz" -exec tar zxf {} \;'
alias ipynb='ipython notebook'
alias ipnb='ipynb'
alias jpnb='jupyter notebook'
alias nv='nvim'

export EDITOR='vim'

## ½ÅÊ£¥Ñ¥¹¤òÅÐÏ¿¤·¤Ê¤¤
typeset -U path cdpath fpath manpath

#for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
#enables completioins
autoload -Uz compinit
compinit -u


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




# Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
	0)
		LANG=C
		;;
esac

#nvim
export XDG_CONFIG_HOME=~/.config

#export PYTHONPATH="$HOME/.pyenv/shims/python3:$PYTHONPATH"

# Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
	0)
		PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
		PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
		SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
		;;
	*)
		PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
		PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
		SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
		[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
		;;
esac

#PROMPT settings , color 
#case ${UID} in
#	0)
#		PROMPT="%B%{[31m%}%/#%{[m%}%b "
#		PROMPT2="%B%{[31m%}%_#%{[m%}%b "
#		SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#		[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#		PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#		;;
#	*)
#		PROMPT="%{[31m%}%/%%%{[m%} "
#		PROMPT2="%{[31m%}%_%%%{[m%} "
#		SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
#		[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#		PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#		;;
#esac

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
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

#VI-like keybind
#bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#auto_cd
setopt auto_cd
#auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
# command correct edition before each completion attempt
setopt correct
# compacked complete list display
setopt list_packed
# no beep sound when complete list displayed
setopt nolistbeep
## Prediction configuration
#	autoload predict-on
#	predict-on

#delete old history command if there already is in the history file.
setopt hist_save_nodups
# load math functions
zmodload -i zsh/mathfunc

# no remove postfix slash of command line
setopt noautoremoveslash

setopt complete_aliases # aliased ls needs if file/dir completions work


## load user .zshrc configuration file
##
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# set terminal title including current directory
#
case "${TERM}" in
	xterm|xterm-color|kterm|kterm-color)
		precmd() {
			echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
		}
		;;
esac


## terminal configuration
##
case "${TERM}" in
	screen)
		TERM=xterm
		;;
esac

case "${TERM}" in
	xterm|xterm-color)
		export LSCOLORS=exfxcxdxbxegedabagacad
		export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
		;;
	kterm-color)
		stty erase '^H'
		export LSCOLORS=exfxcxdxbxegedabagacad
		export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
		;;
	kterm)
		stty erase '^H'
		;;
	cons25)
		unset LANG
		export LSCOLORS=ExFxCxdxBxegedabagacad
		export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
		;;
	jfbterm-color)
		export LSCOLORS=gxFxCxdxBxegedabagacad
		export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
		;;
esac


