# ================
#    Oh-My-Zsh
# ================

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

# update automatically without asking
zstyle ':omz:update' mode auto

ENABLE_CORRECTION="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ========================
#    User Configuration
# ========================

# pipe cd find to fzf for directories 
function cdf() {
  local dir
  dir=$(fd --type d --max-depth 5 | fzf) && cd "$dir"
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# SSH Indicator
if [[ -n $SSH_CONNECTION ]]; then
  export SSH_INDICATOR="🤫 SSH"
else
  export SSH_INDICATOR=""
fi
PROMPT='${SSH_INDICATOR} %n@%m %1~ %# '

# ===============
#      FZF
# ===============
# fzf completions
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Unbind default ALT-C key (Esc + c)
bindkey -r -M emacs '\ec'
bindkey -r -M vicmd '\ec'
bindkey -r -M viins '\ec'

# ==================
#   Config Aliases 
# ==================
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim/ && nvim ."
alias ghosttyconfig="nvim ~/Library/Application\ Support/com.mitchellh.ghostty/config"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"
alias aeroconfig="nvim ~/.config/aerospace/aerospace.toml"

# ================
#  Other Aliases
# ================
alias py="python3"
alias fzfprev="fzf --preview='bat --style=numbers --color=always {}'"
alias la=tree
alias cat=bat
alias gc="git commit -m"
alias glog="git log --oneline --graph --decorate --all -10"
alias ls="lsd"
alias td='nvim ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Coding\ Vault/Daily\ Notes/todo.md'
alias proj='cd "$(find ~/Documents/Projects -mindepth 1 -maxdepth 1 -type d | fzf)"'
alias k='kubectl'
alias n='nvim .'
alias oc='opencode'

# This is a hack to get arount this behaviour:
# ❯ go test ./... -v
# zsh: correct './...' to './..' [nyae]?
alias go='nocorrect go'

# ================
#  Global Aliases
# ================

alias -g JQ="| jq"
alias -g C="| pbcopy"
alias -g L="| less"

# ================
#  Suffix Aliases
# ================

alias -s md='bat'
alias -s json='jless'
alias -s yaml='bat -l yaml'
alias -s go="$EDITOR"
alias -s py="$EDITOR"
alias -s rs="$EDITOR"
alias -s ts="$EDITOR"
alias -s js="$EDITOR"

alias -s mov='open'
alias -s jpeg='open'
alias -s png='open'
alias -s mp4='open'
alias -s wav='xxd'

# ==============
#   Functions
# ==============

# chpwd executes after a cd:
chpwd() {
  ls
}


gits() {
  local branch
  branch=$(git branch -a | fzf | xargs)
  if [[ -n "$branch" ]]; then
    # Remove 'remotes/origin/' prefix if present
    branch=${branch#remotes/origin/}
    echo "Switching to branch: $branch"
    git switch -t -c "$branch"
  else
    echo "No branch selected."
  fi
}
# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# ========
#   TMUX
# ========
# Start tmux automatically if not already inside a tmux session but not on SSH
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ ! -n $SSH_CONNECTION ]; then
    tmux
fi
# Keep session persistence in vscode/tmux
if [[ $TERM_PROGRAM == "vscode" ]]; then
  tmux new -As $(basename "$PWD")
fi

# ==========================
#  Vim Motions and cursor  
# ==========================
bindkey -v
function zle-keymap-select () {
case $KEYMAP in
vicmd) echo -ne '\e[1 q\e[?12l';; # block
viins|main) echo -ne '\e[5 q\e[?12l';; # beam
esac }
zle -N zle-keymap-select
zle-line-init() {
echo -ne "\e[5 q\e[?12l" }
zle -N zle-line-init
echo -ne '\e[5 q\e[?12l' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q\e[?12l' ;} # Use beam shape cursor for each new prompt.

# ======
#  Misc
# ======
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export VISUAL='nvim'
export GOPRIVATE=github.com/nepgpe/*

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

bindkey "^X^E" edit-command-line

[ -f ~/.anthropic.env ] && source ~/.anthropic.env

# Adding zoxide
eval "$(zoxide init zsh)"
