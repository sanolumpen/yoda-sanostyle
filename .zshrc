# ═══════════════════════════════════════════════════════════
#  .zshrc — Yoda Zsh Configuration
#  Kuri-Dots Yoda Rice · Debian 13
# ═══════════════════════════════════════════════════════════

# ── ZSH_CUSTOM DEBE ir ANTES de oh-my-zsh ────────────
export ZSH_CUSTOM="$HOME/.zsh-plugins"

# ── Colores ANTES de cargar oh-my-zsh ────────────────
# Predictivo: cyan mint bold (visible sobre fondo negro)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='%F{#4af5d4}%b'

# Syntax highlighting: todos los tokens con colores claros
ZSH_HIGHLIGHT_STYLES=(
  default                     fg=white
  unknown-token               fg=#ff79c6
  reserved-word               fg=#ff79c6
  alias                       fg=#4af5d4
  builtin                     fg=#87dfff
  function                    fg=#87dfff
  command                     fg=#4af5d4
  hashed-command              fg=#4af5d4
  path                        fg=#e0e0e0
  path_pathseparator          fg=#e0e0e0
  path_prefix_pathseparator   fg=#e0e0e0
  history-old                 fg=#ffd700
  single-hyphen-option        fg=#ffd700
  double-hyphen-option        fg=#ffd700
  back-double-quoted-argument fg=#4af5d4
  back-quoted-argument        fg=#ff79c6
  suffix-alias                fg=#4af5d4
  global-alias                fg=#4af5d4
  globbing-flags              fg=#ffd700
  single-quoted-argument      fg=#4af5d4
  double-quoted-argument      fg=#4af5d4
  dollar-quoted-argument      fg=#4af5d4
  brace-expansion             fg=#87dfff
)

# ── LS_COLORS: colores de ls y menú de completado ────
# Asegurar colores visibles sobre fondo negro
export LS_COLORS="di=#4af5d4:fi=#e0e0e0:ln=#87dfff:pi=#ffd700:ex=#66ff66:*.jpg=#ffd700:*.png=#ffd700:*.mp4=#ff79c6:*.zip=#ff4d4d:*.tar=#ffd700:*.gz=#ffd700"

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

# ── PATH (deduplicado) ──────────────────────────────
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

# ── Completado zsh: colores del menú dropdown ───────
autoload -Uz compinit
# Borrar caché de completado si existe (evita colores corruptos)
rm -f ~/.zcompdump* 2>/dev/null
compinit -u

# Menú de selección visible
zstyle ':completion:*' menu select=1
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' list-colors \
  'di=#4af5d4' \
  'fi=#e0e0e0' \
  'ln=#87dfff' \
  'pi=#ffd700' \
  'ex=#66ff66'

zstyle ':completion:*' format '%B%F{#87dfff}%d%f%b%F{#e0e0e0}'
zstyle ':completion:*:corrections' format '%B%F{#66ff66}→ %d (%e)%f%b'
zstyle ':completion:*:descriptions' format '%B%F{#87dfff} %d%f%b'
zstyle ':completion:*:messages' format '%B%F{#ffd700}%d%f%b'
zstyle ':completion:*:warnings' format '%B%F{#ff4d4d}No matches%f%b'

# ── Prompt Yoda ─────────────────────────────────────
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