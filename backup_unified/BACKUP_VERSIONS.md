# Kuri-Dots Unified Backup
## Sistema de versionado de configuraciones

### Estructura de directorios
```
kuri-dots/
├── eww/           # Widgets (EWW)
├── hypr/          # Gestor de ventanas
├── waybar/        # Barra de estado
├── btop/          # Monitor de sistema
├── nemo/          # Explorador de archivos
├── alacritty/     # Terminal
├── wlogout/       # Menú de logout
├── mako/          # Notificaciones
├── wofi/          # Launcher
├── scripts/       # Scripts varios
├── skills/        # Documentación para agentes
├── assets/        # Imágenes, iconos, temas
└── backup_unified/
    └── (backups de cada app)
```

---

## Historial de Versiones por Aplicación

### EWW (Widgets)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-05 | v1_base | Base original del repo | Obsoleto |
| 2026-05-07 | v1.1 | Primeras modificaciones locales | Obsoleto |
| 2026-05-09 | v2 | Integración football widget | Obsoleto |
| 2026-05-10 | v3 | Sticky notes, football separado, Calendar/Date window | **ACTIVO** |

**Scripts:** notes.sh, football.py, gcal.py, calendar.sh, weather.sh, system.sh, audio.sh, music.sh, battery.sh, brightness.sh, cal_nav.sh, cal_lang.sh, toggle_lang.sh, gcal_wrapper.sh

---

### HYPR (Gestor de Ventanas)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-05 | v1_base | Configuración base | Obsoleto |
| 2026-05-09 | v2 | Modificaciones locales | **ACTIVO** |

**Atajos activos:**
- SUPER+R → Alacritty
- SUPER+E → Brave (actualizado)
- SUPER+F → Thunar
- SUPER+B → Blender
- SUPER+D → Wofi
- SUPER+C → Discord (nuevo)
- SUPER+S → Steam (nuevo)

---

### WAYBAR (Barra de Estado)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-05 | v1_base | Configuración base | **ACTIVO** |

**Módulos:**
- Left: clock, custom/gcal_next
- Center: hyprland/workspaces
- Right: custom/settings, pulseaudio, network, battery, custom/language_toggle, custom/language, custom/power

**Scripts:** fcitx5-status.sh, fcitx5-watcher.sh

---

### BTOP (Monitor de Sistema)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-09 | v1 | Configuración personalizada | **ACTIVO** |

**Config:** Theme Default, Truecolor, Graph symbols: braille, vim_keys: false

---

### NEMO (Explorador)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-05 | v1_base | Configuración base | Legacy |

**Nota:** Thunar está activo como launcher principal. Nemo instalado pero no usado actualmente.

---

### ALACRITTY (Terminal)

| Fecha | Versión | Descripción | Estado |
|-------|---------|-------------|--------|
| 2026-05-09 | v1 | Yoda Theme (Lightsaber Green) | **ACTIVO** |

**Config:**
- Shell: zsh
- Opacity: 0.4
- Blur: true
- Font: JetBrains Mono 13.5px
- Cursor: Beam, blinking

---

## Navegador por Defecto

| Fecha | Cambio | Estado |
|-------|--------|--------|
| 2026-05-10 | google-chrome-stable → brave | **ACTIVO** |

---

## Comandos de Sincronización

```bash
# Sincronizar local -> repo
cp ~/.config/eww/eww.yuck ~/descargas/kuri-dots/eww/
cp ~/.config/eww/eww.css ~/descargas/kuri-dots/eww/
cp ~/.config/hypr/hyprland.conf ~/descargas/kuri-dots/hypr/
cp ~/.config/waybar/config.jsonc ~/descargas/kuri-dots/waybar/
cp ~/.config/waybar/style.css ~/descargas/kuri-dots/waybar/
cp ~/.config/btop/btop.conf ~/descargas/kuri-dots/btop/
cp ~/.config/alacritty/alacritty.toml ~/descargas/kuri-dots/alacritty/
cp ~/.config/skills/*.md ~/descargas/kuri-dots/skills/

#浏览器默认
xdg-mime default brave-browser.desktop x-scheme-handler/http x-scheme-handler/https
xdg-settings set default-web-browser brave-browser.desktop
```

---

## Skills Creados

1. **bash_rice_expert.md** - Scripts Bash, Hyprland, Wayland
2. **lisp_eww_expert.md** - EWW Yuck syntax
3. **python_expert.md** - Python backend (gcal, football)
4. **eww_yuck_expert.md** - EWW completo (widgets, windows, CSS)
5. **eww_backend_expert.md** - Scripts backend EWW
6. **waybar_expert.md** - Waybar configuración
7. **btop_expert.md** - Btop monitor
8. **nemo_expert.md** - Nemo explorador
9. **alacritty_expert.md** - Alacritty terminal

---

*Última actualización: 2026-05-10*