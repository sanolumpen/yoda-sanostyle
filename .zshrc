# ═══════════════════════════════════════════════════════════
#  .zshrc — Yoda Zsh Configuration
#  Kuri-Dots Yoda Rice · Debian 13
# ═══════════════════════════════════════════════════════════

# ── ZSH_CUSTOM DEBE ir ANTES de oh-my-zsh ────────────
export ZSH_CUSTOM="$HOME/.zsh-plugins"

# ── Oh My Zsh ──────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="yoda"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ── Variables de entorno ────────────────────────────
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color

# ── PATH (deduplicado, sin duplicar .zprofile) ───────
_add_to_path() {
  case "$PATH" in
    *"$1"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

_add_to_path "/home/sanodesu/.local/bin"
_add_to_path "/home/sanodesu/.opencode/bin"
_add_to_path "$HOME/.lmstudio/bin"
_add_to_path "/usr/local/bin"

unset -f _add_to_path

# ── Prompt Yoda (override post-oh-my-zsh) ──────────
# Override theme PROMPT para personalización completa
PROMPT='%{$fg_bold[green]%}%n%{$fg_no_bold[cyan]%}@%{$fg_bold[cyan]%}%m %{$fg[yellow]%}>%{$reset_color%} %{$fg_bold[white]%}%~%{$reset_color%}
%{$fg[green]%}$(git_prompt_info)%{$reset_color%}%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})▷%{$reset_color%} '

RPROMPT='%{$fg_bold[yellow]%}%D{%H:%M:%S}%{$reset_color%}'

# ── Opciones de Oh My Zsh ──────────────────────────
zstyle ':omz:update' mode disabled

# ── Aliases ────────────────────────────────────────
alias conf="nano ~/.config/hypr/hyprland.conf"
alias zconf="nano ~/.zshrc"
alias v="nvim"
alias ls="ls --color=auto"
alias ll="ls -la --color=auto"
alias hyprreload="hyprctl reload"
alias ewwreload="pkill -f eww; sleep 1; eww daemon; sleep 2; eww open-many dashboard_window date_window football_window notes_window"
alias dotfiles="cd ~/Documentos/dotfiles"

# ── Historial ──────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# ── Key bindings ───────────────────────────────────
bindkey -e
bindkey '^[[Z' reverse-menu-complete

# ── SSH/GPG ────────────────────────────────────────
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# ── Google Calendar creds (fuera del repo) ────────
export GOOGLE_CALENDAR_CRED="$HOME/.config/eww/scripts/credentials.json"
export GOOGLE_CALENDAR_TOKEN="$HOME/.config/eww/scripts/token.pickle"