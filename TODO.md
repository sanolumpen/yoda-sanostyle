# TODO - kuri-dots
> Última actualización: 2026-05-11

---

## 🔴 Pendiente (por hacer)

### Archivos sin commitear
- [x] Commitear skills modificados (10 archivos) - hecho
- [x] Commitear archivos de análisis EWW - hecho
- [x] Commitear TESTING_PLAN.md y TEST_RESULTS_2026-05-11.md - hecho

### Repositorio y sincronización
- [x] kitty → ya en repo (tema Yoda: #00ff99)
- [x] nemo → ya en repo (tema GTK global)
- [x] cava → ya en repo (tema Yoda: #00ff99)
- [x] waybar → ya en repo (tema Yoda: #00ff99, #b9f6ca)
- [x] Crear scripts de instalación/agentización (install.sh)
- [x] Limpiar ~/descargas/kuri-dots (ya estaba vacío)

### Documentación
- [x] Crear CONTRIBUTING.md
- [x] Actualizar CHANGELOG

### Hyprland
- [x] Animaciones con curvas personalizadas (yodaIn/yodaOut)
- [x] Shadow con glow verde (rango 12, poder 4)
- [x] Blur mejorado (size 5, passes 3)
- [x] Dim de ventanas inactivas (15%)
- [x] Window swallowing (terminales)
- [x] Border size 3 con gradiente #00ff99→#66ffb2
- [x] Documentación actualizada (HYPRLAND_GUIDE, DEBIAN_SETUP, header)
- [x] Dwindle smart split + smart resizing
- [x] Window rules por workspace (Brave→2, Discord→3, Steam→4, Blender→5)
- [x] Gestos touchpad (3 dedos swipe)
- [x] Unificar scripts wrapper (brave.sh, discord.sh, steam.sh, gdevelop.sh → launch-app.sh)
- [x] Fix inconsistencia wallpaper (hyprpaper vs swww)
- [x] Optimizar startup.sh (sacar sleeps innecesarios)
- [x] Tests de validación de sintaxis hyprland

---

## 🟡 En Progreso

### EWW Mejoras Visuales (EWW_MEJORAS_VISUALES_2026-05-11.md)
- [x] Fondo de widgets muy oscuro → backdrop-blur
- [x] Gradientes en algunos elementos (headers, backgrounds)
- [x] Feedback visual en estados (hover, active)
- [x] Estilo sticky notes mejorado
- [x] Efectos de hover mejorados
- [ ] Animaciones de entrada (no soportado por GTK3)

---

## ✅ Completado (2026-05-11)

### EWW
- [x] Calendario: lunes como primer día (L M M J V S D)
- [x] CSS: eliminar @keyframes (GTK3 no soporta)
- [x] Launcher: corregir ícono alacritty

### Testing
- [x] Framework BATS + pytest instalado
- [x] 367 tests creados (339 BATS + 28 pytest)
- [x] GitHub Actions workflow
- [x] Scripts: install-bats.sh, setup-testing.sh, test-runner.sh

### Sincronización
- [x] sync-kuri-dots.sh → ~/Documentos/dotfiles (antes ~/descargas/kuri-dots)
- [x] README.md actualizado

### Docs
- [x] AGENTS.md actualizado
- [x] CONFIG_COMPARISON.md creado

---

## 📋 Por Investigar

- [ ] Waybar funcionando correctamente en ~/.config?
- [ ] Scripts de testing pasan en CI localmente?
- [ ] Hay más configuraciones en ~/.config que faltan en el repo?

---

## 🔗 Referencias

- [CONFIG_COMPARISON.md](./CONFIG_COMPARISON.md) - Comparación ~/.config vs repo
- [AGENTS.md](./AGENTS.md) - Índice de skills
- [TESTING_PLAN.md](./TESTING_PLAN.md) - Plan de testing
- [EWW_MEJORAS_VISUALES_2026-05-11.md](./EWW_MEJORAS_VISUALES_2026-05-11.md) - Mejoras visuales propuestas
- [VERSIONES.md](./VERSIONES.md) - Historial de versiones

---

## ⚡ Comandos útiles

```bash
# Ver pendientes
grep -r "TODO" --include="*.md" .

# Sincronizar
./scripts/sync-kuri-dots.sh status

# Tests
./scripts/test-runner.sh all
```