# VERSIONES — Análisis Comparativo de Fuentes
## Fecha: 2026-05-10

---

## 📦 Fuentes Analizadas

| # | Fuente | Ubicación | Último commit | Estado |
|---|--------|-----------|---------------|--------|
| 1 | **Config activa** | `~/.config/` | N/A (directa) | ✅ Activa en uso |
| 2 | **Repo local** | `~/Documentos/dotfiles/` | `9b120a3` | ✅ Trackeado |
| 3 | **kuri-dots (descarga)** | `~/descargas/kuri-dots/` | `c9098e0` (rama yoda) | 🟡 Desactualizado |
| 4 | **Backup pre-reorg** | `~/descargas/kuri-dots.backup-pre-reorganization/` | — | 🔴 Histórico |

---

## 🏆 Más Completa: `~/.config/` (FUENTE 1)

Es la configuración activa con **todas** las personalizaciones aplicadas. Contiene todo lo que hay en las otras 3 fuentes MÁS:

### Exclusivo de `~/.config/` (no existe en ninguna otra fuente):

| Componente | Archivo | Descripción |
|-----------|---------|-------------|
| NVIDIA | `hypr/scripts/brave.sh` | Wrapper `--disable-gpu-memory-buffer-video-frames` |
| NVIDIA | `hypr/scripts/discord.sh` | Wrapper `--use-gl=desktop` |
| NVIDIA | `hypr/scripts/gdevelop.sh` | Wrapper `--disable-gpu` |
| NVIDIA | `hypr/scripts/steam.sh` | Wrapper `-no-cef-sandbox` |
| NVIDIA | `hypr/scripts/edit_note.sh` | Editor notas vía terminal |
| NVIDIA | `hypr/scripts/wallpaper.sh` | Stub (0 bytes) |
| EWW | `eww/scripts/football.py` | Scraping promiedos.com.ar |
| EWW | `eww/scripts/football.sh` | Wrapper fútbol |
| EWW | `eww/scripts/gcal_auth.py` | Auth Google Calendar |
| EWW | `eww/scripts/date_lang.sh` | Formato idioma/fecha |
| EWW | `eww/scripts/save_note.sh` | Guardado notas |
| EWW | `eww/scripts/note_write.py` | Escritura notas |
| EWW | `eww/scripts/toggle-all-widgets.sh` | Toggle widgets |
| EWW | `eww/scripts/toggle_lang.sh` | Toggle idioma |
| EWW | `eww/scripts/token.pickle` | Auth token Google |
| EWW | `eww/scripts/credentials.json` | OAuth credentials |
| CSS | `cava/config` | Config CAVA con gradientes |
| CSS | `cava/shaders/*.frag` (5) | Shaders GLSL spectrum |
| GTK | `gtk-3.0/settings.ini` | Tema GTK dark |
| GTK | `gtk-3.0/bookmarks` | Bookmarks Nautilus |
| Wofi | `wofi/config` | Config launcher |
| Wofi | `wofi/style.css` | Estilo launcher |
| Wofi | `wofi/colors` | Colores launcher |
| Wofi | `wofi/wofi-launch.sh` | Script lanzador |
| Fastfetch | `fastfetch/config.jsonc` | Config display |
| Btop | `btop/themes/yoda.theme` | Tema Yoda lightsaber |
| Htop | `htop/htoprc` | Config personalizada |
| Wlogout | `wlogout/layout` | Layout logout |
| Wlogout | `wlogout/wlogout.sh` | Script logout |
| Wlogout | `wlogout/style.css` | Estilo logout |
| Sistema | `pavucontrol.ini` | Config audio |
| Sistema | `mimeapps.list` | Asociaciones apps |
| Sistema | `hypr_backup/` | Respaldo hyprland.conf |

### Más contenido (misma base, versión local más actualizada):

| Archivo | `.config` | `kuri-dots` | Diferencia |
|---------|-----------|-------------|------------|
| `eww/eww.yuck` | 26,422 B | 24,027 B | +2,395 B: SETTINGS widget, notas reactivas, footer Yoda |
| `eww/eww.css` | 20,986 B | 13,653 B | +7,333 B: CSS settings, notes, football, launchers |
| `hypr/hyprland.conf` | 4,639 B | 3,892 B | +747 B: NVIDIA fix, exec-once limpio |
| `waybar/config.jsonc` | 2,986 B | 2,287 B | +699 B: launchers, height, spacing |
| `waybar/style.css` | 3,413 B | 2,076 B | +1,337 B: custom launchers CSS |
| `.zshrc` | 597 B | 580 B | +17 B: aliases + PATH opencode |
| `btop/btop.conf` | 9,341 B | no existe | Tema Yoda configurado |
| `cava/config` | 9,465 B | no existe | Gradient config |

---

## 📊 Lo que tienen las OTRAS fuentes y NO tiene `.config`:

### `kuri-dots/` (descargas) — extras:
- `docs/DEBIAN_SETUP.md` — Guía instalación Debian
- `docs/HYPRLAND_GUIDE.md` — Guía Hyprland
- `docs/` — Carpeta documentación extra
- `dev/` — Configs lazygit, lazydocker
- `tools/htop_config` + `tools/README.md`
- `pkg/` — Listas de paquetes debian/arch
- `INSTALLATION.md`, `ATTRIBUTION.md`, `CONFIGURATION.md`
- `backup/2026-05-10-eww-fixes/` — Snapshot reciente
- `.env.example`

### `Documentos/dotfiles/` (repo local) — extras sobre `.config`:
- `assets/` — 4 wallpapers PNG + screenshots
- `flameshot/` — Config screenshots
- `nemo/` — Config explorador archivos
- `kitty/` — Config terminal kitty
- `scripts/` — `install-*`, `sync-*`, `backup-*` (gestión)
- `backup_unified/` — Snapshots históricos v1
- `.agents/workflows/` — Agent workflows
- `.gitignore` más completo (6,430 B vs 1,562 B backup)

### `backup-pre-reorganization/` — exclusivos:
- `backup_unified/BACKUP_VERSIONS.md`
- `backup_unified/eww.css.v1_current`
- `backup_unified/eww.yuck.v1_current`
- `aurlist.txt`
- `nvim/.neoconf.json`

---

## 🔄 Relación entre fuentes

```
kuri-dots (github base)
    │
    ├─── fork ──→ Documentos/dotfiles (repo local)
    │                  │
    │                  ├─── sync ──→ ~/.config/ (máquina activa)
    │                  │
    │                  └─── personalización local (scripts NVIDIA, notas, etc.)
    │
    └─── backup ──→ kuri-dots.backup-pre-reorganization (histórico, obsoleto)
```

---

## 🔑 Conclusión

**Fuente canónica recomendada:** `~/Documentos/dotfiles/` (ya tiene `.git`, `.gitignore` prolijo, y acaban de commitearse las personalizaciones de `.config`).

**Siguiente paso:** Unificar `kuri-dots/` y `backup-pre-reorganization/` como referencia histórica, eliminarlos, y hacer push de `Documentos/dotfiles/` a GitHub.
