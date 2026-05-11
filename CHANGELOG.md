# Changelog - kuri-dots

> Yoda Sanostyle - Hyprland Rice para Debian

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