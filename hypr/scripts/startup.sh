#!/usr/bin/bash
# ~/.config/hypr/scripts/startup.sh
# Script de inicio para Hyprland — ejecutado desde hyprland.conf

set -euo pipefail

LOG="$HOME/.cache/hypr-startup.log"
mkdir -p ~/.cache

log() { echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG"; }

# ── Wait for PipeWire/PulseAudio ──
log "⏳ Esperando PipeWire/PulseAudio..."
for i in {1..30}; do
    if [ -S "$XDG_RUNTIME_DIR/pulse/native" ] || pgrep -x pipewire > /dev/null 2>&1; then
        log "✅ Audio listo"
        break
    fi
    sleep 0.3
done

# ── Wait for display server ──
log "⏳ Esperando servidor de display..."
sleep 1

# ── Wallpaper ──
log "🖼️ Estableciendo wallpaper..."
~/.config/hypr/scripts/wallpaper_v2.sh >> "$LOG" 2>&1

# ── Network Manager ──
if command -v nm-applet > /dev/null 2>&1; then
    log "📡 Iniciando nm-applet..."
    nm-applet --indicator &
fi

# ── Notifications ──
if command -v mako > /dev/null 2>&1; then
    log "🔔 Iniciando mako..."
    mako &
fi

# ── Waybar ──
log "📊 Iniciando waybar..."
pkill waybar 2>/dev/null || true
sleep 1
waybar >> "$LOG" 2>&1 &

# ── EWW ──
log "🧩 Iniciando EWW..."
pkill -f eww 2>/dev/null || true
sleep 1
eww daemon >> "$LOG" 2>&1 &
sleep 2
eww open-many dashboard_window date_window football_window notes_window >> "$LOG" 2>&1
if [ $? -eq 0 ]; then
    log "✅ EWW widgets activos"
else
    log "⚠️ EWW tuvo errores (ver eww logs)"
fi

# ── Fcitx5 (input method) ──
if ! pgrep -x fcitx5 > /dev/null 2>&1; then
    log "⌨️ Iniciando fcitx5..."
    fcitx5 -d >> "$LOG" 2>&1
fi

# ── Fcitx5 watcher ──
~/.config/waybar/scripts/fcitx5-watcher.sh >> "$LOG" 2>&1 &

# ── Idle & Lock ──
log "🔒 Configurando swayidle..."
pkill swayidle 2>/dev/null || true
swayidle \
    timeout 900 'hyprlock -f' \
    before-sleep 'hyprlock -f' \
    >> "$LOG" 2>&1 &

# ── Cleanup de archivos rotos ──
log "🧹 Limpiando archivos temporales..."
rm -f ~/.config/eww/eww.css.broken 2>/dev/null
# Eliminar archivos .bak rotos si existen
find ~/.config -name "*.bak" -empty -delete 2>/dev/null
find ~/.config -name "*.broken" -empty -delete 2>/dev/null

log "🚀 Startup completado exitosamente"
