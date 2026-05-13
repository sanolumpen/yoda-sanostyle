# Sano Dots — Agent Skills Index

> **Versión:** 2.1 (2026-05-13)
> **Proyecto:** Yoda Sanostyle - Hyprland Rice para Debian

---

## Cómo Usar Estos Skills

1. **Antes de escribir código:** Lee el skill relevante
2. **Durante el trabajo:** Sigue los patrones documentados
3. **Al Commits:** Usa las reglas de citación especificadas

---

## Skills Disponibles

| Skill (dotfiles) | Skill (OpenCode) | Categoría | Trigger |
|---|---|---|---|
| [bash_rice_expert](./skills/bash_rice_expert.md) | `sano-dots-bash` | Shell/Scripts | Scripts de Bash, wrappers, entorno Wayland |
| [eww_yuck_expert](./skills/eww_yuck_expert.md) | `sano-dots-eww` | Widgets/EWW | Crear/modificar widgets EWW |
| [lisp_eww_expert](./skills/lisp_eww_expert.md) | → `sano-dots-eww` | Sintaxis/Yuck | Sintaxis Yuck, expresiones |
| [eww_backend_expert](./skills/eww_backend_expert.md) | → `sano-dots-eww` | Backend/Python | Scripts Python para widgets |
| [python_expert](./skills/python_expert.md) | → `sano-dots-eww` | Python | Scripts Python generales |
| [waybar_expert](./skills/waybar_expert.md) | `sano-dots-waybar` | Bar/Status | Configuración de Waybar |
| [alacritty_expert](./skills/alacritty_expert.md) | `sano-dots-terminal` | Terminal | Alacritty, Kitty, Tmux |
| [css_rice_expert](./skills/css_rice_expert.md) | `sano-dots-styling` | Styling | Temas GTK3, paleta Yoda, CSS |
| [testing_expert](./skills/testing_expert.md) | `sano-dots-testing` | Testing | Tests BATS, pytest, agentización |
| | `sano-dots-hyprland` | WM | Hyprland, hyprlock, NVIDIA |
| | `sano-dots-neovim` | Editor | Neovim LazyVim |
| | `sano-dots-utils` | Utilidades | wofi, wlogout, mako, btop, cava, etc |
| | `sano-dots-dev` | Dev Tools | lazygit, lazydocker |
| | `sano-dots-zsh` | Shell | .zshrc, oh-my-zsh |

---

## Estructura de un Skill

Cada skill sigue este formato:

```yaml
---
name: skill-name
description: Descripción breve del skill
trigger: Cuándo usar este skill
---
# Contenido...
```

---

## Reglas de Citación

> **IMPORTANTE:** Cuando uses código de estos skills, cita la fuente en comentarios.

```bash
# Script: mi-script.sh
# Descripción: ...
# Fuentes: [bash_rice_expert](./skills/bash_rice_expert.md)
```

---

## Actualización de Mayo 2026

### v2.0 (2026-05-11)
- ✅ Agregado skill de **testing_expert** con BATS + pytest
- ✅ Agregada agentización de pruebas con LLM-as-judge
- ✅ Agregados skills de EWW, Alacritty, Bash, Python, CSS, Waybar

### v2.1 (2026-05-13)
- ✅ Creados 8 nuevos skills OpenCode: waybar, hyprland, neovim, terminal, styling, utils, dev, zsh
- ✅ AGENTS.md ahora mapea skills dotfiles ↔ skills OpenCode
- ✅ Migración global **kuri → sano** (skills, scripts, configs, docs)
- ✅ Config de proyecto: `opencode.json` con permisos y 4 agentes subagente
- ✅ Agentes: `@rice-reviewer`, `@visual-designer`, `@sync-manager`, `@test-runner`
- ✅ Sitio interactivo: `~/Documentos/sano-agents/` (Next.js 16 + Framer Motion)
- ✅ Investigación de mejores prácticas y papers académicos sobre agentes

---

## Testing Integration

Ver [TESTING_PLAN.md](./TESTING_PLAN.md) para el plan completo de testing.

```bash
# Quick setup (install all dependencies)
./scripts/setup-testing.sh

# Install BATS only
./scripts/install-bats.sh

# Run tests
./scripts/test-runner.sh all

# CI mode
./scripts/test-runner.sh ci

# GitHub Actions (automatic on push/PR)
# .github/workflows/test-all.yml
```

### Scripts de Testing
- `scripts/test-runner.sh` - Test runner agentic v2.0
- `scripts/install-bats.sh` - Instala BATS y dependencias
- `scripts/setup-testing.sh` - Setup completo de testing

---

*Documento generado: 2026-05-11*