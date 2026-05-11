# ═══════════════════════════════════════════════════════════
#  Yoda Theme — Oh My Zsh
#  Neon green lightsaber aesthetic on dark background
#  Inspired by Kuri-Dots Yoda Rice
# ═══════════════════════════════════════════════════════════

# ── Colores principales ─────────────────────────
# Green: #00ff99 (90,255,153) — lightsaber core
# Mint:  #4af5d4 (74,245,212) — accents
# Yellow: #ffee58 — warnings/clock
# Red:   #ff4d4d — errors
# Cyan:  #00ffe1 — secondary

local RETURN_STATUS="%{$fg_bold[green]%}%(?..✗ %? )%{$reset_color%}"

# ── Git prompt helpers ──────────────────────────
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}⟨"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[yellow]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[yellow]%}↓"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●"

# ── Prompt principal ───────────────────────────
# usuario@host : directorio verde neon
# git branch + status
# línea inferior: ▶ cursor

PROMPT='
%{$fg_bold[green]%}%n%{$fg[cyan]%}@%{$fg_bold[cyan]%}%m %{$fg[yellow]%}⟫%{$reset_color%} %{$fg_bold[white]%}%~%{$reset_color%}
%{$fg[green]%}$(git_prompt_info)%{$reset_color%}%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})▷%{$reset_color%} '

# ── Prompt derecho (reloj + contexto) ──────────
RPROMPT='%{$fg_bold[yellow]%}%D{%H:%M:%S}%{$reset_color%}'

# ── Modo vi ─────────────────────────────────────
# Vi mode en la izquierda si está activo
MODE_INDICATOR="%{$fg_bold[red]%}[NORMAL]%{$reset_color%}"
MODE_INDICATOR_VIINS="%{$fg_bold[green]%}[INSERT]%{$reset_color%}"
MODE_INDICATOR_VICMD="%{$fg_bold[red]%}[NORMAL]%{$reset_color%}"