# Contributing to sano-dots

¡Gracias por tu interés en contribuir a sano-dots!

---

## 🤝 Cómo Contribuir

### 1. Clonar el Repo
```bash
git clone https://github.com/sanolumpen/yoda-sanostyle.git ~/Documentos/dotfiles
cd ~/Documentos/dotfiles
```

### 2. Hacer Cambios
- Edita las configuraciones en `~/Documentos/dotfiles/`
- O edita directamente en `~/.config/` y luego sincroniza:
  ```bash
  ./scripts/sync-sano-dots.sh push-repo
  ```

### 3. Testing
Ejecuta los tests antes de commitear:
```bash
./scripts/test-runner.sh all
```

### 4. Commitear
Seguimos conventional commits:
```
<tipo>(<alcance>): <descripción>

Tipos: feat, fix, docs, chore, refactor, test
```

Ejemplos:
- `feat(eww): add new weather widget`
- `fix(alacritty): correct colors on dark theme`
- `docs: update README with new installation steps`

### 5. Push
```bash
git push origin yoda
```

---

## 📋 Guías

### Estilo de Código
- **Scripts Bash**: seguir `shellcheck` y usar `#!/bin/bash` con `set -e`
- **EWW/Yuck**: sintaxis Lisp simple, indentación consistente
- **CSS**: seguir las convenciones del archivo existente
- **Python**: seguir PEP 8, usar type hints donde sea posible

### Nombres de Variables
- Usar nombres descriptivos en español o inglés consistente
- Evitar abreviaturasconfusas

### Testing
- Agregar tests BATS para scripts nuevos
- Agregar tests pytest para scripts Python nuevos
- Ver `TESTING_PLAN.md` para más detalles

---

## ❓ Preguntas

- ¿Issues? → https://github.com/sanolumpen/yoda-sanostyle/issues
- ¿Dudas? → Abre un discussion

---

## 📜 Licencia

Este proyecto es libre. Ver [ATTRIBUTION.md](./ATTRIBUTION.md) para créditos de dependencias.