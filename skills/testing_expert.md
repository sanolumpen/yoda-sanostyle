---
name: testing_expert
description: Testing BATS, pytest, agentización, CI/CD integration
trigger: Escribir tests, automatizar pruebas, validación de configs
---

# Experto Testing — Sano Dots Test Suite (v2.0)

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.
> Ver: [TESTING_PLAN.md](./TESTING_PLAN.md)

## Contexto del Proyecto (2026)

- **Rol:**QA Engineer para configuración Hyprland/Eww/Waybar
- **Objetivo:** Mantener suite de tests reproducible y agentizada

---

## Stack de Testing (2026)

| Componente | Herramienta | Versión |
|------------|-------------|---------|
| Bash Tests | BATS-Core | 1.11+ |
| Python Tests | pytest | 8.x |
| Go Tests | testing package | 1.26+ |
| Agentic Runner | test-runner.sh | v2.0 |

---

## Estructura de Tests

```
tests/
├── bats/                    # Bash tests
│   ├── hypr/               # Hyprland scripts
│   │   ├── discord.bats
│   │   ├── brave.bats
│   │   └── wallpaper.bats
│   ├── eww/                # Eww widgets
│   │   └── notes.bats
│   └── config/             # Config validation
│       └── hyprland_config.bats
├── pytest/                 # Python tests
│   ├── eww/
│   │   ├── test_football.py
│   │   └── test_gcal.py
│   └── pytest.ini
└── README.md
```

---

## Uso del Test Runner

```bash
# Todos los tests
./scripts/test-runner.sh all

# Solo BATS
./scripts/test-runner.sh bats hypr

# Solo pytest
./scripts/test-runner.sh pytest eww

# Solo validación de configs
./scripts/test-runner.sh config

# Modo CI (fail-fast)
./scripts/test-runner.sh ci

# Modo watch (auto-reload)
./scripts/test-runner.sh watch
```

---

## Reglas para Tests BATS

### Estructura Básica

```bash
#!/usr/bin/env bats

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "nombre del test" {
    # Test code
    assert [ -f "$SCRIPT_DIR/script.sh" ]
}
```

### Assertions Disponibles

| Assertion | Descripción |
|-----------|-------------|
| `assert [ condition ]` | Verdadero si condición es true |
| `assert_success` | Verifica exit code 0 |
| `assert_failure` | Verifica exit code != 0 |
| `assert_output` | Verifica output exacto |
| `assert_output --partial "texto"` | Verifica contenido |

### Ejemplo: Test de Wrapper NVIDIA

```bash
@test "discord.sh contains NVIDIA fix" {
    run grep -q "use-gl=desktop" "$SCRIPT_DIR/discord.sh"
    assert_success
}
```

---

## Reglas para Tests pytest

### Estructura Básica

```python
import pytest
from unittest.mock import patch, MagicMock

class TestWidget:
    @pytest.fixture
    def sample_data(self):
        return {"key": "value"}

    def test_function(self, sample_data):
        assert sample_data["key"] == "value"

    @pytest.mark.parametrize("input,expected", [
        ("value1", "result1"),
        ("value2", "result2"),
    ])
    def test_parametrized(self, input, expected):
        assert process(input) == expected
```

### Marcadores (Markers)

```python
@pytest.mark.unit       # Tests unitarios rápidos
@pytest.mark.integration # Tests de integración
@pytest.mark.slow       # Tests lentos
```

### Ejecución

```bash
# Todos los tests
pytest tests/pytest/

# Con coverage
pytest tests/pytest/ --cov=scripts --cov-report=html

# Solo unit tests
pytest tests/pytest/ -m unit
```

---

## Agentización de Tests (2026)

El test runner incluye capacidades agentizadas:

### 1. Detección de Cambios
```bash
# Auto-detecta qué archivos cambiaron desde el último test
detect_changes
```

### 2. Integración con Engram
```bash
# Guardar resultados en memoria
engram save "Test run $TIMESTAMP" "Results: $passed/$total" --type learning
```

### 3. LLM-as-Judge (Opcional)
```python
# scripts/agents/test_analyzer.py
# Analiza fallos usando LLM para encontrar causa raíz
```

---

## Integración CI/CD

### GitHub Actions

```yaml
# .github/workflows/test-all.yml
name: Test All Components
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run test suite
        run: ./scripts/test-runner.sh ci
```

---

## Validación de Configs

### Hyprland
```bash
hyprctl parse ~/.config/hypr/hyprland.conf
```

### Waybar
```bash
# Validar JSON
python3 -c "import json; json.load(open('config.jsonc'))"
```

### EWW
```bash
eww daemon && eww reload
```

---

## Métricas y Objetivos

| Métrica | Objetivo |
|---------|----------|
| Coverage Bash | > 70% |
| Coverage Python | > 80% |
| Tiempo de ejecución | < 5 min |
| Flaky tests | 0% |

---

## Referencias

- [BATS-Core](https://github.com/bats-core/bats-core)
- [Pytest Docs](https://docs.pytest.org/)
- [Agentic Testing 2026](https://www.baserock.ai/blog/best-ai-testing-tools-in-2026)
- [Go Testing](https://go.dev/doc/testing)

---

*Skill actualizado: 2026-05-11*