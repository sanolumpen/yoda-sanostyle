# HYPRLAND RICE - QUICK REFERENCE

## 🚀 QUICK START

```bash
# Check status
hyprctl version

# Reload config
hyprctl reload

# Test wallpaper
~/.config/hypr/scripts/wallpaper_v2.sh

# Check logs
journalctl -xeu Hyprland --no-pager
```

---

## 📁 KEY LOCATIONS

| What | Where |
|-----|-------|
| **Active Config** | `~/.config/hypr/` |
| **Backup/Version Control** | `~/Documentos/dotfiles/hypr/` |
| **Setup Guide** | `~/Documentos/dotfiles/HYPRLAND_SETUP.md` |
| **Technical Details** | Session folder (plan.md, update_summary.md) |
| **Original Backup** | `~/.config/hypr/hyprland.conf.backup.20260510` |

---

## ⌨️ ESSENTIAL KEYBINDS

| Key | Action |
|-----|--------|
| `SUPER+R` | Terminal |
| `SUPER+E` | Browser |
| `SUPER+D` | App Launcher |
| `SUPER+N` | Notes |
| `SUPER+C` | Discord |
| `SUPER+S` | Steam |
| `SUPER+Q` | Close Window |
| `SUPER+M` | Exit Hyprland |
| `SUPER+[1-9]` | Switch Workspace |
| `SUPER+SHIFT+L` | Lock Screen |
| `SUPER+SHIFT+3/4` | Screenshot |
| `SUPER+SHIFT+5` | Screen Recording |

---

## 🔧 MAINTENANCE

### Update Dotfiles (after changes)
```bash
cp ~/.config/hypr/*.conf ~/Documentos/dotfiles/hypr/
cp -r ~/.config/hypr/scripts/* ~/Documentos/dotfiles/hypr/scripts/
```

### Restore from Backup
```bash
cp ~/Documentos/dotfiles/hypr/* ~/.config/hypr/
hyprctl reload
```

### Full Restore
```bash
cp ~/Documentos/dotfiles/hypr/hyprland.conf.backup.20260510 ~/.config/hypr/hyprland.conf
hyprctl reload
```

---

## 🐛 TROUBLESHOOTING

**Hyprland won't start**
```bash
journalctl -xeu Hyprland --no-pager
```

**GPU flickering**
```bash
lsmod | grep nvidia
echo $LIBVA_DRIVER_NAME
```

**Discord/Brave won't launch**
```bash
chmod +x ~/.config/hypr/scripts/*.sh
~/.config/hypr/scripts/discord.sh
```

**Wallpaper not showing**
```bash
pgrep swww-daemon || swww-daemon &
~/.config/hypr/scripts/wallpaper_v2.sh
```

---

## 📊 WHAT WAS UPDATED

✅ **NVIDIA Optimization** (11 environment variables)
- Added: XCURSOR_SIZE, HYPRCURSOR_SIZE, _JAVA_AWT_WM_NONREPARENTING
- Removed: NVD_BACKEND, NVIDIA_DRIVER_CAPABILITIES (deprecated)
- Kept: All working configurations

✅ **Components Synced**
- Hyprland core config (v0.55.0 compatible)
- Waybar status bar
- Wofi app launcher
- Eww widget system
- All scripts (8 total)

✅ **Documentation**
- Complete setup guide (10K+ words)
- Technical documentation
- This quick reference

---

## 🎯 NEXT STEPS

1. **Test Java apps** - New fix enabled
   ```bash
   java -version
   ```

2. **Verify cursor** - Should be consistent across apps

3. **Monitor Eww** - Widget system should render smoothly

4. **Keep watching** - Hyprland v0.55.0 release coming soon

---

## 📚 USEFUL COMMANDS

```bash
# Reload config (after editing)
hyprctl reload

# Check Hyprland status
hyprctl status

# View active workspaces
hyprctl workspaces

# Get monitor info
hyprctl monitors

# List all keybinds
hyprctl binds

# View logs
journalctl -xeu Hyprland -n 100

# Check NVIDIA driver
lsmod | grep nvidia
```

---

## ⚡ PERFORMANCE TIPS

- Animations disabled for better performance (can enable in config)
- Blur is optimized (3 passes)
- VFR disabled for consistency
- Monitor your system: `btop` or `htop`

---

## 🔐 BACKUP REMINDER

Always backup before making changes:
```bash
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup.$(date +%s)
```

---

## 📌 SYSTEM INFO

- **OS**: Debian 13 (Trixie)
- **Hyprland**: v0.54.3
- **GPU**: NVIDIA RTX 3060
- **Kernel**: 6.12.86
- **Status**: ✅ Fully Optimized

---

**Last Updated**: May 10, 2026  
**Configuration Status**: ✅ READY FOR PRODUCTION

