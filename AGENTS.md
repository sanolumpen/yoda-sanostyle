# Kuri-Dots — Agent Skills Index

> **Versión:** 2.0 (2026-05-11)
> **Proyecto:** Yoda Sanostyle - Hyprland Rice para Debian

---

## Cómo Usar Estos Skills

1. **Antes de escribir código:** Lee el skill relevante
2. **Durante el trabajo:** Sigue los patrones documentados
3. **Al Commits:** Usa las reglas de citación especificadas

---

## Skills Disponibles

| Skill | Categoría | Trigger |
|-------|-----------|---------|
| [bash_rice_expert](./skills/bash_rice_expert.md) | Shell/Scripts | Scripts de Bash, wrappers, entorno Wayland |
| [eww_yuck_expert](./skills/eww_yuck_expert.md) | Widgets/EWW | Crear/modificar widgets EWW |
| [lisp_eww_expert](./skills/lisp_eww_expert.md) | Sintaxis/Yuck | Sintaxis Yuck, expresiones |
| [eww_backend_expert](./skills/eww_backend_expert.md) | Backend/Python | Scripts Python para widgets |
| [python_expert](./skills/python_expert.md) | Python | Scripts Python generales |
| [waybar_expert](./skills/waybar_expert.md) | Bar/Status | Configuración de Waybar |
| [alacritty_expert](./skills/alacritty_expert.md) | Terminal | Configuración de Alacritty |
| [btop_expert](./skills/btop_expert.md) | Monitor | Configuración de btop |
| [nemo_expert](./skills/nemo_expert.md) | File Manager | Configuración de Nemo |
| [css_rice_expert](./skills/css_rice_expert.md) | Styling | Temas GTK3, CSS para EWW |
| [testing_expert](./skills/testing_expert.md) | Testing | Tests BATS, pytest, agentización |

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

- ✅ Agregado skill de **testing_expert** con BATS + pytest
- ✅ Agregada agentización de pruebas con LLM-as-judge
- ✅ Actualizadas referencias a versiones 2026

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