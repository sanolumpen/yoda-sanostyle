---
name: waybar_expert
description: Waybar status bar: módulos, JSON config, custom scripts
trigger: Configurar o modificar Waybar, módulos, estilos CSS
---

# Experto Waybar — Barra de Estado para Wayland

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Administrador de barra de estado Waybar para Hyprland.
- **Objetivo:** Mantener una barra funcional, estilizada y modular.

## Configuración Actual

### Estructura de Archivos
```
~/.config/waybar/
├── config.jsonc    # Configuración principal
├── style.css       # Estilos
├── scripts/       # Scripts auxiliares
└── asd/           # Módulos adicionales
```

### Módulos Activos
- **Left:** clock, custom/gcal_next
- **Center:** hyprland/workspaces
- **Right:** custom/settings, pulseaudio, network, battery, custom/language_toggle, custom/language, custom/power

### Módulos Configurados
- Clock (fecha/hora con tooltip calendario)
- Battery (estados: good 80%, warning 30%, critical 15%)
- Network (wifi/ethernet, editor de conexiones)
- PulseAudio (backend pipewire, control de volumen)
- Custom scripts: fcitx5-status, toggle_lang, gcal_wrapper

## Reglas de Oro para Waybar

### Config JSONC
- Usar comentarios con `//` o `/* */`
- Las opciones van en `config.jsonc` (soporta comentarios)
- Los módulos se definen en arrays: `modules-left`, `modules-center`, `modules-right`

### Módulos Principales
1. **clock** - Fecha/hora con formato Pango
2. **battery** - Estado de batería con iconos
3. **network** - Conexiones wifi/ethernet
4. **pulseaudio** - Audio (backend pipewire/wireplumber)
5. **hyprland/workspaces** - Workspaces de Hyprland
6. **tray** - Bandeja del sistema

### Módulos Custom
- `exec` - Ejecutar comando y mostrar salida
- `interval` - Frecuencia de actualización
- `signal` - Señal para actualizar (ej: 9 para SIGHUP)
- `on-click` - Acción al hacer click
- `on-scroll-up/down` - Acciones con scroll

### Eventos de Módulo
- `on-click`, `on-double-click`, `on-triple-click`
- `on-click-right`, `on-click-middle`
- `on-scroll-up`, `on-scroll-down`

### Estilos CSS
- Selectores: `window#waybar`, `#mods`, `.module`
- Estados: `*.urgent`, `*.warning`, `*.critical`
- Transiciones CSS funcionan

## Solución de Problemas

1. **Bar no aparece:** Verificar que Hyprland esté ejecutándose, revisar `layer: "top"` vs `"bottom"`
2. **Módulo no actualiza:** Verificar `interval` y permisos del script
3. **Estilos no aplican:** Verificar que `style.css` está en la ubicación correcta
4. **Errores en logs:** Waybar verbose en terminal para debug

## Referencias
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Waybar Configuration](https://github.com/Alexays/Waybar/wiki/Configuration)
- [Waybar Modules](https://github.com/Alexays/Waybar/wiki/Modules)
- [Alexays/Waybar](https://github.com/Alexays/Waybar)