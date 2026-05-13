#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# SANO DOTS INSTALLER
║              SANO DOTS INSTALLER                          ║
    echo "║              SANO DOTS INSTALLER                          ║"
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
    echo "      \$ ./scripts/sync-sano-dots.sh push-repo"
    echo ""
}

main "$@"