# 🛑 CHECKPOINT — Reinicio Pendiente

> Fecha: 2026-05-10
> Estado: Config corregida, pendiente de reboot y validación

---

## ✅ YA CORREGIDO (commit 47f7b3b)

- Typo `ELECTON` → `ELECTRON` en hyprland.conf
- Conflicto `SUPER+H` (fastfetch bind removido, movefocus activo)
- `eww/eww.css` copiado a `~/.config/eww/`
- `waybar/style.css` copiado a `~/.config/waybar/`
- `mimeapps.list` sincronizado (Brave default)
- `music.sh` restaurado con fallback de portada
- `.zshrc` repo actualizado (versión limpia)
- `post-install.sh`: ruta de .zshrc corregida
- Trailing space eliminado en hyprland.conf
- `VERSIONS.md` actualizado

---

## 🔲 PENDIENTE DESPUÉS DEL REINICIO

### 1. Verificación post-reboot
```bash
# Hyprland
hyprctl version
hyprctl monitors

# Servicios
systemctl status NetworkManager
systemctl status ufw

# Comprobar que todo lanzó
pgrep -a waybar
pgrep -a eww
pgrep -a mako
pgrep -a swayidle
pgrep -a wofi
```

### 2. Instalar dependencias faltantes
```bash
# Python para gcal.py + football.py
pip install --user google-api-python-client google-auth-oauthlib beautifulsoup4 requests

# Fonts (si no están instaladas)
# JetBrains Mono, Nerd Fonts (Iosevka), Orbitron

# swww (wallpaper daemon)
sudo pacman -S swww   # si no está en pkglist.txt
```

### 3. Google Calendar — Setup OAuth
```bash
# Descargar credentials.json de Google Cloud Console
# y colocar en: ~/.config/eww/scripts/credentials.json
# Ejecutar gcal_auth.py la primera vez para generar token.pickle
python3 ~/.config/eww/scripts/gcal_auth.py
```

### 4. Tema "yoda" para oh-my-zsh
```bash
# Verificar que exista
ls ~/.oh-my-zsh/custom/themes/yoda.zsh-theme

# Si no existe, copiar desde nvim (si yoda.nvim está instalado) o crear manualmente
```

### 5. Repositorios divergentes (decidir)
```bash
# ~/Documentos/dotfiles/   ← repo actual (branch yoda)
# ~/descargas/kuri-dots/   ← ¿otro repo? Verificar si es intencional

# Unificar si corresponde:
# cd ~/descargas/kuri-dots && git remote -v
```

### 6. Credenciales sensibles (NO commitear)
```bash
# Mover fuera del repo si están trackeados:
# ~/.config/eww/scripts/token.pickle
# ~/.config/eww/scripts/credentials.json
# Agregar a .gitignore si no lo están
```

### 7. Tests rápidos de componentes
```bash
# Alacritty
alacritty -v

# Waybar (matar y relanzar)
killall waybar; waybar &

# EWW (matar y relanzar)
pkill eww; cd ~/.config/eww && eww daemon && eww open-many dashboard_window date_window &

# Wofi
wofi --show drun

# Wlogout
~/.config/wlogout/wlogout.sh

# Btop
btop
```

---

## 📌 NOTAS IMPORTANTES

- `exec-once` múltiples bloques → funciona pero Hyprland 0.54+ soporta `exec-once { cmd1; cmd2; }`
- Los scripts personalizados de EWW (notes, football, gcal) son **muchos** y no están en el repo → considerar pushear al repo si se quiere backup
- El bind `SUPER+H` era conflicto directo: ahora solo es `movefocus left`, el fastfetch se puede bindear a otra tecla si se necesita
- Wallpaper depende de `swww-daemon` → asegurarse que arranca con Hyprland