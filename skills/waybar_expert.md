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
├── style.css       # Estilos visuales (Yoda neon theme)
└── scripts/        # Scripts auxiliares
```

### Módulos Activos
- **Left:** clock, custom/gcal_next, custom/brave (), custom/discord (), custom/steam (), custom/gdevelop (), custom/launchers ()
- **Center:** hyprland/workspaces
- **Right:** custom/settings (), wireplumber, network, battery, custom/language_toggle (), custom/language (), custom/power ()

### Módulos Configurados
- Clock (fecha/hora con tooltip calendario, icono )
- Battery (estados: good/warning/critical, iconos -, charging )
- Network (wifi , ethernet , disconnected , editor de conexiones)
- WirePlumber (volumen nativo WP, formato `{icon} {volume}%`, scroll con wpctl)
- Language: fcitx5-status (icono ), toggle_lang (icono )
- App launchers: brave, discord, steam, gdevelop, wofi search ()
- Power (), Settings (), gcal_next ()

## Reglas de Oro para Waybar

### Config JSONC
- Usar comentarios con `//` o `/* */`
- Las opciones van en `config.jsonc` (soporta comentarios)
- Los módulos se definen en arrays: `modules-left`, `modules-center`, `modules-right`

### Módulos Principales
1. **clock** - Fecha/hora con formato Pango
2. **battery** - Estado de batería con iconos
3. **network** - Conexiones wifi/ethernet
4. **wireplumber** - Audio nativo (lee sinks reales de PipeWire, reemplaza pulseaudio)
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

### Estilos CSS (Yoda Neon Theme)
- Selectores: `window#waybar`, `#mods`, `.module`
- Estados: `*.urgent`, `*.warning`, `*.critical`
- Transiciones CSS funcionan
- **Barra:** border-radius 16px, gradient background, neon green border sutil
- **Workspaces:** pills redondeadas, active con fondo verde sólido + glow
- **Módulos:** backgrounds semitransparentes con border-radius 8px
- **Color-coding por función:** verde neón (sistema), azul (settings), rojo (power)
- **Hover:** glow + text-shadow + box-shadow en todos los módulos interactivos
- **Tooltips:** glassmorphism con border-radius 10px

### Paleta Visual
| Elemento | Color | Uso |
|----------|-------|-----|
| Fondo barra | `#050705` con gradiente | Fondo principal |
| Verde neón | `#00ff99` | Active, hover, glow |
| Texto | `#b9f6ca` | Texto secundario |
| Azul UNAHUR | `#4fc3f7` | Settings/accesos |
| Rojo power | `#ff4444` | Power/botón peligro |
| Amarillo | `#ffee58` | Battery warning |
| Rojo crítico | `#ff4d4d` | Battery critical + blink |

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