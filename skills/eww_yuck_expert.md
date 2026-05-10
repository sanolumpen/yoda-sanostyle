# Experto EWW (Elkowar's Wacky Widgets) — Widgets Completos

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.
> Ver: [ATTRIBUTION.md](./ATTRIBUTION.md)

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Desarrollador de widgets EWW para Hyprland.
- **Objetivo:** Crear widgets funcionales, estilizados y mantenibles.

## Widgets Implementados

### 1. Dashboard Window
- **Componentes:** Weather, Media Player, System Stats (CPU, RAM, Storage, Temp), Controls (Volume)
- **Posición:** Top-left, ancho 500px
- **Tipo:** dock (background)

### 2. Football Widget (Promiedos)
- **Backend:** Python scrapeando promiedos.com.ar
- **Datos:** Liga Profesional Argentina, Primera Nacional
- **Actualización:** 1 minuto
- **Características:** Logos de equipos/ligas, scores, horarios
- **Posición:** Bottom-left, y=440px

### 3. Notes Widget (Sticky Notes)
- **Backend:** Bash script con JSON storage
- **Comandos:**
  - `notes.sh list` - Obtener todas las notas
  - `notes.sh create <title> <content> [color]` - Crear nota
  - `notes.sh delete <id>` - Eliminar nota
  - `notes.sh toggle-pin <id>` - Fijar/nota
  - `notes.sh update <id> <field> <value>` - Actualizar campo
- **Storage:** `~/.local/share/eww/notes/notes.json`
- **Posición:** Top-right del dashboard (x=540px)

### 4. Calendar/Date Window
- **Componentes:** Fecha, Calendario mensual, Google Calendar (Personal, UNAHUR, Independiente)
- **Posición:** Bottom-right

## Reglas de Oro para EWW

### CSS (GTK3)
- Usar selectores simples: `.widget`, `.box`, `button`, `label`, `scrollbar`
- Evitar `all: unset` excepto en reset global
- Para progress bars: usar `trough` y `trough progress`
- Siempre definir `min-width/min-height` en imágenes

### Yuck Syntax
1. **Paréntesis:** Cada widget debe cerrar con paréntesis correspondiente
2. **Revealer:** SOLO UN HIJO permitido. Usar `(box ...)` contenedor si se necesitan múltiples elementos
3. **Variables:** Usar `defvar` para estado interactivo, `defpoll` para datos dinámicos
4. **Strings:** Comillas simples dentro de onclick requieren manejo especial. Preferir archivos temporales o comandos simples.

### Windows
- `dock` - Ventana de fondo, no captura clicks
- `normal` - Ventana interactiva, captura clicks
- `stacking: "bg"` - Debajo de otras ventanas
- `stacking: "fg"` - Encima de otras ventanas

### Commands
- Scripts deben ser ejecutables (`chmod +x`)
- Incluir manejo de errores: `2>/dev/null` para silenciar errores
- DBus environment para scripts de EWW:
  ```bash
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
  export XDG_RUNTIME_DIR="/run/user/1000"
  ```

## Plantilla de Widget
```lisp
(defwidget nombre-widget []
  (box :class "widget nombre-card" :orientation "v" :space-evenly false :spacing 8
    (box :orientation "h" :space-evenly false
      (label :class "titulo" :text "Título"))
    (scroll :vscroll true :hscroll false :height 150
      (box :orientation "v" :space-evenly false
        ;; contenido
      ))
  ))
```

## Integración con Scripts

### Python (Football)
```python
#!/usr/bin/env python3
import os
os.environ.setdefault('DBUS_SESSION_BUS_ADDRESS', 'unix:path=/run/user/1000/bus')
# Tu código...
print(json.dumps(data))
```

### Bash
```bash
#!/bin/bash
set -e
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
export XDG_RUNTIME_DIR="/run/user/1000"
# Tu código...
```

## Solución de Problemas Comunes

1. **Error "Input ended unexpectedly"**: Paréntesis desbalanceado. Usar `eww logs` para debug.
2. **CSS no aplica**: Verificar que las clases coincidan exactamente en yuck y css.
3. **Widget no visible**: Verificar `visible` property y stacking.
4. **Scripts no responden**: Verificar permisos y DBUS environment.

## Expresiones en EWW (Expression Language)

EWW incluye un lenguaje de expresiones que puede usarse para:
- Operaciones matemáticas: `+`, `-`, `*`, `/`, `%`
- Comparaciones: `==`, `!=`, `>`, `<`, `<=`, `>=`
- Booleanos: `||`, `&&`, `!`
- Regex: `=~` (ej: `workspace.name =~ '^special:.+$'`)
- Elvis operator: `?:`
- Safe access: `?.` o `?.[index]`
- Conditionals: `condition ? 'value' : 'other'`
- Funciones útiles:
  - `round(number, decimals)` - Redondear
  - `floor/ceil(number)` - Redondear abajo/arriba
  - `min(a, b)`, `max(a, b)` - Min/max
  - `formattime(timestamp, format)` - Formatear tiempo
  - `formatbytes(bytes)` - Bytes legibles

### Ejemplo
```lisp
(label :text {count > 10 ? "Mucho" : "Poco"})
(label :text "El valor es: ${round(value, 1)}")
```

## Variables Mágicas (Magic Variables)
- `{window.name}` - Nombre de la ventana actual
- `{monitor.name}` - Nombre del monitor actual
- `{mouse.x}`, `{mouse.y}` - Posición del mouse
- `{workspace.name}` - Nombre del workspace actual

## Widgets Nativos Recomendados
- `scale` - Slider/barra de progreso
- `circular-progress` - Progress circular
- `color-button` - Selector de color nativo
- `calendar` - Widget calendario nativo
- `eventbox` - Para capturar eventos de scroll/hover
- `stack` - Para mostrar widgets alternados
- `transform` - Transformaciones (rotate, scale, translate)

## Referencias
- [EWW Documentation](https://elkowar.github.io/eww/)
- [EWW Widgets](https://elkowar.github.io/eww/widgets.html)
- [EWW Theming](https://elkowar.github.io/eww/working_with_gtk.html)
- [EWW Expressions](https://elkowar.github.io/eww/expression_language.html)
- [hyprwm/Hyprland](https://github.com/hyprwm/Hyprland)
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)