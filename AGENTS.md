# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for **macOS, WSL, and native Linux (Ubuntu)**. A single set of
config files is symlinked into `$HOME`; platform differences are handled at
runtime, not by maintaining separate trees.

## Common commands

| Command | What it does |
| --- | --- |
| `make deploy` | Symlink dotfiles into `$HOME` (the core operation) |
| `make init` | Install Homebrew, run `brew bundle`, set up tmux tpm |
| `make brew` | Run `brew bundle --file=Brewfile` only |
| `make install` | `update` → `deploy` → `init`, then re-exec the shell |
| `make update` | `git pull origin <current-branch>` |
| `make min_deploy` | Deploy only the lightweight `min_sets/` configs (for servers) |
| `make help` | List all targets (default goal) |
| `make clean` | Remove the deployed symlinks from `$HOME` |

`install.sh` is the bootstrap entry point for a fresh machine (clone/tarball →
`make deploy init`). It deliberately skips `make update` and `make brew` because
the repo was just fetched and `init` installs brew itself.

## Architecture

**Deploy via symlink (Makefile).** `deploy` globs `.??*` + `bin` (the
`CANDIDATES`/`DOTFILES`/`EXCLUSIONS` vars), then `ln -sfnv` each into `$HOME`.
`.config/nvim` is symlinked separately because `.config` is in `EXCLUSIONS`
(globbing the whole `.config` dir didn't work reliably). Editing a file here is
editing the live config — no copy step.

**OS detection lives in `.zshrc`, not in the deploy step.** `.zshrc` is the
shared config. At the bottom it runs `uname -s` (and greps `/proc/version` for
`microsoft|wsl`) to pick `_os` ∈ {mac, wsl, linux}, then sources
`~/.zshrc.<os>`. Finally it sources `~/.zshrc.local` (git-ignored, machine-
specific). **Add OS-specific settings to the relevant `.zshrc.<os>` file**, not
behind inline conditionals.

**Homebrew bootstrapping order matters in `.zshrc`.** The `brew shellenv` loop
(handles both `/opt/homebrew` and Linuxbrew paths) must run *before* the
antidote block, which depends on `brew`. Don't reorder these.

**zsh plugins via antidote** (migrated from zplug). Plugin list is
`.zsh_plugins.txt`; the static bundle `.zsh_plugins.zsh` is regenerated
automatically when the list changes and is git-ignored. Prezto modules load
through the `getantidote/use-prezto` bridge; module order in the list follows
dependencies (`helper` first). Prompt is prezto's `seraph` theme from
`shohei1029/xiang`.

**`init.sh` is the environment installer.** The official Homebrew installer
covers both macOS and Linux, so a single path installs Homebrew (Linux/WSL also
installs zsh first as a login-shell candidate), runs `brew shellenv`, then
`brew bundle` — the same `Brewfile` works everywhere. Finally it clones tmux's
tpm. Keep it idempotent (`set -e`, guard every install with a `command -v`
check).

## Conventions

- **Secrets** go in `.env` (git-ignored); `.env.example` is the template.
- **`min_sets/`** holds standalone minimal vim/zsh/bash/tmux configs for
  servers where the full setup is overkill — keep them dependency-free.
- **`bin/`** is symlinked onto `PATH`. Most files are vendored iTerm2
  utilities (`it2*`, `imgcat`); custom scripts are macOS-specific app wrappers.
- Comments throughout are a mix of Japanese and English; match the surrounding
  file when editing.
