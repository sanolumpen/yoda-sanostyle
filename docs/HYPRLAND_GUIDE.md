# HYPRLAND_GUIDE - Guía rápida

Qué es Hyprland
- Gestor de ventanas Wayland, dinámico y configurable.

Ubicación de configuración
- `~/.config/hyprland/` — archivo principal `hyprland.conf` y subcarpetas relacionadas.
- En este repo: `core/hyprland/` (copiar a `~/.config/hyprland/`)

Secciones habituales en la configuración
- Keybindings: atajos de teclado (modificadores + tecla → acción)
- Monitors/outputs: definición de resoluciones/posición
- Window rules: reglas por aplicación (float, tile, workspace)
- Animations & effects: valores de animación y gaps
- Autostart: comandos para arrancar servicios (eww, waybar, compositor helpers)

Recargar configuración
- `hyprctl reload` (recarga la configuración, sintaxis/soporte depende de la versión)
- Reiniciar sesión para cambios de drivers o cambios globales

Autostart (ejemplo conceptual)
- Usar líneas de `exec` o `exec-once` en la configuración para iniciar demonios:

```
# conceptual
exec-once = eww daemon
exec-once = waybar
exec = alacritty
```

Keybindings (ejemplo conceptual)
- Formato general: `bind = <MODS>, <KEY>, <action>`
- Ejemplos:
  - Abrir terminal
  - Cambiar workspace
  - Captura de pantalla

Herramientas útiles
- `hyprctl` — utilidad para consultar estado y enviar comandos a Hyprland
- `swayidle`, `wlogout`, `grim` — herramientas complementarias

Lecturas recomendadas
- Documentación oficial Hyprland: https://github.com/hyprwm/Hyprland

Última actualización: 2026-05-10
