DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

#for vim: Set 'set noexpandtab' option to edit this file.
#problem: .confg うまくいかない. ひとまずEXCLUSIONSに.


all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

min_deploy: ## deploy: of minimized setting files in 'min_sets' dir (by S.N.)
	#vim, bash, zsh and bin dir (hard coding)
	ln -sfnv $(abspath ./min_sets/.vimrc) ~/.vimrc
	ln -sfnv $(abspath ./min_sets/.zshrc) ~/.zshrc
	ln -sfnv $(abspath ./min_sets/.bashrc) ~/.bashrc 
	ln -sfnv $(abspath bin) ~/bin
	#@$(foreach val, $(filter-out $(EXCLUSIONS), $(wildcard ./min_sets/.??*)), ln -sfnv $(abspath $(val)) $(HOME)/$(val);) #うまくいかない

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update deploy init ## Run make update, deploy, init
	@exec $$SHELL

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
