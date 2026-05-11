#!/bin/bash
# ═══════════════════════════════════════════════════════════
# AGENTIZE — Script de instalación y sincronización de dotfiles
# Repo: github.com/sanolumpen/yoda-sanostyle.git
# ═══════════════════════════════════════════════════════════

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/Documentos/dotfiles}"
CONFIG="$HOME/.config"
BACKUP="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
LOG="/tmp/dotfiles-install.log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[DOTFILES]${NC} $1" | tee -a "$LOG"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOG"; }
err() { echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG"; }

# Detectar distro
detect_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        OS=$ID
    else
        OS="unknown"
    fi
    log "Sistema detectado: $OS"
}

# Backup de ~/.config
backup_config() {
    if [ -d "$CONFIG" ]; then
        log "Creando backup de ~/.config → $BACKUP"
        cp -r "$CONFIG" "$BACKUP"
    fi
}

# Instalar dependencias por distro
install_deps() {
    case "$OS" in
        debian|ubuntu)
            log "Instalando paquetes Debian/Ubuntu..."
            sudo apt update
            # Leer pkglist si existe
            if [ -f "$DOTFILES/pkg/debian13.txt" ]; then
                sudo apt install -y $(grep -v '^#' "$DOTFILES/pkg/debian13.txt" | tr '\n' ' ')
            fi
            ;;
        arch|manjaro|endeavouros)
            log "Instalando paquetes Arch..."
            sudo pacman -Sy --noconfirm
            if [ -f "$DOTFILES/pkglist.txt" ]; then
                sudo pacman -S --noconfirm --needed $(grep -v '^#' "$DOTFILES/pkglist.txt" | tr '\n' ' ')
            fi
            ;;
        fedora)
            log "Instalando paquetes Fedora..."
            sudo dnf install -y $(cat "$DOTFILES/pkglist.txt" 2>/dev/null || true)
            ;;
        *)
            warn "Distro no soportada para auto-instalación: $OS"
            ;;
    esac
}

# Instalar EWE desde source si no existe
install_eww() {
    if ! command -v eww &> /dev/null; then
        log "Instalando EWW desde source..."
        # Dependencias de compilación
        case "$OS" in
            debian|ubuntu) sudo apt install -y libgtk-3-dev libpolkit-gobject-1-dev cargo ;;
            arch) sudo pacman -S --noconfirm gtk3 polkit cargo ;;
        esac
        cargo install --git https://github.com/elkowar/eww.git 2>&1 | tee -a "$LOG"
    else
        log "EWW ya instalado: $(eww --version)"
    fi
}

# Instalar swwg desde source si no existe
install_swww() {
    if ! command -v swww &> /dev/null; then
        log "Instalando swww..."
        case "$OS" in
            debian|ubuntu) sudo apt install -y git gcc libmpack-dev libepoxy-dev librsvg2-dev cargo ;;
            arch) sudo pacman -S --noconfirm git gcc cargo librsvg ;;
        esac
        git clone https://github.com/nicholagi/mpvpaper /tmp/mpvpaper 2>/dev/null || true
        cargo install --git https://github.com/nicholagi/swww.git 2>&1 | tee -a "$LOG"
    else
        log "swww ya instalado: $(swww --version 2>/dev/null || echo 'unknown')"
    fi
}

# ═══════════════════════════════════════════════════════════
# ZSH PLUGINS — install missing zsh plugins for Yoda theme
# ═══════════════════════════════════════════════════════════
install_zsh_plugins() {
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.zsh-plugins}"
    mkdir -p "$ZSH_CUSTOM/plugins"
    mkdir -p "$ZSH_CUSTOM/themes"

    # zsh-autosuggestions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        log "  Instalando zsh-autosuggestions..."
        git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git \
            "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>&1 | tee -a "$LOG"
    else
        log "  zsh-autosuggestions ya instalado"
    fi

    # zsh-syntax-highlighting
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        log "  Instalando zsh-syntax-highlighting..."
        git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>&1 | tee -a "$LOG"
    else
        log "  zsh-syntax-highlighting ya instalado"
    fi

    # Yoda theme
    if [ -f "$DOTFILES/.oh-my-zsh/custom/themes/yoda.zsh-theme" ]; then
        cp "$DOTFILES/.oh-my-zsh/custom/themes/yoda.zsh-theme" \
           "$ZSH_CUSTOM/themes/yoda.zsh-theme"
        log "  ✅ Tema Yoda instalado"
    fi
}

# ═══════════════════════════════════════════════════════════
# Vincular/sincronizar configs
# ═══════════════════════════════════════════════════════════
link_configs() {

    # Instalar plugins zsh antes de linkear
    install_zsh_plugins

    log "Sincronizando configs..."
    
    # Lista de directorios a sincronizar
    DIRS=(
        "alacritty"
        "btop"
        "cava"
        "eww"
        "fastfetch"
        "flameshot"
        "gtk-3.0"
        "htop"
        "hypr"
        "kitty"
        "lazydocker"
        "mako"
        "nemo"
        "nvim"
        "waybar"
        "wofi"
        "wlogout"
    )
    
    for dir in "${DIRS[@]}"; do
        if [ -d "$DOTFILES/$dir" ]; then
            # Eliminar existente si es link o dir vacía
            rm -rf "$CONFIG/$dir" 2>/dev/null || true
            mkdir -p "$(dirname "$CONFIG/$dir")"
            ln -sf "$DOTFILES/$dir" "$CONFIG/$dir"
            log "  ✅ $dir → ~/.config/$dir"
        fi
    done
    
    # Archivos sueltos
    FILES=(
        ".zshrc"
        "mimeapps.list"
        "pavucontrol.ini"
    )
    for file in "${FILES[@]}"; do
        if [ -f "$DOTFILES/$file" ]; then
            rm -f "$CONFIG/$file" 2>/dev/null || true
            ln -sf "$DOTFILES/$file" "$CONFIG/$file"
            log "  ✅ $file → ~/.config/$file"
        fi
    done
}

# Recargar servicios
reload_services() {
    log "Recargando servicios..."
    
    # Hyprland
    if command -v hyprctl &> /dev/null; then
        hyprctl reload 2>/dev/null && log "  ✅ Hyprland recargado" || warn "  ⚠️ Hyprland reload falló"
    fi
    
    # Waybar
    pkill waybar 2>/dev/null; sleep 1; waybar &
    log "  ✅ Waybar reiniciado"
    
    # EWW
    pkill -f eww 2>/dev/null; sleep 1
    eww daemon 2>/dev/null
    sleep 2
    eww open-many dashboard_window date_window football_window notes_window 2>/dev/null || true
    log "  ✅ EWW reiniciado"
    
    # Mako
    pkill mako 2>/dev/null; mako &
    log "  ✅ Mako reiniciado"
}

# Sync: pull del repo y restaurar
sync_pull() {
    log "Sincronizando desde repo..."
    cd "$DOTFILES" || return 1
    git pull origin "$(git rev-parse --abbrev-ref HEAD)" 2>&1 | tee -a "$LOG"
    link_configs
    reload_services
    log "✅ Sync completado"
}

# Push: commit y push de cambios locales
sync_push() {
    local msg="${1:-auto: $(date +%Y-%m-%d_%H:%M)}"
    log "Haciendo commit: $msg"
    cd "$DOTFILES" || return 1
    git add -A
    git commit -m "$msg" 2>&1 | tee -a "$LOG"
    git push origin "$(git rev-parse --abbrev-ref HEAD)" 2>&1 | tee -a "$LOG"
    log "✅ Push completado"
}

# Mostrar ayuda
show_help() {
    echo "Uso: agentize.sh [comando]"
    echo ""
    echo "Comandos:"
    echo "  full        Instalación completa (deps + link + reload)"
    echo "  install     Solo instalar dependencias"
    echo "  link        Solo sincronizar symlinks"
    echo "  reload      Solo recargar servicios"
    echo "  pull        Git pull + recargar"
    echo "  push [msg]  Git commit + push"
    echo "  backup      Backup de ~/.config actual"
    echo "  status      Mostrar estado git"
    echo ""
    echo "Variables:"
    echo "  DOTFILES=/ruta/a/dotfiles  (default: ~/Documentos/dotfiles)"
}

# Main
case "${1:-help}" in
    full)
        detect_os
        backup_config
        install_deps
        install_eww
        install_swww
        link_configs
        reload_services
        log "🎉 ¡Instalación completa!"
        ;;
    install)
        detect_os
        install_deps
        install_eww
        install_swww
        ;;
    link)
        link_configs
        ;;
    reload)
        reload_services
        ;;
    pull)
        detect_os
        sync_pull
        ;;
    push)
        sync_push "${2:-}"
        ;;
    backup)
        backup_config
        ;;
    status)
        cd "$DOTFILES" && git status --short
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        err "Comando desconocido: $1"
        show_help
        exit 1
        ;;
esac
