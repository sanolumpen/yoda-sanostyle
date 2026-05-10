#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# KURI-DOTS BACKUP & RESTORE SCRIPT
# Backup completo del proyecto kuri-dots con versionado
# ═══════════════════════════════════════════════════════════════════

set -e

# ─── Configuración ────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KURI_DOTS_DIR="$SCRIPT_DIR"
BACKUP_BASE_DIR="${BACKUP_DIR:-$HOME/.kuri-dots-backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="kuri-dots_backup_$TIMESTAMP"
BACKUP_PATH="$BACKUP_BASE_DIR/$BACKUP_NAME"
CURRENT_LINK="$BACKUP_BASE_DIR/latest"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ─── Funciones ────────────────────────────────────────────────────
log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}    $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    cat << EOF
╔═══════════════════════════════════════════════════════════╗
║           KURI-DOTS BACKUP & RESTORE TOOL                 ║
╚═══════════════════════════════════════════════════════════╝

USO: $0 [COMANDO] [OPCIONES]

COMANDOS:
  backup              Crear backup completo del proyecto
  restore [BACKUP]    Restaurar desde backup (default: latest)
  list                Listar backups disponibles
  diff [BACKUP]       Ver cambios desde un backup
  clean [N]           Mantener solo los N backups más recientes

OPCIONES:
  -q, --quiet         Modo silencioso
  -v, --verbose       Salida detallada
  -h, --help          Mostrar esta ayuda

EJEMPLOS:
  $0 backup                    # Backup completo
  $0 restore                   # Restaurar último backup
  $0 restore kuri-dots_backup_20250510_120000  # Restaurar específico
  $0 list                      # Ver todos los backups
  $0 clean 5                   # Mantener solo 5 backups

BACKUP LOCATION: $BACKUP_BASE_DIR

EOF
}

create_backup() {
    log_info "Iniciando backup de kuri-dots..."

    # Crear directorio de backup si no existe
    mkdir -p "$BACKUP_PATH"

    # Metadata del sistema
    cat > "$BACKUP_PATH/META.json" << EOF
{
    "name": "$BACKUP_NAME",
    "timestamp": "$TIMESTAMP",
    "date": "$(date -Iseconds)",
    "hostname": "$(hostname)",
    "user": "$(whoami)",
    "kuri_version": "$(git -C "$KURI_DOTS_DIR" describe --always 2>/dev/null || echo 'unknown')",
    "kuri_branch": "$(git -C "$KURI_DOTS_DIR" branch --show-current 2>/dev/null || echo 'unknown')"
}
EOF

    # Copiar estructura completa preservando permisos
    log_info "Copiando archivos..."
    rsync -aAXv \
        --exclude='.git/objects/' \
        --exclude='.git/index' \
        --exclude='*.log' \
        --exclude='*.tmp' \
        "$KURI_DOTS_DIR/" "$BACKUP_PATH/kuri-dots/"

    # Crear checksum para verificación
    log_info "Generando checksums..."
    find "$BACKUP_PATH" -type f ! -name "META.json" -exec md5sum {} \; > "$BACKUP_PATH/checksums.md5"

    # Comprimir para ahorrar espacio
    log_info "Comprimiendo backup..."
    cd "$BACKUP_BASE_DIR"
    tar -czf "${BACKUP_NAME}.tar.gz" "$BACKUP_NAME"
    rm -rf "$BACKUP_NAME"

    # Crear enlace al más reciente
    rm -f "$CURRENT_LINK"
    ln -s "$BACKUP_PATH.tar.gz" "$CURRENT_LINK"

    # Guardar lista de archivos
    tar -tzf "${BACKUP_NAME}.tar.gz" > "${BACKUP_NAME}.files.txt"

    log_ok "Backup creado: $BACKUP_PATH.tar.gz"
    log_ok "Tamaño: $(du -h "${BACKUP_NAME}.tar.gz" | cut -f1)"
    log_ok "Enlace 'latest': $CURRENT_LINK"
}

restore_backup() {
    local backup_name="${1:-latest}"

    # Resolver latest
    if [[ "$backup_name" == "latest" ]]; then
        if [[ -L "$CURRENT_LINK" ]]; then
            backup_name=$(basename "$(readlink -f "$CURRENT_LINK")" .tar.gz)
        else
            log_error "No hay backup 'latest' disponible"
            list_backups
            exit 1
        fi
    fi

    local backup_file="$BACKUP_BASE_DIR/${backup_name}.tar.gz"

    if [[ ! -f "$backup_file" ]]; then
        log_error "Backup no encontrado: $backup_file"
        log_info "Backups disponibles:"
        list_backups
        exit 1
    fi

    log_warn "Esto reemplazará TODOS los archivos actuales de kuri-dots!"
    read -p "¿Continuar con la restauración? (escribe 'yes': " confirm
    if [[ "$confirm" != "yes" ]]; then
        log_info "Restauración cancelada"
        exit 0
    fi

    log_info "Restaurando desde: $backup_name"

    # Verificar checksums antes de restaurar
    log_info "Verificando integridad..."
    tar -xzf "$backup_file" -C "$BACKUP_BASE_DIR"
    local extract_dir="$BACKUP_BASE_DIR/$backup_name"

    if command -v md5sum &> /dev/null; then
        cd "$extract_dir"
        if ! md5sum -c checksums.md5 > /dev/null 2>&1; then
            log_error "Checksum fallido - backup corrupto!"
            rm -rf "$extract_dir"
            exit 1
        fi
        cd - > /dev/null
    fi

    # Hacer backup del estado actual primero (por seguridad)
    local current_backup="${TIMESTAMP}_pre_restore"
    log_info "Creando backup de estado actual..."
    mkdir -p "$BACKUP_BASE_DIR/$current_backup"
    rsync -aAX "$KURI_DOTS_DIR/" "$BACKUP_BASE_DIR/$current_backup/current_state/"
    tar -czf "$BACKUP_BASE_DIR/${current_backup}.tar.gz" -C "$BACKUP_BASE_DIR" "$current_backup"
    rm -rf "$BACKUP_BASE_DIR/$current_backup"

    # Restaurar archivos
    log_info "Restaurando archivos..."
    rsync -aAX "$extract_dir/kuri-dots/" "$KURI_DOTS_DIR/"

    # Limpiar directorio extraído
    rm -rf "$extract_dir"

    log_ok "Restauración completa!"
    log_info "Estado anterior salvado en: $BACKUP_BASE_DIR/${current_backup}.tar.gz"
}

list_backups() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║              BACKUPS DISPONIBLES                     ║"
    echo "╠══════════════════════════════════════════════════════╣"

    if [[ ! -d "$BACKUP_BASE_DIR" ]] || [[ -z $(ls -A "$BACKUP_BASE_DIR"/*.tar.gz 2>/dev/null) ]]; then
        echo "║  No hay backups disponibles                          ║"
    else
        printf "║  %-50s %10s║\n" "NOMBRE" "TAMAÑO"
        echo "╠══════════════════════════════════════════════════════╣"
        for backup in "$BACKUP_BASE_DIR"/*.tar.gz; do
            [[ -f "$backup" ]] || continue
            name=$(basename "$backup" .tar.gz)
            size=$(du -h "$backup" | cut -f1)
            marker=""
            if [[ -L "$CURRENT_LINK" ]] && [[ "$(basename "$(readlink -f "$CURRENT_LINK")")" == "$(basename "$backup")" ]]; then
                marker=" ← latest"
            fi
            printf "║  %-50s %6s%s║\n" "$name" "$size" "$marker"
        done
    fi
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""
}

diff_backup() {
    local backup_name="${1:-latest}"

    if [[ "$backup_name" == "latest" ]] && [[ -L "$CURRENT_LINK" ]]; then
        backup_name=$(basename "$(readlink -f "$CURRENT_LINK")" .tar.gz)
    fi

    local backup_file="$BACKUP_BASE_DIR/${backup_name}.tar.gz"

    if [[ ! -f "$backup_file" ]]; then
        log_error "Backup no encontrado: $backup_file"
        exit 1
    fi

    log_info "Comparando backup '$backup_name' con estado actual..."

    # Extraer temporalmente
    local temp_dir=$(mktemp -d)
    tar -xzf "$backup_file" -C "$temp_dir"

    echo ""
    echo "═══ ARCHIVOS AGREGADOS (en backup, no en actual) ═══"
    comm -23 \
        <(tar -tzf "$backup_file" | sed 's|[^/]*$||' | sort -u) \
        <(find "$KURI_DOTS_DIR" -type f | sed "s|$KURI_DOTS_DIR/||" | sort -u) \
        2>/dev/null || true

    echo ""
    echo "═══ ARCHIVOS ELIMINADOS (en actual, no en backup) ═══"
    comm -13 \
        <(tar -tzf "$backup_file" | sort -u) \
        <(find "$KURI_DOTS_DIR" -type f | sed "s|$KURI_DOTS_DIR/||" | sort -u) \
        2>/dev/null || true

    # Limpiar
    rm -rf "$temp_dir"
}

clean_backups() {
    local keep="${1:-3}"

    if [[ ! -d "$BACKUP_BASE_DIR" ]]; then
        log_info "No hay backups para limpiar"
        return
    fi

    local count=$(ls -1 "$BACKUP_BASE_DIR"/*.tar.gz 2>/dev/null | wc -l)

    if [[ "$count" -le "$keep" ]]; then
        log_info "Tienes $count backups, se mantienen los $keep"
        return
    fi

    log_warn "Se eliminarán $(($count - $keep)) backups antiguos"

    # Excluir 'latest'
    ls -1t "$BACKUP_BASE_DIR"/*.tar.gz 2>/dev/null | tail -n +$((keep + 1)) | while read backup; do
        if [[ -L "$CURRENT_LINK" ]] && [[ "$(readlink -f "$CURRENT_LINK")" == "$(realpath "$backup")" ]]; then
            continue
        fi
        rm -f "$backup"
        log_info "Eliminado: $(basename "$backup")"
    done

    log_ok "Limpieza completa"
}

# ─── Parseo de argumentos ─────────────────────────────────────────
QUIET=false
VERBOSE=false
COMMAND=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quiet)
            QUIET=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        backup|restore|list|diff|clean)
            COMMAND="$1"
            shift
            ;;
        *)
            break
            ;;
    esac
done

# ─── Ejecución ───────────────────────────────────────────────────
case "$COMMAND" in
    backup)
        create_backup
        ;;
    restore)
        restore_backup "$1"
        ;;
    list)
        list_backups
        ;;
    diff)
        diff_backup "$1"
        ;;
    clean)
        clean_backups "$1"
        ;;
    *)
        if [[ -z "$COMMAND" ]]; then
            log_error "No se especificó comando"
        else
            log_error "Comando desconocido: $COMMAND"
        fi
        usage
        exit 1
        ;;
esac