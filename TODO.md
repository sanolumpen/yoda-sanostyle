# TODO - kuri-dots
> Última actualización: 2026-05-11

---

## 🔴 Pendiente (por hacer)

### Archivos sin commitear
- [ ] Commitear skills modificados (10 archivos)
- [ ] Commitear archivos de análisis EWW
- [ ] Commitear TESTING_PLAN.md y TEST_RESULTS_2026-05-11.md

### Repositorio y sincronización
- [x] kitty → agregado (tema Yoda: #00ff99)
- [x] nemo → ya en repo (tema GTK global)
- [x] cava → ya en repo (tema Yoda: #00ff99)
- [ ] Crear scripts de instalación/agentización (install.sh)
- [ ] Limpiar ~/descargas/kuri-dots (vacío)

### Documentación
- [ ] Crear CONTRIBUTING.md
- [ ] Actualizar CHANGELOG

---

## 🟡 En Progreso

### EWW Mejoras Visuales (EWW_MEJORAS_VISUALES_2026-05-11.md)
- [ ] Fondo de widgets muy oscuro → backdrop-blur
- [ ] Animaciones de entrada
- [ ] Gradientes en algunos elementos
- [ ] Feedback visual en estados
- [ ] Estilo sticky notes mejorado (parcial)
- [ ] Efectos de hover mejorados

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