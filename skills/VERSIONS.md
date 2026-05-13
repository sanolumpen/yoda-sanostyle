# Versiones Actuales - Sano Dots Rice Debian Yoda

## Programas Principales (Mayo 2026)

| Programa | Versión Actual | Notas |
|----------|---------------|-------|
| Hyprland | 0.54.3 | Wayland compositor |
| EWW | 0.6.0 | Widgets |
| Waybar | 0.12.0 | Barra de estado |
| Alacritty | 0.15.1 | Terminal |
| Brave | Latest | Navegador |
| Discord | 0.0.x | Chat |
| Neovim | 0.10.x | Editor |
| LazyVim | 11.x | Neovim distro |

## Correcciones Aplicadas (2026-05-10)

- [x] typo ELECTON → ELECTRON (hyprland.conf)
- [x] Conflicto SUPER+H removido (fastfetch → movefocus L)
- [x] eww.css copiado a ~/.config/eww/
- [x] waybar/style.css copiado a ~/.config/waybar/
- [x] music.sh sincronizado (restaurado fallback portada)
- [x] mimeapps.list sincronizado (Brave como default)
- [x] wallpaper.sh vacío → placeholder limpio
- [x] post-install.sh corregida ruta .zshrc
- [x] trailing space eliminado en línea 41

## Configuraciones NVIDIA

Hyprland 0.54+ soporta:
```hypr
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = ELECTRON_OZONE_PLATFORM_HINT,auto
env = NVD_BACKEND,direct
```

Opciones de render válidas:
```hypr
opengl {
    nvidia_anti_flicker = true
}

misc {
    vfr = false
}
```

## Referencia: Wiki Hyprland
https://wiki.hyprland.org/Nvidia/