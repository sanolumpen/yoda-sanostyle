# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme: See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="yoda"

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# aliases
alias conf="nano ~/.config/hypr/hyprland.conf"
alias zconf="nano ~/.zshrc"
alias v="nvim"
alias ls="ls --color=auto"

# opencode
export PATH=/home/sanodesu/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"