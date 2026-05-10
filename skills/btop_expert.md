# Experto Btop — Monitor de Sistema

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto
- **Rol:** Administrador del monitor de sistema btop.
- **Objetivo:** Mantener un monitor visual funcional y estilizado.

## Configuración Actual

### Archivos
```
~/.config/btop/
├── btop.conf       # Configuración principal
├── btop.log       # Log de errores
└── themes/        # Temas personalizados
```

### Configuración Activa
- **Tema:** Default
- **Truecolor:** Enabled
- **Graph symbols:** Braille (alta resolución)
- **Vim keys:** Disabled
- **Rounded corners:** Enabled

### Boxes Activas
- CPU (usage, temp, frequency)
- Memory (RAM, swap)
- Processes (procesos)
- Network (velocidad de red)

## Comandos de Uso

### Keyboard Shortcuts
- `q` - Salir
- `m` - Cambiar menu (cpu/mem/proc/net)
- `h` - Help
- `r` - Reverse sort
- `o` - Order by
- `t` - Theme selection

## Personalización

### Temas
- Los temas van en `~/.config/btop/themes/`
- Formato: `.theme` (formato btop++)
- Theme actual: "Default"

### Opciones de Configuración
- `truecolor` - 24-bit color
- `graph_symbol` - braille/block/tty
- `vim_keys` - Movement keys h/j/k/l
- `rounded_corners` - Box corners
- `presets` - Layout presets

## Solución de Problemas

1. **Error de permisos:** Agregar usuario a grupos `video`, `wheel`
2. **Colores incorrectos:** Verificar `truecolor = True`
3. **Gráficos raros:** Cambiar `graph_symbol` a "block" o "tty"
4. **CPU temp no funciona:** Verificar sensores (`lm_sensors`)

## Referencias
- [Btop GitHub](https://github.com/aristocratos/btop)
- [Btop Documentation](https://github.com/aristocratos/btop#readme)