DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
BRANCH     := $(shell git -C $(DOTPATH) rev-parse --abbrev-ref HEAD)
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore .travis.yml .config .env .env.example
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

#for vim: Set 'set noexpandtab' option to edit this file.
#problem: .confg うまくいかない. ひとまずEXCLUSIONSに.


all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@set -e
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@mkdir -p $(HOME)/.config
	@if [ -e "$(HOME)/.config/nvim" ]; then \
		read -p "Overwrite existing ~/.config/nvim? (y/n): " yn; \
		case $$yn in \
			[Yy]* ) rm -rf $(HOME)/.config/nvim;; \
			* ) echo "Skipping ~/.config/nvim";; \
		esac; \
	fi
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	ln -sfnv $(abspath .config/nvim) ~/.config/

#vim, bash, zsh, tmux and bin dir (hard coding)
min_deploy: ## deploy: of minimized setting files in 'min_sets' dir (by S.N.)
	@set -e
	@mkdir -p $(HOME)/.config
	ln -sfnv $(abspath ./min_sets/.vimrc) ~/.vimrc
	ln -sfnv $(abspath ./min_sets/.zshrc) ~/.zshrc
	ln -sfnv $(abspath ./min_sets/.bashrc) ~/.bashrc 
	ln -sfnv $(abspath ./min_sets/.tmux.conf) ~/.tmux.conf
	ln -sfnv $(abspath .config/nvim) ~/.config/
	ln -snv $(abspath bin) ~/bin
#@$(foreach val, $(filter-out $(EXCLUSIONS), $(wildcard ./min_sets/.??*)), ln -sfnv $(abspath $(val)) $(HOME)/$(val);) #うまくいかない

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

brew: ## Install packages from Brewfile
	brew bundle --file=$(DOTPATH)/Brewfile

update: ## Fetch changes for this repo
	git -C $(DOTPATH) pull origin $(BRANCH)

install: update deploy brew init ## Run make update, deploy, brew, init
	@exec $$SHELL

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
