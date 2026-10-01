.PHONY: install install-common install-darwin install-omarchy hooks

UNAME := $(shell uname)

# Packages that make sense on every machine.
COMMON_PKGS := delve gh gh-dash git nvim opencode tmux zsh

# macOS-only packages (window managers, keyboard remapping, menu bar tools).
# claude lives here for now: its settings.json carries a git-ai hook with a
# hardcoded /Users/... path, so it isn't safe to stow on Linux yet.
DARWIN_PKGS := aerospace borders claude ghostty-darwin git-darwin kanata karabiner

# Omarchy (Arch + Hyprland) specific packages.
OMARCHY_PKGS := ghostty-omarchy

install:
ifeq ($(UNAME), Darwin)
	@$(MAKE) install-darwin
else
	@$(MAKE) install-omarchy
endif
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

hooks:
	@echo "Installing git hooks..."
	@ln -sf ../../scripts/pre-commit ~/dotfiles/.git/hooks/pre-commit
