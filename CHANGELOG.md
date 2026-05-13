# Changelog - kuri-dots

> Yoda Sanostyle - Hyprland Rice para Debian

---

## [2026-05-13] v2.1 — OpenCode Agents & Waybar Visual Overhaul

### Added
- **Fase 1 — Skills OpenCode**: 8 nuevos skills en `~/.config/opencode/skills/`: waybar, hyprland, neovim, terminal, styling, utils, dev, zsh
- **Fase 2 — Config de proyecto**: `opencode.json` con permisos, instructions, y 4 agentes subagente
- **Agentes opencode**: `@rice-reviewer`, `@visual-designer`, `@sync-manager`, `@test-runner`
- **Botón OBS**: Nuevo módulo en waybar con icono  (video-camera)
- **Scroll de volumen**: `on-scroll-up/down` con wpctl en wireplumber

### Changed
- **Waybar icons**: Reemplazados todos los iconos rotos (custom NF range) por FontAwesome 4.x
- **WirePlumber**: Migrado de pulseaudio a wireplumber (volumen nativo PipeWire)
- **Waybar CSS**: Overhaul visual completo — border-radius, glow neón, gradientes, pills, color-coding
- **Waybar height**: 40px → 41px (+3%)
- **Font sizes**: Base 14px → 15.2px, app icons 17.3px → 19px
- **Pango markup**: Iconos de reloj y calendario con `<span size='larger'>`, texto con `<span size='smaller'>`
- **AGENTS.md**: Tabla unificada skills dotfiles ↔ skills OpenCode
- **Fcitx5 icon**: `󰟓` → `` (keyboard, FA4)
- **Power icon**: `⏻` (unicode) → `` (power-off)

### Fixed
- Iconos de Nerd Font custom range (U+30000+) que no existían en Iosevka NF
- Network icons (ethernet →, disconnected 睊→)
- Pulseaudio muted icon (→)

---

## [2026-05-11] v2.0 - Yoda Theme Complete

### Added
- **EWW widgets** - Dashboard completo con calendar, weather, music, network, etc.
- **Testing framework** - 367 tests (BATS + pytest) + GitHub Actions
- **Skills system** - Documentación para EWW, Alacritty, Bash, Python, etc.
- **Kitty terminal** - Tema Yoda con #00ff99
- **Nemo file manager** - Configuración GTK
- **Cava visualizer** - Tema Yoda con gradientes
- **AGENTS.md** - Índice de skills para agentes AI
- **TODO.md** - Lista de tareas pendientes

### Fixed
- **EWW calendar** - Lunes como primer día (L M M J V S D)
- **EWW CSS** - Eliminado @keyframes (GTK3 no soporta)
- **EWW launcher** - Icono de alacritty corregido
- **Sync script** - Repo path corregido a ~/Documentos/dotfiles
- **Zsh colors** - Predictivo y completado visibles sobre fondo negro
- **Hyprland screenshot** - SUPERSHIFT+4 ahora guarda y copia

### Changed
- **Color palette** - Consistente: #00ff99 (primary), #b9f6ca (text), #050705 (background)

---

## [2025] v1.x - Early Development

### 2025-12
- Primera versión del Hyprland rice
- EWW widgets básicos
- Tema Yoda lightsaber green

### 2025-11
- Configuración NVIDIA RTX 3060
- Scripts de backup y sync
- Integración con Alacritty, Waybar, Wofi

---

## ⚡ Comandos Útiles

```bash
# Ver diferencias entre local y repo
./scripts/sync-kuri-dots.sh status

# Backup completo
./scripts/backup-kuri-dots.sh backup

# Instalar configs
./install.sh
```

---

*Para contribuciones ver [CONTRIBUTING.md](./CONTRIBUTING.md)*
*Para versiones ver [VERSIONES.md](./VERSIONES.md)*