#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# KURI-DOTS INSTALLER
# Instala las configuraciones en ~/.config/
# ═══════════════════════════════════════════════════════════════════

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config.kuri-dots.backup"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}    $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    cat << EOF
╔══════════════════════════════════════════════════════════╗
║              KURI-DOTS INSTALLER                         ║
╚══════════════════════════════════════════════════════════╝

 USO: $0 [OPCIONES]

 OPCIONES:
   --all         Instalar todos los componentes (default)
   --dry-run     Mostrar qué se instalaría sin hacer cambios
   --backup      Crear backup antes de instalar
   -h, --help    Mostrar esta ayuda

 EJEMPLOS:
   $0                  # Instalar todo
   $0 --dry-run        # Ver qué se instalaría
   $0 --backup         # Backup + instalar

 COMPONENTES:
   - hypr/       (Hyprland config)
   - eww/        (EWW widgets)
   - waybar/     (Waybar status bar)
   - alacritty/  (Terminal)
   - kitty/      (Terminal alternativo)
   - nemo/      (File manager)
   - cava/      (Audio visualizer)
   - wofi/       (App launcher)
   - wlogout/   (Logout screen)
   - mako/       (Notifications)
   - btop/       (System monitor)
   - nvim/       (Neovim config)
   - tmux/       (Terminal multiplexer)
   - lazygit/    (Git UI)
   - fastfetch/ (System info)
   - flameshot/  (Screenshots)

EOF
}

detect_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

backup_config() {
    if [ -d "$CONFIG_DIR" ] && [ "$(ls -A $CONFIG_DIR 2>/dev/null)" ]; then
        log_info "Creando backup en $BACKUP_DIR"
        rm -rf "$BACKUP_DIR"
        cp -r "$CONFIG_DIR" "$BACKUP_DIR"
        log_ok "Backup creado"
    fi
}

install_component() {
    local component=$1
    local src="$REPO_DIR/$component"
    local dest="$CONFIG_DIR/$component"

    if [ ! -d "$src" ]; then
        log_warn "$component no existe en el repo, saltando"
        return
    fi

    mkdir -p "$CONFIG_DIR"
    rm -rf "$dest"
    cp -r "$src" "$dest"
    log_ok "$component"
}

main() {
    local do_backup=false
    local dry_run=false
    local install_all=true

    for arg in "$@"; do
        case $arg in
            --backup) do_backup=true ;;
            --dry-run) dry_run=true ;;
            --all) install_all=true ;;
            -h|--help) usage; exit 0 ;;
            *) log_error "Opción desconocida: $arg"; usage; exit 1 ;;
        esac
    done

    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║              KURI-DOTS INSTALLER                         ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""

    local os=$(detect_os)
    log_info "Sistema detectado: $os"
    log_info "Repo: $REPO_DIR"
    log_info "Destino: $CONFIG_DIR"
    echo ""

    if [ "$dry_run" = true ]; then
        log_info "Modo dry-run - solo mostrando componentes"
        echo ""
        for dir in hypr eww waybar alacritty kitty nemo cava wofi wlogout mako btop nvim tmux lazygit fastfetch flameshot; do
            if [ -d "$REPO_DIR/$dir" ]; then
                echo "  ✓ $dir (se instalará)"
            fi
        done
        echo ""
        exit 0
    fi

    if [ "$do_backup" = true ]; then
        backup_config
    fi

    echo "══════════════════════════════════════════════════════════"
    echo "  INSTALANDO COMPONENTES"
    echo "══════════════════════════════════════════════════════════"
    echo ""

    local components=(
        "hypr"
        "eww"
        "waybar"
        "alacritty"
        "kitty"
        "nemo"
        "cava"
        "wofi"
        "wlogout"
        "mako"
        "btop"
        "nvim"
        "tmux"
        "lazygit"
        "fastfetch"
        "flameshot"
    )

    for comp in "${components[@]}"; do
        install_component "$comp"
    done

    echo ""
    echo "══════════════════════════════════════════════════════════"
    log_ok "INSTALACIÓN COMPLETA"
    echo "══════════════════════════════════════════════════════════"
    echo ""
    echo "  ⚠️  Reinicia Hyprland para aplicar cambios:"
    echo "      \$ hyprctl reload"
    echo ""
    echo "  📝 Para sincronizar cambios locales al repo:"
    echo "      \$ ./scripts/sync-kuri-dots.sh push-repo"
    echo ""
}

main "$@"