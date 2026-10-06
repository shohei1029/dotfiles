DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
BRANCH     := $(shell git -C $(DOTPATH) rev-parse --abbrev-ref HEAD)
CANDIDATES := $(wildcard .??*) bin
# STUBS are deployed as small real files in $HOME (not symlinks) that source the
# repo config — so tools appending to ~/.zshrc / ~/.bashrc can't dirty the
# tracked repo file. Machine-local settings still go in ~/.zshrc.local etc.
STUBS      := .zshrc .bashrc
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore .travis.yml .config .ssh .env .env.example $(STUBS)
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
	@mkdir -p $(HOME)/.config
	@DOTPATH=$(DOTPATH); . $(DOTPATH)/etc/init/prompts.sh; \
	if needs_nvim_prompt; then \
		read -p "Overwrite existing ~/.config/nvim? (y/n): " yn; \
		case $$yn in \
			[Yy]* ) rm -rf $(HOME)/.config/nvim;; \
			* ) echo "Skipping ~/.config/nvim";; \
		esac; \
	fi
	@set -e; $(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@set -e; $(foreach val, $(STUBS), \
		if [ -L "$(HOME)/$(val)" ]; then rm -f "$(HOME)/$(val)"; fi; \
		if [ ! -e "$(HOME)/$(val)" ]; then \
			printf '# Auto-generated stub. Source the tracked dotfile; keep\n# machine-local settings and tool-appended lines below (or in ~/$(val).local).\nsource "%s"\n' "$(abspath $(val))" > "$(HOME)/$(val)"; \
			echo "generated stub $(HOME)/$(val)"; \
		elif ! grep -qF 'source "$(abspath $(val))"' "$(HOME)/$(val)"; then \
			printf '\n# Added by dotfiles deploy.\nsource "%s"\n' "$(abspath $(val))" >> "$(HOME)/$(val)"; \
			echo "appended source line to existing $(HOME)/$(val)"; \
		else \
			echo "kept existing $(HOME)/$(val) (not a symlink)"; \
		fi;)
	ln -sfnv $(abspath .config/nvim) ~/.config/
	ln -sfnv $(abspath .config/git) ~/.config/
	ln -sfnv $(abspath .config/btop) ~/.config/
	@mkdir -p $(HOME)/.config/karabiner
	ln -sfnv $(abspath .config/karabiner/karabiner.json) ~/.config/karabiner/karabiner.json
	@mkdir -p $(HOME)/.ssh && chmod 700 $(HOME)/.ssh
	ln -sfnv $(abspath .ssh/config) ~/.ssh/config

#vim, bash, zsh, tmux and bin dir (hard coding)
min_deploy: ## deploy: of minimized setting files in 'min_sets' dir (by S.N.)
	@mkdir -p $(HOME)/.config
	ln -sfnv $(abspath ./min_sets/.vimrc) ~/.vimrc
	ln -sfnv $(abspath ./min_sets/.zshrc) ~/.zshrc
	ln -sfnv $(abspath ./min_sets/.bashrc) ~/.bashrc 
	ln -sfnv $(abspath ./min_sets/.tmux.conf) ~/.tmux.conf
	ln -sfnv $(abspath .config/nvim) ~/.config/
	ln -snv $(abspath bin) ~/bin
#@$(foreach val, $(filter-out $(EXCLUSIONS), $(wildcard ./min_sets/.??*)), ln -sfnv $(abspath $(val)) $(HOME)/$(val);) #うまくいかない

# 対話的な確認の件数を最初に表示する (終わると init が ✅ を表示)。
preflight: ## Show how many interactive prompts deploy/init will ask
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/preflight.sh deploy init

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) DOTFILES_PREFLIGHT_DONE=$(if $(filter preflight install,$(MAKECMDGOALS)),1) bash $(DOTPATH)/etc/init/init.sh

brew: ## Install packages from Brewfile
	brew bundle --file=$(DOTPATH)/Brewfile

update: ## Fetch changes for this repo
	git -C $(DOTPATH) pull origin $(BRANCH)

install: update preflight deploy init ## Run make update, deploy, init (init installs brew + runs brew bundle)
	@# $$SHELL はまだ変更前のログインシェル (WSL/Linux では bash) なので zsh を優先する。
	@exec "$$(command -v zsh || echo "$$SHELL")"

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	@# Only remove stubs we generated (leave hand-edited real files alone).
	@$(foreach val, $(STUBS), \
		if [ -L "$(HOME)/$(val)" ] || grep -q '^# Auto-generated stub\.' "$(HOME)/$(val)" 2>/dev/null; then \
			rm -vf "$(HOME)/$(val)"; \
		fi;)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
