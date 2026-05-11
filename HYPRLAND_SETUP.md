# Hyprland Desktop Rice - Setup & Configuration Guide

**Date**: May 10, 2026  
**System**: Debian 13 (Trixie)  
**GPU**: NVIDIA RTX 3060  
**Hyprland Version**: v0.54.3 (forward compatible with v0.55.0)  
**Status**: ✅ Fully Optimized

---

## 📋 Table of Contents

1. [Quick Start](#quick-start)
2. [Installation](#installation)
3. [Configuration Details](#configuration-details)
4. [Keybindings](#keybindings)
5. [Scripts & Utilities](#scripts--utilities)
6. [Troubleshooting](#troubleshooting)
7. [Component Details](#component-details)

---

## 🚀 Quick Start

### Prerequisites
```bash
# Ensure Hyprland is installed
hyprctl version

# Install required dependencies
sudo apt install hyprland hyprlock hyprpaper waybar wofi swww notify-osd
```

### Restore Configuration
```bash
# From this repository to your system
cp -r ~/Documentos/dotfiles/hypr ~/.config/
cp -r ~/Documentos/dotfiles/waybar ~/.config/
cp -r ~/Documentos/dotfiles/wofi ~/.config/
cp -r ~/Documentos/dotfiles/eww ~/.config/

# Start Hyprland
Hyprland
```

### First Launch
```bash
# Reload config after copying
hyprctl reload

# Test wallpaper
~/.config/hypr/scripts/wallpaper_v2.sh

# Verify everything loads (check logs)
journalctl -xeu Hyprland --no-pager
```

---

## 💾 Installation

### Full Setup from Scratch

```bash
# 1. Clone dotfiles
cd ~
git clone <your-repo> Documentos/dotfiles

# 2. Backup existing config (if any)
cp -r ~/.config/hypr ~/.config/hypr.backup.$(date +%Y%m%d)

# 3. Copy all configs
mkdir -p ~/.config/hypr/scripts ~/.config/hypr/wallpaper
cp -r Documentos/dotfiles/hypr/* ~/.config/hypr/
cp -r Documentos/dotfiles/waybar ~/.config/
cp -r Documentos/dotfiles/wofi ~/.config/
cp -r Documentos/dotfiles/eww ~/.config/

# 4. Set permissions
chmod +x ~/.config/hypr/scripts/*.sh

# 5. Reload Hyprland
hyprctl reload
```

### Per-Component Installation

If you only want specific parts:

**Just Hyprland:**
```bash
cp -r Documentos/dotfiles/hypr ~/.config/
hyprctl reload
```

**Just Waybar:**
```bash
cp -r Documentos/dotfiles/waybar ~/.config/
killall waybar; sleep 1; waybar &
```

**Just Wofi:**
```bash
cp -r Documentos/dotfiles/wofi ~/.config/
# Test with SUPER+D
```

**Just Eww:**
```bash
cp -r Documentos/dotfiles/eww ~/.config/
cd ~/.config/eww && eww reload
```

---

## ⚙️ Configuration Details

### Hyprland Core (`hypr/hyprland.conf`)

**Lines**: 192  
**Last Updated**: May 10, 2026  
**Status**: v0.55.0 Ready

#### Key Sections:

1. **NVIDIA Environment Variables** (11 settings)
   ```ini
   # GPU Acceleration
   env = LIBVA_DRIVER_NAME,nvidia
   env = GBM_BACKEND,nvidia-drm
   env = XCURSOR_SIZE,24
   env = HYPRCURSOR_SIZE,24
   
   # Application Fixes
   env = _JAVA_AWT_WM_NONREPARENTING,1
   env = ELECTRON_OZONE_PLATFORM_HINT,auto
   # ... 5 more
   ```
   **Impact**: Fixes GPU rendering, cursor consistency, Java apps, Electron apps

2. **OpenGL Settings**
   ```ini
   opengl {
       nvidia_anti_flicker = true
   }
   ```
   **Impact**: Prevents flickering on NVIDIA Wayland

3. **Monitor Configuration**
   ```ini
   monitor=,preferred,auto,1
   ```
   **Impact**: Auto-detect and configure connected monitors

4. **Startup Applications**
   - Wallpaper manager (swww)
   - Input method (fcitx5)
   - Notifications (mako)
   - Status bar (waybar)
   - Widgets (eww)
   - Lock daemon (swayidle)

5. **Keybindings** (30+ configured)
   - Application launchers
   - Window management
   - Screenshot/recording
   - Audio/brightness controls
   - Workspace switching

6. **Visual Settings**
   - Border radius: 8px
   - Border size: 3px
   - Active border: Cyan gradient
   - Blur: 3 passes
   - Animations: disabled (for performance)

---

## ⌨️ Keybindings

### System Commands
| Key | Action |
|-----|--------|
| `SUPER+R` | Terminal (Alacritty) |
| `SUPER+E` | Browser (Brave) |
| `SUPER+F` | File Manager (Thunar) |
| `SUPER+D` | App Launcher (Wofi) |
| `SUPER+N` | Notes Editor |

### Applications
| Key | Action |
|-----|--------|
| `SUPER+C` | Discord |
| `SUPER+S` | Steam |
| `SUPER+B` | Blender |

### Window Management
| Key | Action |
|-----|--------|
| `SUPER+Q` | Close Window |
| `SUPER+M` | Exit Hyprland |
| `SUPER+H/J/K/L` | Move Focus (vim keys) |

### Screenshots & Recording
| Key | Action |
|-----|--------|
| `SUPER+SHIFT+3` | Fullscreen Screenshot |
| `SUPER+SHIFT+4` | Region Screenshot |
| `SUPER+SHIFT+5` | Start/Stop Recording (OBS) |

### Workspaces
| Key | Action |
|-----|--------|
| `SUPER+[1-9]` | Switch Workspace |
| `SUPER+0` | Toggle Language (fcitx5) |

### Brightness & Audio
| Key | Action |
|-----|--------|
| `XF86MonBrightnessUp/Down` | ±10% Brightness |
| `XF86AudioRaiseVolume/Lower` | ±5% Volume |
| `XF86AudioMute` | Mute/Unmute |

### Session
| Key | Action |
|-----|--------|
| `SUPER+SHIFT+L` | Lock Screen |

---

## 🛠️ Scripts & Utilities

All scripts are located in `~/.config/hypr/scripts/`

### discord.sh
- **Purpose**: Launch Discord with NVIDIA Wayland fixes
- **Fix**: `--use-gl=desktop` (forces OpenGL rendering)
- **Status**: Prevents GPU flickering

### brave.sh
- **Purpose**: Launch Brave with NVIDIA Wayland fixes
- **Fix**: `--disable-gpu-memory-buffer-video-frames`
- **Status**: Prevents video buffer issues

### steam.sh
- **Purpose**: Launch Steam with Wayland compatibility
- **Fix**: `-no-cef-sandbox` (CEF compatibility)
- **Status**: Enables Steam on Wayland

### obs-recording.sh
- **Purpose**: OBS Studio control and management
- **Features**:
  - Auto-start if not running
  - Minimize to tray
  - Auto-cleanup old logs (keeps 3 most recent)
- **Usage**: `SUPER+SHIFT+5` (toggle)

### wallpaper_v2.sh
- **Purpose**: Set desktop wallpaper with transitions
- **Features**:
  - Auto-start swww daemon
  - Random transition effects
  - 3-second transition duration
- **Wallpaper**: `~/.config/hypr/wallpaper/zoro.png`

### gdevelop.sh
- **Purpose**: Launch GDevelop game editor
- **Fix**: `--disable-gpu` (NVIDIA compatibility)

### edit_note.sh
- **Purpose**: Quick note editor integration
- **Location**: `~/.local/share/kuri-notes/nota.txt`

### startup.sh
- **Purpose**: Audio system initialization
- **Waits**: PipeWire audio daemon startup

---

## 🔧 Troubleshooting

### Hyprland Won't Start
```bash
# Check for errors
journalctl -xeu Hyprland --no-pager | tail -50

# Validate config syntax
hyprctl instances

# Try basic config
echo "monitor=,preferred,auto,1" > ~/.config/hypr/hyprland.conf
hyprctl reload
```

### GPU Flickering (NVIDIA)
```bash
# Verify driver is loaded
lsmod | grep nvidia

# Check env variables
echo $LIBVA_DRIVER_NAME
echo $GBM_BACKEND

# Force OpenGL rendering
export __GLX_VENDOR_LIBRARY_NAME=nvidia
hyprctl reload
```

### Discord/Brave Won't Launch
```bash
# Check script permissions
ls -la ~/.config/hypr/scripts/discord.sh
chmod +x ~/.config/hypr/scripts/*.sh

# Test script directly
~/.config/hypr/scripts/discord.sh
```

### Wallpaper Not Showing
```bash
# Check swww daemon
pgrep swww-daemon || echo "Daemon not running"

# Manual wallpaper set
swww-daemon &
sleep 1
swww img ~/.config/hypr/wallpaper/zoro.png

# Check file permissions
ls -la ~/.config/hypr/wallpaper/
```

### Waybar Modules Missing
```bash
# Reload waybar
killall waybar
sleep 1
waybar &

# Check for script errors
~/.config/waybar/scripts/active-workspace.sh

# View waybar logs
journalctl -u waybar -n 50
```

### Eww Widgets Not Loading
```bash
# Check eww daemon
pgrep eww || echo "Eww not running"

# Restart eww
cd ~/.config/eww
eww daemon
eww reload

# Check for CSS errors
tail -f /tmp/eww-*.log
```

---

## 📦 Component Details

### Waybar (Status Bar)

**Config**: `waybar/config.jsonc`

**Modules**:
- **Left**: Clock, Calendar, App indicators
- **Center**: Workspaces
- **Right**: Settings, Audio, Network, Battery, Language, Power

**Custom Modules**:
- `custom/gcal_next`: Next Google Calendar event
- `custom/language`: Input method indicator
- `custom/power`: Power menu

**Styling**: `waybar/style.css` (custom Yoda theme)

### Wofi (App Launcher)

**Config**: `wofi/config`

**Features**:
- 450x350px window
- Search-based app launcher
- Image support (24px icons)
- Dark theme
- Runs `drun` mode

**Keybind**: `SUPER+D`

### Eww (Widget System)

**Config**: `eww/eww.yuck`, `eww/eww.css`

**Widgets**:
- Dashboard with system info
- Date/time display
- Weather (if configured)
- Music controls
- Calendar integration
- Notes interface

**Scripts**: Multiple Python/Bash helpers for system monitoring

**Status**: Mostly working; monitor CSS for regressions (backup available at `~/.config/eww/backup/`)

---

## 📊 System Information

### Hardware
- **GPU**: NVIDIA RTX 3060
- **Driver**: nvidia-driver (550+)
- **Kernel**: 6.12.86
- **Display Server**: Wayland

### Software
- **OS**: Debian 13 (Trixie)
- **Hyprland**: v0.54.3 (March 27, 2026)
- **Dependencies**:
  - hyprland, hyprlock, hyprpaper
  - waybar, wofi, eww
  - swww (wallpaper daemon)
  - fcitx5 (input method)
  - mako (notifications)
  - notify-osd (notification daemon)

---

## 🔄 Maintenance

### Regular Updates
```bash
# Update config from system
cp ~/.config/hypr/*.conf ~/Documentos/dotfiles/hypr/
cp -r ~/.config/hypr/scripts/* ~/Documentos/dotfiles/hypr/scripts/

# Commit to git (if using git)
cd ~/Documentos/dotfiles
git add .
git commit -m "Update Hyprland config - $(date +%Y-%m-%d)"
git push
```

### Backup Before Changes
```bash
# Full backup
cp -r ~/.config/hypr ~/.config/hypr.backup.$(date +%Y%m%d_%H%M%S)

# Backup specific file
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
```

### Monitor for Issues
- Check Hyprland logs: `journalctl -xeu Hyprland`
- Monitor Waybar: `journalctl -u waybar`
- Check Eww: Keep an eye on widget rendering
- Test NVIDIA stability: Watch for GPU crashes

---

## 📞 Support & Resources

- **Hyprland Wiki**: https://wiki.hypr.land/
- **Issue Tracker**: https://github.com/hyprwm/Hyprland/issues
- **Community**: r/hyprland, Discord

---

**Last Updated**: May 10, 2026  
**Maintained By**: Your System  
**License**: Your Configuration (Personal Use)

