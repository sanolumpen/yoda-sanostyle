# sano-dots

![desktop preview](assets/yoda-desktop.png)

## 🧠 Integración con OpenCode

Este proyecto está completamente agentizado con [OpenCode](https://opencode.ai). El agente AI entiende la estructura del rice a través de:

| Mecanismo | Archivo | Propósito |
|---|---|---|
| **AGENTS.md** | `./AGENTS.md` | Índice de skills, reglas de citación, testing |
| **Skills** | `~/.config/opencode/skills/sano-dots-*/SKILL.md` | 11 skills que definen cómo interactuar con cada componente |
| **Config** | `./opencode.json` | Permisos, agentes subagente, instrucciones |
| **Agentes** | `.opencode/agents/*.md` | 4 subagentes: rice-reviewer, visual-designer, sync-manager, test-runner |

### Tour interactivo
```bash
cd ~/Documentos/sano-agents && npm run dev
```
Abre un sitio web interactivo (Next.js 16) que visualiza el ciclo agéntico, los skills, los agentes, y compara contra mejores prácticas de la comunidad.

---

## ⚡ Stack Tecnológico

| Categoría | Herramienta | Fuente |
|-----------|-------------|--------|
| **WM** | [Hyprland](https://github.com/hyprwm/Hyprland) | BSD-3 |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar) | MIT |
| **Widgets** | [EWW](https://github.com/elkowar/eww) | GPL-3.0 |
| **Terminal** | [Alacritty](https://github.com/alacritty/alacritty) | Apache-2.0 |
| **Editor** | [Neovim](https://github.com/neovim/neovim) + [LazyVim](https://github.com/LazyVim/LazyVim) | Apache-2.0 / MIT |
| **Launcher** | [Wofi](https://sr.ht/~scoopta/wofi/) | GPL-3.0 |
| **Input** | [Fcitx5](https://github.com/fcitx/fcitx5) + [Mozc](https://github.com/fcitx-contrib/fcitx5-mozc) | GPL-2.0 / Apache-2.0 |

---

## 🙏 Créditos y Reconocimientos

> **Inspirado por:** [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland), [NvChad](https://github.com/NvChad/NvChad), [LazyVim](https://github.com/LazyVim/LazyVim)

Ver [ATTRIBUTION.md](./ATTRIBUTION.md) para la lista completa de dependencias y licencias.

---

## 📦 Paquetes

- [pkglist.txt](pkglist.txt) — Paquetes oficiales de Arch Linux
- [aurlist.txt](aurlist.txt) — Paquetes AUR

Para actualizar después de instalar/remover paquetes:
```bash
bash ~/.config/scripts/update-package-lists.sh
```

---

## 🛠️ Scripts de Gestión

| Script | Descripción | Fuente |
|--------|-------------|--------|
| `backup-sano-dots.sh` | Backup versionado del proyecto | [kuri-sun/sano-dots](https://github.com/kuri-sun/dotfiles) |
| `sync-sano-dots.sh` | Sincronizar ~/.config/ ↔ repo | [kuri-sun/sano-dots](https://github.com/kuri-sun/dotfiles) |
| `install-master.sh` | Instalación completa (con auto-backup) | [kuri-sun/sano-dots](https://github.com/kuri-sun/dotfiles) |

### Comandos de Backup
```bash
cd ~/Documentos/dotfiles
./scripts/backup-sano-dots.sh backup    # Crear backup
./scripts/backup-sano-dots.sh list       # Ver backups
./scripts/backup-sano-dots.sh restore    # Restaurar latest
```

### Comandos de Sync
```bash
./scripts/sync-sano-dots.sh status       # Ver diferencias
./scripts/sync-sano-dots.sh pull-local   # Traer del repo
./scripts/sync-sano-dots.sh push-repo    # Subir al repo
./scripts/sync-sano-dots.sh diff eww     # Comparar directorio
```

---

## 🔧 Instalación

```bash
# Instalación completa (recomendado - incluye auto-backup)
bash ~/.config/scripts/install-master.sh

# O manual:
# 1. Copiar configs a ~/.config/
# 2. Instalar paquetes desde pkglist.txt y aurlist.txt
# 3. Ejecutar post-install.sh
```

---

## ⚙️ Detalles de Paquetes

<details>
<summary><b>📦 Click para expandir</b></summary>

**Core Hyprland & Wayland:**
> [Hyprland](https://github.com/hyprwm/Hyprland), [hyprpaper](https://github.com/hyprwm/hyprland), [hyprlock](https://github.com/hyprwm/hyprland), [swayidle](https://github.com/swaywm/swayidle), [wlogout](https://github.com/ArtsyMacaw/wlogout), [waybar](https://github.com/Alexays/Waybar), [eww](https://github.com/elkowar/eww), [wofi](https://sr.ht/~scoopta/wofi/), [mako](https://github.com/emersion/mako)

**Screen Capture & Recording:**
> [grim](https://github.com/emersion/grim), [slurp](https://github.com/emersion/slurp), [obs-studio](https://obsproject.com/)

**Terminal & Development:**
> [Alacritty](https://github.com/alacritty/alacritty), [Neovim](https://github.com/neovim/neovim), [LazyVim](https://github.com/LazyVim/LazyVim), [tmux](https://github.com/tmux/tmux), [zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), [lazygit](https://github.com/jesseduffield/lazygit)

**Input Method (日本語):**
> [Fcitx5](https://github.com/fcitx/fcitx5), [fcitx5-mozc](https://github.com/fcitx-contrib/fcitx5-mozc)

**Fonts:**
> [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono), [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

</details>

---

## 📜 Licencia

Freedom at will.

*Este proyecto respeta las licencias de todas sus dependencias listadas en [ATTRIBUTION.md](./ATTRIBUTION.md).*