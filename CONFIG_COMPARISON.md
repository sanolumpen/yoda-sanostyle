# Configuración de Dotfiles - Comparación y Sincronización

## Fecha: 2026-05-10

---

## Comparación: ~/.config/ vs ~/Documentos/dotfiles/

### Directorios que están en LOCAL (~/.config/) pero NO en el REPO:

| Directorio | Descripción | Incluir en Repo? |
|------------|-------------|------------------|
| aichat | AI chat config | ❌ No - datos sensibles |
| antigravity / Antigravity | App de AI | ❌ No - config personal |
| autostart | Apps que inician con el sistema | ✅ Sí - si es genérico |
| backup | Backups locales | ❌ No |
| BraveSoftware | Browser config | ❌ No - datos personales |
| cava | Visualizer de audio | ✅ Sí |
| discord | Chat app | ❌ No - datos sensibles |
| google-chrome | Browser | ❌ No - datos personales |
| GDevelop 5 | Game engine | ✅ Sí |
| fcitx / fcitx5 | Input method | ✅ Sí |
| kitty | Terminal | ✅ Sí |
| libreoffice | Office suite | ✅ Sí |
| nemo | File explorer | ✅ Sí |
| nvim | Editor config | ✅ Sí |
| rofi | App launcher | ❌ Eliminado, usamos wofi |
| steam | Gaming platform | ❌ No - datos sensibles |
| waybar | Bar status | ✅ Sí |
| wofi | App launcher | ✅ Sí |
| wlogout | Logout screen | ✅ Sí |
| scripts/ | Scripts personales | ⚠️ Depende |
| skills/ | Skills de AI | ⚠️ Depende |

### Directorios que están en el REPO pero NO en LOCAL:

| Directorio | Estado |
|------------|--------|
| alacritty | ✅ Configurado |
| assets | ✅ Imágenes |
| btop | ✅ Configurado |
| eww | ✅ Widgets |
| fastfetch | ✅ Configurado |
| flameshot | ✅ Configurado |
| hypr | ✅ Configurado |
| mako | ✅ Notificaciones |
| scripts/ | ✅ Scripts |
| skills/ | ✅ Documentación |
| tmux | ✅ Configurado |
| waybar | ✅ Configurado |
| wlogout | ✅ Configurado |
| wofi | ✅ Configurado |

---

## Sincronización: Del Repo a la PC

### Para copiar todo el repo a ~/.config/:

```bash
# 1. Hacer backup de ~/.config/ actual
cp -r ~/.config ~/.config.backup

# 2. Copiar directorios del repo
cp -r ~/Documentos/dotfiles/alacritty ~/.config/
cp -r ~/Documentos/dotfiles/btop ~/.config/
cp -r ~/Documentos/dotfiles/cava ~/.config/
# ... etc

# 3. Recargar servicios
hyprctl reload
pkill waybar; waybar &
pkill -f eww; eww daemon
```

---

## Mejores Prácticas de .gitignore

### Basado en documentación oficial de Git y GitHub:

1. **Primero y temprano**: Crear .gitignore antes del primer commit
2. **No trackedear datos sensibles**: Credenciales, passwords, tokens
3. **No trackear cachés**: .cache/, *.log, *.tmp
4. **No trackear configs de apps con datos personales**: Discord, Chrome, Steam
5. **Usar patrones genéricos**: *.log, *.bak, /directorio/
6. **No trackear keys SSH/GPG**: .ssh/, .gnupg/
7. **Excepciones con !**: !importante.log para incluir excepciones
8. **Comentar el .gitignore**: Para entender qué se ignora y por qué

### Comandos útiles:

```bash
# Ver qué archivos están siendo ignorados
git status --ignored

# Dejar de ignorar un archivo previamente ignorado
git rm --cached ARCHIVO

# Ignorar cambios en archivos ya trackeados
git update-index --assume-unchanged ARCHIVO
```

---

## Agentización

### ¿Qué es?
Agentizar los dotfiles significa crear scripts o automation que:
1. Instalen automaticamente las configuraciones
2. Detecten el sistema operativo y adapten las configs
3. Instalen las dependencias necesarias
4. Mantengan sincronizado el repo con ~/.config/

### Estructura sugerida para agentización:

```
dotfiles/
├── install.sh              # Script principal de instalación
├── install/
│   ├── arch.sh           # Instalador para Arch
│   ├── debian.sh         # Instalador para Debian
│   ├── fedora.sh         # Instalador para Fedora
│   └── macos.sh          # Instalador para macOS
├── sync.sh               # Script para sincronizar cambios
├── link.sh               # Crea symlinks de configs
└── README.md             # Documentación
```

### Install.sh básico:

```bash
#!/bin/bash
# install.sh - Instalador de dotfiles

set -e

echo "📦 Instalando dotfiles de yoda-sanostyle..."

# Detectar OS
if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS=$ID
else
    OS="unknown"
fi

echo "🖥️ Sistema detectado: $OS"

# Crear directorios necesarios
mkdir -p ~/.config

# Instalar configs
for dir in alacritty btop eww fastfetch hypr waybar wofi wlogout; do
    if [ -d "$dir" ]; then
        echo "⚙️ Instalando $dir..."
        cp -r "$dir" ~/.config/
    fi
done

echo "✅ Instalación completa!"
echo "🔄 Recargando configuraciones..."
hyprctl reload
```

---

## Próximos Pasos

1. [ ] Agregar kitty, nemo, cava al repo
2. [ ] Crear scripts de instalación/agentización
3. [ ] Documentar cómo contribuir al repo
4. [ ] Agregar más información al .gitignore si es necesario