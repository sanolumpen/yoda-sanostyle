# DEBIAN_SETUP - Notas específicas para Debian 13

Resumen: Debian 13 es el objetivo; algunos paquetes (Hyprland, EWW, Waybar) pueden no estar en la rama *stable*. Estas notas muestran opciones seguras para instalarlos en Debian.

1) Estrategias posibles
- Preferir paquetes empaquetados por la distro (stable/backports)
- Tomar paquetes puntuales desde *testing* con apt-pinning (menos invasivo que *full upgrade*)
- Compilar desde origen si no se desea cambiar fuentes del sistema

2) Añadir testing (opcional y con riesgo)

Crear `/etc/apt/sources.list.d/testing.list` con:

```
deb http://deb.debian.org/debian testing main contrib non-free
deb-src http://deb.debian.org/debian testing main contrib non-free
```

Preferir stable por defecto con `/etc/apt/preferences.d/kuri-dots.pref` (ver INSTALLATION.md).

3) Instalar paquetes puntuales desde testing

```bash
sudo apt update
sudo apt -t testing install hyprland eww waybar
```

4) Uso de Backports
- Revisar si el paquete está en `bookworm-backports` o `bullseye-backports` según la nomenclatura de tu sistema. Backports es menos riesgoso que usar testing.

5) Compilar desde fuente (resumen)
- Instalar dependencias de compilación
- Clonar repositorios upstream
- Seguir instrucciones de build oficiales

6) Recomendaciones
- Hacer backup antes de cambios en APT: `sudo apt-mark showmanual > manual-packages.txt`
- Probar en máquina virtual o contenedor antes del sistema principal
- Documentar paquetes instalados (usar `pkg/debian13.txt` como base)

Referencias:
- https://www.debian.org/doc/manuals/apt-howto/
- Hyprland upstream: https://github.com/hyprwm/Hyprland

Última actualización: 2026-05-10
