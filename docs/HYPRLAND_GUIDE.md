# HYPRLAND_GUIDE — Guía rápida

## Qué es Hyprland
- Gestor de ventanas Wayland, dinámico y configurable.
- Versión actual: **0.54.3+ds-1~bpo13+1** (desde Debian 13 trixie-backports, abril 2026)
- A partir de **0.55+** la sintaxis migra a Lua; esta guía cubre 0.54.x con sintaxis hyprlang.

## Instalación desde trixie-backports (recomendado)

```bash
sudo apt -t trixie-backports install hyprland
```

### Paquetes disponibles en backports

| Paquete | Descripción |
|---|---|
| `hyprland` | Compositor principal |
| `hyprlock` | Bloqueo de pantalla |
| `hyprpaper` | Fondo de pantalla |
| `hypridle` | Demonio de idle/inactividad |
| `xdg-desktop-portal-hyprland` | Portal XDG para captura de pantalla/compartición |

### Instalación completa

```bash
sudo apt -t trixie-backports install hyprland hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland
```

## Ubicación de configuración

| Concepto | Ruta |
|---|---|
| Directorio de configuración | `~/.config/hypr/` |
| Archivo principal | `~/.config/hypr/hyprland.conf` |
| Scripts auxiliares | `~/.config/hypr/scripts/` |
| En este repo | `hypr/hyprland.conf` (desde raíz del repo) |

## Secciones clave de la configuración

### decoration
Controla sombras, bordes redondeados, opacidad y desenfoque.

```hyprlang
decoration {
    rounding = 12
    active_opacity = 1.0
    inactive_opacity = 0.85
    dim_inactive = true
    dim_strength = 0.15

    shadow {
        enabled = true
        range = 12
        render_power = 4
        color = rgba(00ff9933)
    }

    blur {
        enabled = true
        size = 5
        passes = 3
        new_optimizations = on
        noise = 0.0117
        contrast = 0.2
        brightness = 1.0
    }
}
```

### animations
Curvas bezier personalizadas y animaciones por elemento.

```hyprlang
animations {
    enabled = true
    bezier = yodaOut, 0.05, 0.9, 0.1, 1.05
    bezier = yodaIn, 0.0, 0.0, 0.2, 1.0

    animation = windows, 1, 5, yodaOut, slide
    animation = windowsOut, 1, 4, yodaIn, slide
    animation = fade, 1, 4, yodaOut
    animation = workspaces, 1, 4, yodaOut, slide
    animation = border, 1, 6, default
}
```

#### Curvas bezier definidas

| Curva | P1 | P2 | Uso |
|---|---|---|---|
| `yodaOut` | (0.05, 0.9) | (0.1, 1.05) | Entrada rápida, rebote sutil |
| `yodaIn` | (0.0, 0.0) | (0.2, 1.0) | Salida suave |

#### Parámetros de animation

Formato: `animation = <nombre>, <activado/0-1>, <velocidad>, <curva>, <estilo>`

- **activado**: `0` para desactivar, `1` para activar
- **velocidad**: mayor = más rápida (típico 4-8)
- **curva**: nombre de bezier o `default`
- **estilo**: `slide`, `fade`, `slidevert`, `popin` (opcional)

### window rules
Reglas por clase/título de ventana.

```hyprlang
windowrule {
    name = thunar-float
    match:class = ^(thunar)$
    float = yes
}

windowrule {
    name = obs-fullscreen
    match:class = ^(obs)$
    fullscreen = yes
}
```

### binds
Atajos de teclado.

```hyprlang
bind = SUPER, Return, exec, alacritty
bind = SUPER, Q, killactive
bind = SUPER, D, exec, ~/.config/wofi/wofi-launch.sh --show drun
```

### dwindle (layout)
Configuración del layout por defecto.

```hyprlang
general {
    gaps_in = 5
    gaps_out = 20
    border_size = 3
    col.active_border = rgba(00ff99ff) rgba(66ffb2ff) 45deg
    layout = dwindle
    no_border_on_floating = false
}
```

## NVIDIA RTX 3060 — Notas específicas

### Variables de entorno necesarias

```hyprlang
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
env = NVD_BACKEND,direct
```

### Sección opengl

```hyprlang
opengl {
    nvidia_anti_flicker = true
}
```

### Drivers recomendados
- **nvidia-driver** (probado con 560.x desde trixie)
- Evitar `nouveau` en Hyprland (sin soporte para algunas extensiones)

## Troubleshooting

### Comandos hyprctl útiles

```bash
hyprctl version                    # Versión del compositor
hyprctl reload                     # Recargar configuración (sin reiniciar sesión)
hyprctl monitors                   # Estado de monitores
hyprctl clients                    # Ventanas activas
hyprctl devices                    # Dispositivos de entrada
hyprctl dispatch exec <comando>    # Ejecutar comando desde terminal
hyprctl keyword <sección> <valor>  # Cambiar configuración en caliente
hyprctl setcursor <tema> <tamaño>  # Cambiar cursor en caliente
```

### Verificar sintaxis de la configuración
```bash
hyprctl reload
# Si hay errores de sintaxis, aparecerán en la salida de hyprctl
```

### Logs
```bash
hyprctl systeminfo
journalctl --user -xe | grep hypr
```

### Errores comunes

| Síntoma | Posible solución |
|---|---|
| Pantalla en negro al iniciar | Verificar `monitor=,preferred,auto,1` |
| Cursor invisible | `WLR_NO_HARDWARE_CURSORS=1` |
| Sin sonido | Verificar `wpctl status` y `pipewire` |
| Ventanas sin bordes | Verificar `general { border_size }` |
| Flickering NVIDIA | `opengl { nvidia_anti_flicker = true }` |

## Herramientas complementarias

| Herramienta | Propósito |
|---|---|
| `hyprctl` | Consulta y control del compositor |
| `hyprlock` | Bloqueo de pantalla |
| `hyprpaper` | Gestor de fondos |
| `hypridle` | Gestión de idle/inactividad |
| `grim` | Capturas de pantalla |
| `slurp` | Selección de región para grim |
| `wl-copy` | Clipboard Wayland |
| `swayidle` | Alternativa a hypridle |
| `wlogout` | Menú de cierre de sesión |

## Lecturas recomendadas
- Documentación oficial: https://wiki.hyprland.org/
- Repositorio: https://github.com/hyprwm/Hyprland
- Paquete Debian: https://tracker.debian.org/pkg/hyprland

## Referencia rápida de sintaxis hyprlang

```hyprlang
# Comentarios con #
binding = valor                          # Variable simple
sección {                                # Bloque
    sub_opción = valor
}
bind = MODS, TECLA, acción               # Atajos
windowrule { ... }                       # Reglas de ventana
exec-once = comando                      # Ejecutar al inicio
exec = comando                           # Ejecutar en cada reload
```

Última actualización: 2026-05-11
