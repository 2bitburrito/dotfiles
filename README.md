# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow package mirroring the layout of `$HOME`.

## Layout

- **Common** (stowed everywhere): `claude`, `delve`, `gh`, `gh-dash`, `git`,
  `nvim`, `opencode`, `tmux`, `zsh`
- **macOS only**: `aerospace`, `borders`, `ghostty-darwin`, `git-darwin`,
  `kanata`, `karabiner`
- **Omarchy (Arch + Hyprland) only**: `ghostty-omarchy`

`git-darwin` supplies `~/.gitconfig.local`, which the common `git` package's
`.gitconfig` includes if present (silently skipped elsewhere) — that's where
any macOS-specific git config lives, keeping the shared `.gitconfig`
portable.

## Install

```sh
make install
```

Detects the OS (`Darwin` vs. everything else, i.e. Omarchy) and stows the
right package set, plus installs the pre-commit git hook. On macOS it also
sets key repeat speed and runs `brew bundle` against `Brewfile`.

Run a subset directly if you only want part of it:

```sh
make install-common   # cross-platform packages only
make install-darwin   # common + macOS-only packages
make install-omarchy  # common + Omarchy-only packages
```

If a target file already exists and isn't a symlink into this repo (e.g. a
fresh machine's default `~/.gitconfig` or `~/.config/gh`), `stow` will refuse
that package with a conflict — move or remove the existing file/dir and
re-run.

## Brewfile

`scripts/pre-commit` runs `brew bundle dump` on macOS to keep `Brewfile` in
sync with what's actually installed.
