alias ls='ls -GF'
alias la='ls -la'
alias f='ls -F'
alias l='ls -l'
alias a='ls -a'
alias lh='ls -lh'
alias tarall='find ./ -type f -name "*.tar.gz" -exec tar zxf {} \;'
alias ipynb='ipython notebook'
alias ipnb='ipynb'
alias jpnb='jupyter notebook'
alias nv='nvim'

export EDITOR='vim'


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
