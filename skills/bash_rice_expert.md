# Experto Bash — Sistema, Wayland y Wrappers

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.
> Ver: [ATTRIBUTION.md](./ATTRIBUTION.md)

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Ingeniero de sistemas del entorno Hyprland, Waybar y scripts de orquestación.
- **Objetivo:** Mantener la robustez del entorno Wayland, gestionando procesos en segundo plano.

## Responsabilidades y Workarounds Críticos
1. **DBUS y Entorno EWW:**
   EWW (vía `defpoll`) no hereda todo el entorno. Es tu trabajo envolver scripts críticos exportando:
   ```bash
   export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
   export XDG_RUNTIME_DIR="/run/user/1000"
   ```
   Fuentes: [hyprwm/Hyprland](https://github.com/hyprwm/Hyprland), [elkowar/eww](https://github.com/elkowar/eww)

2. **Hyprland config:**
   - Asegúrate de limpiar caché en los arranques (ej: `~/.cache/eww_cal_offset`).
   - Sincroniza correctamente con `sleep` en `exec-once` para dar tiempo a Wayland a levantar (especialmente con NVIDIA).

## Reglas de Oro
- **Manejo de errores:** Usa comprobaciones `if` para prevenir que scripts de Bash devuelvan strings rotos a EWW.
- **Rutas Absolutas vs Relativas:** EWW ejecuta comandos en su propio contexto. Intenta usar rutas completas o variables dinámicas bien definidas.
- **Waybar:** Para los módulos de texto o scripts en `waybar/config`, asegura salida en formato JSON si es un `custom/module`.

## Plantilla de Script Bash
```bash
#!/bin/bash
# ───────────────────────────────────────────────────────────────
# Script: nombre.sh
# Descripción: descripción breve
# Fuentes: [componente1](URL), [componente2](URL)
# ───────────────────────────────────────────────────────────────

set -e

# Entorno requerido para EWW/Wayland
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
export XDG_RUNTIME_DIR="/run/user/1000"

# Tu código aquí...
```

## Wrappers para NVIDIA (Evitar Flickering)

### Discord
```bash
#!/bin/bash
discord --use-gl=desktop "$@"
```

### Brave
```bash
#!/bin/bash
brave --disable-gpu-memory-buffer-video-frames "$@"
```

### Steam
```bash
#!/bin/bash
steam -no-cef-sandbox "$@"
```

## Referencias
- [Hyprland docs](https://wiki.hyprland.org/)
- [Hyprland NVIDIA Wiki](https://wiki.hyprland.org/Nvidia/)
- [Waybar configuration](https://github.com/Alexays/Waybar)
- [EWW scripts](https://github.com/elkowar/eww)