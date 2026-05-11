# DEBIAN_SETUP — Notas específicas para Debian 13

Resumen: Debian 13 es el objetivo; algunos paquetes (Hyprland, EWW, Waybar) pueden no estar en la rama *stable*. Estas notas muestran opciones seguras para instalarlos en Debian.

## 1) Estrategias posibles
- Preferir paquetes empaquetados por la distro (stable/backports)
- Tomar paquetes puntuales desde *testing* con apt-pinning (menos invasivo que *full upgrade*)
- Compilar desde origen si no se desea cambiar fuentes del sistema

## 2) Backports — Opción recomendada para Hyprland

Desde **abril 2026**, Hyprland **0.54.3+ds-1~bpo13+1** está disponible en **trixie-backports**.

### Instalación

```bash
sudo apt -t trixie-backports install hyprland
```

### Paquetes relacionados también en backports

```bash
sudo apt -t trixie-backports install hyprland hyprlock hypridle xdg-desktop-portal-hyprland
```

> **Nota:** El gestor de fondos activo es **swww** (instalado por separado, vía cargo o GitHub).
> `hyprpaper` está disponible en backports como alternativa pero no se usa activamente.

### Requisito previo: habilitar backports

Asegúrate de tener el repositorio trixie-backports en `/etc/apt/sources.list.d/backports.list`:

```
deb http://deb.debian.org/debian trixie-backports main contrib non-free
deb-src http://deb.debian.org/debian trixie-backports main contrib non-free
```

Luego actualizar:

```bash
sudo apt update
```

## 3) Usar testing (alternativa, con riesgo)

Crear `/etc/apt/sources.list.d/testing.list` con:

```
deb http://deb.debian.org/debian testing main contrib non-free
deb-src http://deb.debian.org/debian testing main contrib non-free
```

Preferir stable por defecto con `/etc/apt/preferences.d/kuri-dots.pref` (ver INSTALLATION.md).

## 4) Instalar paquetes puntuales desde testing

```bash
sudo apt update
sudo apt -t testing install hyprland eww waybar
```

## 5) Compilar desde fuente (resumen)
- Instalar dependencias de compilación
- Clonar repositorios upstream
- Seguir instrucciones de build oficiales

## 6) Recomendaciones
- Hacer backup antes de cambios en APT: `sudo apt-mark showmanual > manual-packages.txt`
- Probar en máquina virtual o contenedor antes del sistema principal
- Documentar paquetes instalados (usar `pkg/debian13.txt` como base)

Referencias:
- https://www.debian.org/doc/manuals/apt-howto/
- Hyprland upstream: https://github.com/hyprwm/Hyprland
- Debian backports: https://backports.debian.org/

Última actualización: 2026-05-11
