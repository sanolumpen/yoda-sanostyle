#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# KURI-DOTS SYNC SCRIPT
# Sincroniza entre ~/.config/ (local) y ~/descargas/kuri-dots (repo)
# Prioriza cambios locales, pero puede restaurar desde repo
# ═══════════════════════════════════════════════════════════════════

set -e

LOCAL_DIR="$HOME/.config"
REPO_DIR="$HOME/descargas/kuri-dots"
BACKUP_DIR="$HOME/.kuri-dots-backups"

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
╔═══════════════════════════════════════════════════════════╗
║              KURI-DOTS SYNC TOOL                          ║
╚═══════════════════════════════════════════════════════════╝

USO: $0 [COMANDO] [OPCIONES]

COMANDOS:
  pull-local      Sincronizar cambios del repo → ~/.config/
                  (usa archivos del repo)
  push-repo       Sincronizar cambios de ~/.config/ → repo
                  (actualiza kuri-dots con cambios locales)
  status          Ver diferencias entre local y repo
  backup-local    Backup completo de ~/.config/
  diff [dir]      Comparar directorio específico

OPCIONES:
  -f, --force      Forzar sobrescritura sin confirmación
  -d, --dry-run   Mostrar qué haría sin ejecutar
  -h, --help      Mostrar esta ayuda

EJEMPLOS:
  $0 status                    # Ver diferencias
  $0 pull-local                # Traer cambios del repo
  $0 push-repo                  # Subir cambios locales al repo
  $0 pull-local -f             # Forzar sin preguntar

EOF
}

dirs_to_sync=(
    "alacritty"
    "eww"
    "fastfetch"
    "flameshot"
    "htop"
    "hypr"
    "lazydocker"
    "lazygit"
    "mako"
    "nvim"
    "tmux"
    "waybar"
    "wofi"
    "wlogout"
)

backup_local() {
    local ts=$(date +%Y%m%d_%H%M%S)
    local backup_path="$BACKUP_DIR/local_backup_$ts.tar.gz"

    log_info "Creando backup de ~/.config/ ..."

    # Solo respaldar dirs que tenemos en repo
    local dirs_to_backup=()
    for dir in "${dirs_to_sync[@]}"; do
        if [[ -d "$LOCAL_DIR/$dir" ]]; then
            dirs_to_backup+=("$dir")
        fi
    done

    cd "$LOCAL_DIR"
    tar -czf "$backup_path" "${dirs_to_backup[@]}" 2>/dev/null || true

    log_ok "Backup creado: $backup_path"
}

show_status() {
    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                  STATUS DE SINCRONIZACIÓN                 ║"
    echo "╠══════════════════════════════════════════════════════════╣"

    for dir in "${dirs_to_sync[@]}"; do
        local_repo="$REPO_DIR/$dir"
        local_dir="$LOCAL_DIR/$dir"

        if [[ -d "$local_dir" ]] && [[ -d "$local_repo" ]]; then
            # Comparar con diff
            local diff_output=$(diff -rq "$local_repo" "$local_dir" 2>/dev/null | head -5)
            if [[ -z "$diff_output" ]]; then
                echo -e "║  ${GREEN}✓${NC}  $dir                                             ║"
            else
                count=$(diff -rq "$local_repo" "$local_dir" 2>/dev/null | wc -l)
                echo -e "║  ${YELLOW}⚠${NC}  $dir ($count diferencias)                        ║"
            fi
        elif [[ -d "$local_dir" ]]; then
            echo -e "║  ${BLUE}☆${NC}  $dir (solo local, no en repo)                 ║"
        elif [[ -d "$local_repo" ]]; then
            echo -e "║  ${RED}✗${NC}  $dir (solo en repo, no instalado)             ║"
        fi
    done

    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""
    echo "Leyenda:"
    echo "  ✓ = Sincronizado"
    echo "  ⚠ = Diferencias (revisar con 'diff')"
    echo "  ☆ = Solo local (no en repo)"
    echo "  ✗ = Solo en repo (no instalado)"
}

pull_from_repo() {
    local FORCE=$1
    local DRY_RUN=$2

    log_info "Sincronizando desde repo → local..."

    if [[ "$DRY_RUN" == "true" ]]; then
        log_warn "DRY RUN - No se harán cambios"
    fi

    for dir in "${dirs_to_sync[@]}"; do
        local_repo="$REPO_DIR/$dir"
        local_dir="$LOCAL_DIR/$dir"

        if [[ ! -d "$local_repo" ]]; then
            continue
        fi

        echo ""
        log_info "Procesando: $dir"

        if [[ ! -d "$local_dir" ]]; then
            if [[ "$DRY_RUN" == "true" ]]; then
                log_info "  [NUEVO] $local_dir/"
            else
                mkdir -p "$local_dir"
                cp -r "$local_repo"/* "$local_dir/"
                log_ok "  Creado: $local_dir/"
            fi
            continue
        fi

        # Comparar archivos
        for file in "$local_repo"/*; do
            [[ -f "$file" ]] || continue
            filename=$(basename "$file")
            local_file="$local_dir/$filename"

            if [[ ! -f "$local_file" ]]; then
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_info "  [NUEVO] $filename"
                else
                    cp "$file" "$local_file"
                    log_ok "  + $filename"
                fi
            elif diff -q "$file" "$local_file" > /dev/null 2>&1; then
                # Iguales, no hacer nada
                :
            else
                # Diferentes
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_warn "  [MOD] $filename (diferente)"
                else
                    if [[ "$FORCE" == "true" ]]; then
                        cp "$file" "$local_file"
                        log_ok "  [REPLACED] $filename"
                    else
                        log_warn "  [KEEP] $filename (local differs, keeping)"
                    fi
                fi
            fi
        done

        # Scripts especiales - merger inteligente
        if [[ "$dir" == "eww" ]]; then
            sync_eww_scripts "$DRY_RUN" "$FORCE"
        elif [[ "$dir" == "hypr" ]]; then
            sync_hypr_scripts "$DRY_RUN" "$FORCE"
        fi
    done

    log_ok "Sincronización completa!"
}

sync_eww_scripts() {
    local DRY_RUN=$1
    local FORCE=$2
    local repo_scripts="$REPO_DIR/eww/scripts"
    local local_scripts="$LOCAL_DIR/eww/scripts"

    [[ ! -d "$repo_scripts" ]] && return

    log_info "  Sincronizando scripts eww..."

    # Scripts del repo base
    for script in "$repo_scripts"/*.sh; do
        [[ -f "$script" ]] || continue
        filename=$(basename "$script")

        # Si no existe en local, copiar
        if [[ ! -f "$local_scripts/$filename" ]]; then
            if [[ "$DRY_RUN" == "true" ]]; then
                log_info "    [NUEVO] $filename"
            else
                cp "$script" "$local_scripts/$filename"
                log_ok "    + $filename"
            fi
        fi
    done

    # Scripts locales únicos (los que tú creaste)
    log_info "  Scripts locales únicos detectados:"
    for script in "$local_scripts"/*.sh; do
        [[ -f "$script" ]] || continue
        filename=$(basename "$script")

        if [[ ! -f "$repo_scripts/$filename" ]]; then
            log_info "    ☆ $filename (solo local)"
        fi
    done
}

sync_hypr_scripts() {
    local DRY_RUN=$1
    local FORCE=$2
    local repo_scripts="$REPO_DIR/hypr/scripts"
    local local_scripts="$LOCAL_DIR/hypr/scripts"

    [[ ! -d "$repo_scripts" ]] && return

    log_info "  Sincronizando scripts hypr..."

    for script in "$repo_scripts"/*.sh; do
        [[ -f "$script" ]] || continue
        filename=$(basename "$script")
        local_file="$local_scripts/$filename"

        if [[ ! -f "$local_file" ]]; then
            if [[ "$DRY_RUN" == "true" ]]; then
                log_info "    [NUEVO] $filename"
            else
                cp "$script" "$local_file"
                log_ok "    + $filename"
            fi
        fi
    done
}

push_to_repo() {
    local FORCE=$1
    local DRY_RUN=$2

    log_warn "Esto actualizará el repositorio kuri-dots con tus cambios locales"
    log_warn "Los scripts personalizados (football.sh, notes.sh, etc) serán agregados"
    echo ""

    if [[ "$DRY_RUN" == "true" ]]; then
        log_warn "DRY RUN - No se harán cambios"
    fi

    if [[ "$DRY_RUN" != "true" ]] && [[ "$FORCE" != "true" ]]; then
        read -p "¿Continuar? (escribe 'sync': " confirm
        if [[ "$confirm" != "sync" ]]; then
            log_info "Cancelado"
            exit 0
        fi
    fi

    for dir in "${dirs_to_sync[@]}"; do
        local_dir="$LOCAL_DIR/$dir"
        local_repo="$REPO_DIR/$dir"

        if [[ ! -d "$local_dir" ]]; then
            continue
        fi

        echo ""
        log_info "Procesando: $dir"

        if [[ ! -d "$local_repo" ]]; then
            mkdir -p "$local_repo"
        fi

        # Copiar archivos de local a repo
        for file in "$local_dir"/*; do
            [[ -f "$file" ]] || continue
            filename=$(basename "$file")
            repo_file="$local_repo/$filename"

            if [[ -f "$repo_file" ]] && ! diff -q "$file" "$repo_file" > /dev/null 2>&1; then
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_info "  [UPDATE] $filename (actualizado localmente)"
                else
                    cp "$file" "$repo_file"
                    log_ok "  ↑ $filename"
                fi
            elif [[ ! -f "$repo_file" ]]; then
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_info "  [NEW] $filename (nuevo script local)"
                else
                    cp "$file" "$repo_file"
                    log_ok "  + $filename (nuevo en repo)"
                fi
            fi
        done

        # Sincronizar scripts especialmente
        if [[ "$dir" == "eww" ]]; then
            push_eww_scripts "$DRY_RUN"
        elif [[ "$dir" == "hypr" ]]; then
            push_hypr_scripts "$DRY_RUN"
        fi
    done

    # Copiar archivos sueltos importantes
    log_info "Copiando archivos de configuración raíz..."
    [[ -f "$LOCAL_DIR/mimeapps.list" ]] && cp "$LOCAL_DIR/mimeapps.list" "$REPO_DIR/mimeapps.list"
    [[ -f "$LOCAL_DIR/pavucontrol.ini" ]] && cp "$LOCAL_DIR/pavucontrol.ini" "$REPO_DIR/pavucontrol.ini"

    log_ok "Push completado!"
    log_info "Recuerda hacer commit en el repo: cd $REPO_DIR && git add . && git commit"
}

push_eww_scripts() {
    local DRY_RUN=$1
    local local_scripts="$LOCAL_DIR/eww/scripts"
    local repo_scripts="$REPO_DIR/eww/scripts"

    [[ ! -d "$local_scripts" ]] && return

    log_info "  Agregando scripts eww al repo..."

    for script in "$local_scripts"/*.sh; do
        [[ -f "$script" ]] || continue
        filename=$(basename "$script")

        if [[ ! -f "$repo_scripts/$filename" ]]; then
            if [[ "$DRY_RUN" == "true" ]]; then
                log_info "    [NEW] $filename"
            else
                cp "$script" "$repo_scripts/$filename"
                log_ok "    + $filename"
            fi
        fi
    done
}

push_hypr_scripts() {
    local DRY_RUN=$1
    local local_scripts="$LOCAL_DIR/hypr/scripts"
    local repo_scripts="$REPO_DIR/hypr/scripts"

    [[ ! -d "$local_scripts" ]] && return

    log_info "  Agregando scripts hypr al repo..."

    for script in "$local_scripts"/*.sh; do
        [[ -f "$script" ]] || continue
        filename=$(basename "$script")

        if [[ ! -f "$repo_scripts/$filename" ]]; then
            if [[ "$DRY_RUN" == "true" ]]; then
                log_info "    [NEW] $filename"
            else
                cp "$script" "$repo_scripts/$filename"
                log_ok "    + $filename"
            fi
        fi
    done
}

show_diff() {
    local target="${1:-eww}"

    local local_dir="$LOCAL_DIR/$target"
    local repo_dir="$REPO_DIR/$target"

    if [[ ! -d "$local_dir" ]]; then
        log_error "No existe: $local_dir"
        return
    fi

    echo ""
    log_info "Diferencias en $target:"
    echo ""

    if [[ -d "$repo_dir" ]]; then
        diff -u --color=always "$repo_dir" "$local_dir" 2>/dev/null | head -100 || true
    else
        log_warn "El directorio no existe en el repo"
    fi
}

# ─── Parseo de argumentos ─────────────────────────────────────────
COMMAND=""
FORCE=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force) FORCE=true; shift ;;
        -d|--dry-run) DRY_RUN=true; shift ;;
        -h|--help) usage; exit 0 ;;
        pull-local|push-repo|status|backup-local|diff)
            COMMAND="$1"; shift ;;
        *) break ;;
    esac
done

# ─── Ejecución ───────────────────────────────────────────────────
case "$COMMAND" in
    status)
        show_status
        ;;
    pull-local)
        backup_local
        pull_from_repo "$FORCE" "$DRY_RUN"
        ;;
    push-repo)
        push_to_repo "$FORCE" "$DRY_RUN"
        ;;
    backup-local)
        backup_local
        ;;
    diff)
        show_diff "$1"
        ;;
    *)
        usage
        exit 1
        ;;
esac