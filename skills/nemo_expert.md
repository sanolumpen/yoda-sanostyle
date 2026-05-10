# Experto Nemo — Explorador de Archivos

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto
- **Rol:** Administrador del explorador de archivos Nemo.
- **Objetivo:** Mantener un explorador funcional integrado con el escritorio.

## Configuración Actual

### Archivos
```
~/.config/nemo/
├── desktop-metadata  # Metadatos del escritorio
```

### Configuración en Hyprland
- Atajo: `SUPER + F` → `thunar` (configuración legacy)
- Nemo está configurado pero usar Thunar como launcher actual

## Integración con Hyprland

### Atajos Configurados
```conf
bind = SUPER, F, exec, thunar
```

### Notas
- Nemo requiere escritorio Cinnamon o dependencias específicas
- Thunar está activo como launcher principal
- Para usar Nemo: cambiar `thunar` por `nemo` en atajos

## Configuración Recomendada

### Desktop Integration
Para integrar con escritorio:
```bash
# Habilitar escritorio
gsettings set org.nemo.preferences show-desktop-icons true

# Comportamiento de carpetas
gsettings set org.nemo.preferences default-folder-viewer 'list-view'
```

## Solución de Problemas

1. **Nemo no abre:** Verificar instalación `nemo`
2. **Sin iconos:** Instalar `nemo-preview` y extensiones
3. **Errores de thumbnails:** Verificar `thumbnailers`

## Referencias
- [Nemo GitHub](https://github.com/linuxmint/nemo)
- [Nemo Documentation](https://linuxmint.com/documentation.php)