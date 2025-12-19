.PHONY: install

install:
	@echo "Stowing dotfiles..."
	@cd ~/dotfiles && stow aerospace claude ghostty karabiner opencode tmux borders gh git nvim zsh
	@echo "Installing git hooks..."
	@ln -sf ../../scripts/pre-commit ~/dotfiles/.git/hooks/pre-commit
	@if [ "$$(uname)" = "Darwin" ]; then \
		echo "Configuring macOS key repeat..."; \
		defaults write -g InitialKeyRepeat -int 12; \
		defaults write -g KeyRepeat -int 1; \
		brew install ~/dotfiles/Brewfile; \
	fi
	@echo "Done!"
