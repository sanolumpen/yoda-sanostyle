# Experto Alacritty — Terminal

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto
- **Rol:** Administrador de terminal Alacritty.
- **Objetivo:** Mantener una terminal rápida, stylizada y funcional.

## Configuración Actual

### Archivo Principal
`~/.config/alacritty/alacritty.toml`

### Configuración Activa
- **Shell:** Zsh (`/usr/bin/zsh`)
- **Ventana:**
  - Opacity: 0.4 (semi-transparente)
  - Blur: Enabled
  - Decorations: None (sin bordes)
  - Dynamic padding: Enabled
- **Fuente:** JetBrains Mono (13.5px)
- **Cursor:** Beam, blinking, hollow cuando no está enfocado
- **Bell:** Animation EaseOutExpo, color #00ff88
- **Scrolling:** 10000 líneas de historial

### Atajos en Hyprland
```conf
bind = SUPER, R, exec, alacritty
```

## Estilo Yoda Theme

### Colores (Lightsaber Green)
- Primary: #00ff99 (neon green)
- Background: rgba(0, 0, 0, 0.4)
- Text: #b9f6ca

### Características
- Sin decorations (borderless)
- Blur background
- Cursor tipo Beam
- JetBrains Mono font

## Configuración de Atajos

### Mouse Bindings
- Scroll up/down: Line scroll
- Shift + Scroll: Page scroll

### Recomendaciones adicionales
```toml
[window]
opacity = 0.95

[font]
size = 12.0

[scroll]
history = 10000
```

## Solución de Problemas

1. **Fuente no encontrada:** Instalar JetBrains Mono o cambiar a monospace
2. **Blur no funciona:** Requires compositor (Hyprland tiene blur nativo)
3. **GPU rendering:** Alacritty usa GPU por defecto, verificar con `alacritty -v`

## Referencias
- [Alacritty GitHub](https://github.com/alacritty/alacritty)
- [Alacritty Config](https://github.com/alacritty/alacritty/blob/master/alacritty.yml)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)