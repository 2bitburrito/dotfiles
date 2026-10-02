.PHONY: install install-common install-darwin install-omarchy install-tmux-plugins install-zsh-deps set-shell hooks

UNAME := $(shell uname)
OH_MY_ZSH_DIR := $(HOME)/.oh-my-zsh
TPM_DIR := $(HOME)/.local/share/tmux/plugins/tpm

# Packages that make sense on every machine.
COMMON_PKGS := delve gh gh-dash git nvim opencode tmux zsh

# macOS-only packages (window managers, keyboard remapping, menu bar tools).
# claude lives here for now: its settings.json carries a git-ai hook with a
# hardcoded /Users/... path, so it isn't safe to stow on Linux yet.
DARWIN_PKGS := aerospace borders claude ghostty-darwin git-darwin kanata karabiner

# Omarchy (Arch + Hyprland) specific packages.
OMARCHY_PKGS := ghostty-omarchy hypr

install:
ifeq ($(UNAME), Darwin)
	@$(MAKE) install-darwin
else
	@$(MAKE) install-omarchy
endif
	@$(MAKE) install-zsh-deps
	@$(MAKE) set-shell
	@$(MAKE) install-tmux-plugins
	@$(MAKE) hooks
	@echo "Done!"

install-common:
	@echo "Stowing common dotfiles..."
	@cd ~/dotfiles && stow $(COMMON_PKGS)

install-darwin: install-common
	@echo "Stowing macOS dotfiles..."
	@cd ~/dotfiles && stow $(DARWIN_PKGS)
	@echo "Configuring macOS key repeat..."
	@defaults write -g InitialKeyRepeat -int 12
	@defaults write -g KeyRepeat -int 1
	@echo "Installing Homebrew packages..."
	@brew bundle --file=~/dotfiles/Brewfile

install-omarchy: install-common
	@echo "Stowing Omarchy dotfiles..."
	@cd ~/dotfiles && stow $(OMARCHY_PKGS)

install-zsh-deps:
	@echo "Installing zsh dependencies..."
	@if [ ! -d "$(OH_MY_ZSH_DIR)" ]; then \
		git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$(OH_MY_ZSH_DIR)"; \
	fi
	@echo "Installing Powerlevel10k..."
ifeq ($(UNAME), Darwin)
	@brew list powerlevel10k >/dev/null 2>&1 || brew install powerlevel10k
else
	@if [ ! -d "$(OH_MY_ZSH_DIR)/custom/themes/powerlevel10k" ]; then \
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
			"$(OH_MY_ZSH_DIR)/custom/themes/powerlevel10k"; \
	fi
endif

set-shell:
	@ZSH_PATH="$$(command -v zsh)"; \
	if [ "$(UNAME)" = "Darwin" ]; then \
		CURRENT_SHELL="$$(dscl . -read "/Users/$$(id -un)" UserShell | cut -d' ' -f2)"; \
	else \
		CURRENT_SHELL="$$(getent passwd "$$(id -un)" | cut -d: -f7)"; \
	fi; \
	if [ -z "$$ZSH_PATH" ]; then \
		echo "zsh is not installed"; \
		exit 1; \
	elif [ "$$CURRENT_SHELL" != "$$ZSH_PATH" ]; then \
		echo "Setting zsh as the login shell..."; \
		chsh -s "$$ZSH_PATH"; \
	else \
		echo "zsh is already the login shell."; \
	fi

install-tmux-plugins:
	@echo "Installing tmux plugins..."
	@mkdir -p "$(dir $(TPM_DIR))"
	@if [ ! -d "$(TPM_DIR)" ]; then \
		git clone https://github.com/tmux-plugins/tpm "$(TPM_DIR)"; \
	fi
	@"$(TPM_DIR)/bin/install_plugins"

hooks:
	@echo "Installing git hooks..."
	@ln -sf ../../scripts/pre-commit ~/dotfiles/.git/hooks/pre-commit
