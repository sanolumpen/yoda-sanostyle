# ═══════════════════════════════════════════════════════════
#  Yoda Theme — Oh My Zsh
#  Dark background palette with neon accents
#  Inspired by Kuri-Dots Yoda Rice
# ═══════════════════════════════════════════════════════════

# ── Paleta de colores (truecolor, fondo negro) ────────
# Neon Green : #00ff99  — sable de luz (solo acentos clave)
# Mint Cyan   : #4af5d4  — usuario, detalles
# Sky Blue    : #87dfff  — host
# White/Light : #e0e0e0  — texto principal (directorio)
# Gold Yellow  : #ffd700  — reloj, info
# Bright Red   : #ff4d4d  — errores, dirty
# Soft Green   : #66ff66  — clean, prompt char
# Magenta/Pink : #ff79c6  — modo vi, staging

# ── Git prompt helpers ──────────────────────────────
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[#87dfff]%}⟨"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[#ff4d4d]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[#66ff66]%} ✓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[#ffd700]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[#ffd700]%}↓"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[#ff79c6]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[#ffd700]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[#ff4d4d]%}●"

# ── Prompt principal ───────────────────────────────
# user@host : directorio
# git status
# ▷ cursor

PROMPT='%{$fg[#4af5d4]%}%n%{$fg_bold[#87dfff]%}@%m %{$fg_bold[#e0e0e0]%}%~%{$reset_color%}
%{$fg[#87dfff]%}$(git_prompt_info)%{$reset_color%}%(?.%{$fg[#66ff66]%}.%{$fg[#ff4d4d]%})▷%{$reset_color%} '

# ── Prompt derecho (reloj + contexto) ──────────────
RPROMPT='%{$fg_bold[#ffd700]%}%D{%H:%M:%S}%{$reset_color%}'

# ── Modo vi ────────────────────────────────────────
MODE_INDICATOR="%{$fg_bold[#ff79c6]%}[NORMAL]%{$reset_color%}"
MODE_INDICATOR_VIINS="%{$fg_bold[#66ff66]%}[INSERT]%{$reset_color%}"
MODE_INDICATOR_VICMD="%{$fg_bold[#ff4d4d]%}[NORMAL]%{$reset_color%}"