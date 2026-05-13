# Sano Dots Testing Plan

**Fecha:** 2026-05-11
**Proyecto:** Yoda Sanostyle (Hyprland Rice)
**Estado:** Plan de Pruebas Agentizado

---

## Tabla de Contenidos

1. [Resumen Ejecutivo](#resumen-ejecutivo)
2. [Arquitectura de Testing](#arquitectura-de-testing)
3. [Testing por Tecnología](#testing-por-tecnología)
4. [Agentización de Pruebas](#agentización-de-pruebas)
5. [Plan de Implementación](#plan-de-implementación)
6. [Ejecución y Mantenimiento](#ejecución-y-mantenimiento)

---

## Resumen Ejecutivo

Este documento define la estrategia de testing para el proyecto Sano Dots (configuración de Hyprland/Eww/Waybar) y el proyecto Engram (sistema de memoria para agentes IA). El objetivo es crear un sistema de pruebas agentizado que permita validación automática y continua de todas las configuraciones, scripts y funcionalidades.

**Stack de Testing:**
| Componente | Herramienta | Tipo |
|------------|-------------|------|
| Scripts Bash | BATS-Core | Unit/Integration |
| Scripts Python | pytest | Unit/Integration |
| Go (Engram) | testing package | Table-driven |
| Configs (Hypr/Waybar/Eww) | Shell + Validation | Integration |
| Agentes | Custom + LLM-as-judge | Agentic |

---

## Arquitectura de Testing

### Estructura de Directorios

```
~/Documentos/dotfiles/
├── tests/                          # Raíz de tests
│   ├── bats/                       # Tests Bash
│   │   ├── lib/                   # BATS libraries
│   │   ├── hypr/                 # Tests de Hyprland
│   │   ├── eww/                  # Tests de Eww widgets
│   │   └── scripts/              # Tests de scripts
│   ├── pytest/                   # Tests Python
│   │   ├── eww/                  # Tests de widgets
│   │   └── fixtures/             # Pytest fixtures
│   ├── go/                       # Tests Go (engram reference)
│   ├── config/                   # Tests de configuración
│   └── agents/                   # Scripts de agentización
│
├── .github/
│   └── workflows/
│       └── test-all.yml          # CI/CD automation
│
├── scripts/
│   └── test-runner.sh            # Agentic test runner
│
└── TESTING_PLAN.md               # Este documento
```

### Flujo de Testing Agentizado

```
┌─────────────────────────────────────────────────────────────┐
│                    TEST RUNNER (Agent)                     │
├─────────────────────────────────────────────────────────────┤
│  1. Detectar cambios en configs/scripts                     │
│  2. Seleccionar suite de tests apropiada                    │
│  3. Ejecutar tests en paralelo                              │
│  4. Recolectar resultados                                   │
│  5. Análisis con LLM-as-judge (si aplica)                  │
│  6. Reporte y alertas                                       │
│  7. Auto-healing si es posible                              │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   ┌─────────┐          ┌─────────┐          ┌─────────┐
   │  BATS   │          │  pytest │          │  go test│
   │ Bash    │          │ Python  │          │   Go    │
   └─────────┘          └─────────┘          └─────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              ▼
                    ┌─────────────────┐
                    │  Test Reports  │
                    │  + Metrics     │
                    └─────────────────┘
```

---

## Testing por Tecnología

### 1. Scripts Bash (Hypr, Eww, Scripts)

**Framework:** BATS-Core + bats-assert + bats-support

**Instalación:**
```bash
# Opción 1: Package manager
sudo apt install bats          # Debian/Ubuntu
brew install bats-core         # macOS

# Opción 2: Git submodule (recomendado para el repo)
git submodule add https://github.com/bats-core/bats-core tests/bats/lib/bats
git submodule add https://github.com/bats-core/bats-assert tests/bats/lib/bats-assert
git submodule add https://github.com/bats-core/bats-support tests/bats/lib/bats-support
```

**Estructura de Test:**
```bash
#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "script exists and is executable" {
    assert [ -x "./scripts/wallpaper_v2.sh" ]
}

@test "script runs without errors" {
    run ./scripts/wallpaper_v2.sh
    assert_success
}

@test "script outputs expected format" {
    run ./scripts/wallpaper_v2.sh
    assert_output --partial "swww"
}
```

**Scripts a Testear:**

| Script | Tipo de Test | Prioridad |
|--------|-------------|-----------|
| `hypr/scripts/wallpaper_v2.sh` | Integration | Alta |
| `hypr/scripts/discord.sh` | Unit | Alta |
| `hypr/scripts/brave.sh` | Unit | Alta |
| `hypr/scripts/steam.sh` | Unit | Alta |
| `hypr/scripts/obs-recording.sh` | Integration | Media |
| `eww/scripts/notes.sh` | Integration | Alta |
| `eww/scripts/football.py` | Unit | Media |
| `eww/scripts/gcal.py` | Integration | Alta |
| `scripts/agentize.sh` | Integration | Alta |

**Comandos de Ejecución:**
```bash
# Ejecutar todos los tests BATS
./tests/bats/bin/bats tests/bats/

# Ejecutar tests específicos
./tests/bats/bin/bats tests/bats/hypr/

# Verbose output
./tests/bats/bin/bats tests/bats/ -v
```

### 2. Scripts Python (Eww Widgets)

**Framework:** pytest + pytest-cov + pytest-mock

**Instalación:**
```bash
pip install pytest pytest-cov pytest-mock requests-mock
```

**Estructura de Test:**
```python
# tests/pytest/eww/test_football.py
import pytest
from unittest.mock import patch, MagicMock

# Funciones a testear
from scripts.football import fetch_matches, parse_league

class TestFootball:
    @pytest.fixture
    def sample_html(self):
        return """<html>...mock html...</html>"""

    def test_fetch_matches_success(self, sample_html):
        with patch('requests.get') as mock_get:
            mock_get.return_value.text = sample_html
            result = fetch_matches()
            assert len(result) > 0

    def test_fetch_matches_network_error(self):
        with patch('requests.get') as mock_get:
            mock_get.side_effect = ConnectionError("Network unavailable")
            with pytest.raises(ConnectionError):
                fetch_matches()

    @pytest.mark.parametrize("input_str,expected", [
        ("Liga Profesional", "liga_profesional"),
        ("Primera Nacional", "primera_nacional"),
        ("Copa Argentina", "copa_argentina"),
    ])
    def test_parse_league(self, input_str, expected):
        assert parse_league(input_str) == expected
```

**Scripts a Testear:**

| Script | Tipo de Test | Prioridad |
|--------|-------------|-----------|
| `eww/scripts/football.py` | Unit + Integration | Alta |
| `eww/scripts/gcal.py` | Integration | Alta |
| `eww/scripts/note_write.py` | Unit | Alta |
| `eww/scripts/gcal_auth.py` | Unit | Media |

**Comandos de Ejecución:**
```bash
# Ejecutar todos los tests
pytest tests/pytest/

# Con coverage
pytest tests/pytest/ --cov=scripts --cov-report=html

# Tests específicos
pytest tests/pytest/eww/test_football.py -v

# Tests parametrizados
pytest tests/pytest/ -k "test_parse"
```

### 3. Go (Engram)

**Framework:** Native `testing` package con table-driven tests

**Estructura de Test:**
```go
// internal/memory/memory_test.go
package memory

func TestSave(t *testing.T) {
    tests := map[string]struct {
        input    Observation
        expected error
    }{
        "valid observation": {
            input: Observation{
                Title: "Test memory",
                Type:  "decision",
            },
            expected: nil,
        },
        "empty title": {
            input:    Observation{Type: "decision"},
            expected: ErrEmptyTitle,
        },
    }

    for name, tc := range tests {
        t.Run(name, func(t *testing.T) {
            err := Save(tc.input)
            if err != tc.expected {
                t.Errorf("Save() error = %v, want %v", err, tc.expected)
            }
        })
    }
}
```

**Comandos de Ejecución:**
```bash
# Todos los tests
go test ./...

# Con coverage
go test -coverprofile=coverage.out ./...

# Verbose
go test -v ./...

# Race conditions
go test -race ./...
```

### 4. Configuraciones (Hyprland, Waybar, Eww)

**Tests de Sintaxis:**

```bash
# Hyprland
hyprctl version
hyprctl parse config ~/.config/hypr/hyprland.conf

# Waybar
waybar --validate

# Eww
eww --help | grep validate || eww daemon && eww reload
```

**Tests de Integración:**

```bash
#!/usr/bin/env bats
# tests/bats/config/hypr_config.bats

@test "hyprland config is valid" {
    run hyprctl parse ~/.config/hypr/hyprland.conf
    assert_success
}

@test "keybinds are defined" {
    run hyprctl keyword "bind"
    assert_output --partial "SUPER"
}

@test "waybar config is valid JSON" {
    run python3 -c "import json; json.load(open('$HOME/.config/waybar/config.jsonc'))"
    assert_success
}
```

---

## Agentización de Pruebas

### Concepto

"Agentizar" las pruebas significa crear un sistema donde agentes de IA:
1. Detectan cambios en el código/configs
2. Seleccionan y ejecutan pruebas relevantes
3. Analizan resultados con LLM-as-judge
4. Generan reportes y alertas
5. Intentan auto-healing cuando es posible

### Implementación

#### 1. Test Runner Agent

```bash
#!/bin/bash
# scripts/test-runner.sh - Agentic test runner

set -euo pipefail

REPO="${REPO:-$HOME/Documentos/dotfiles}"
LOG_DIR="/tmp/sano-dots-test-logs"
mkdir -p "$LOG_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[TEST]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
err() { echo -e "${RED}[ERROR]${NC} $1"; }

run_bats() {
    local target="${1:-tests/bats}"
    log "Running BATS tests: $target"
    ./tests/bats/bin/bats "$target" 2>&1 | tee "$LOG_DIR/bats-$(date +%s).log"
}

run_pytest() {
    local target="${1:-tests/pytest}"
    log "Running pytest: $target"
    pytest "$target" -v --tb=short 2>&1 | tee "$LOG_DIR/pytest-$(date +%s).log"
}

run_config_tests() {
    log "Running config validation tests"
    # Hyprland
    hyprctl parse ~/.config/hypr/hyprland.conf > "$LOG_DIR/hypr-validate.log" 2>&1 || warn "Hyprland config has issues"
    # Waybar
    waybar --validate > "$LOG_DIR/waybar-validate.log" 2>&1 || warn "Waybar config has issues"
}

main() {
    local mode="${1:-all}"

    case "$mode" in
        bats)
            run_bats "${2:-tests/bats}"
            ;;
        pytest)
            run_pytest "${2:-tests/pytest}"
            ;;
        config)
            run_config_tests
            ;;
        all)
            run_config_tests
            run_bats
            run_pytest
            ;;
        ci)
            # CI mode - fail fast
            set -e
            run_config_tests
            run_bats tests/bats/
            run_pytest tests/pytest/
            ;;
        *)
            echo "Usage: $0 {bats|pytest|config|all|ci} [target]"
            exit 1
            ;;
    esac
}

main "$@"
```

#### 2. GitHub Actions Workflow

```yaml
# .github/workflows/test-all.yml
name: Test All Components

on:
  push:
    branches: [main, yoda]
  pull_request:
    branches: [main, yoda]
  schedule:
    - cron: '0 6 * * *'  # Daily at 6am

jobs:
  test-bats:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install BATS
        run: sudo apt-get install -y bats
      - name: Run BATS tests
        run: ./tests/bats/bin/bats tests/bats/ || true

  test-pytest:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install pytest pytest-cov
      - name: Run pytest
        run: pytest tests/pytest/ -v

  test-configs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate Hyprland
        run: hyprctl parse ~/.config/hypr/hyprland.conf || true

  test-go:
    runs-on: ubuntu-latest
    if: github.repository == 'Gentleman-Programming/engram'
    steps:
      - uses: actions/checkout@v4
      - name: Setup Go
        uses: actions/setup-go@v5
      - name: Run Go tests
        run: go test ./...
```

#### 3. LLM-as-Judge para Análisis de Resultados

```python
# scripts/agents/test_analyzer.py
"""
Agente que analiza resultados de tests usando LLM
"""

import subprocess
import json
from openai import OpenAI

client = OpenAI()

def analyze_test_failure(test_output: str, test_name: str) -> dict:
    """Usa LLM para analizar por qué falló un test"""
    prompt = f"""Analiza el siguiente output de test fallido para el test: {test_name}

Output:
```
{test_output}
```

Proporciona:
1. Causa raíz probable del fallo
2. Sugerencia de cómo arreglarlo
3. Prioridad del fix (alta/media/baja)

Responde en formato JSON:
{{
    "root_cause": "...",
    "suggestion": "...",
    "priority": "alta|media|baja"
}}
"""

    response = client.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )

    return json.loads(response.choices[0].message.content)
```

---

## Plan de Implementación

### Fase 1: Infraestructura (Semana 1)

- [ ] Crear estructura de directorios `tests/`
- [ ] Agregar BATS como submodule
- [ ] Crear config de pytest
- [ ] Crear test-runner.sh básico

### Fase 2: Tests Básicos (Semana 2)

- [ ] Tests de sintaxis para configs principales
- [ ] Tests BATS para scripts críticos (discord.sh, brave.sh, steam.sh)
- [ ] Tests pytest para football.py y gcal.py

### Fase 3: Cobertura Completa (Semana 3)

- [ ] Tests para todos los scripts EWW
- [ ] Tests para scripts Hypr
- [ ] Coverage report setup

### Fase 4: Agentización (Semana 4)

- [ ] GitHub Actions workflow
- [ ] LLM-as-judge analyzer
- [ ] Dashboard de resultados

### Fase 5: Mantenimiento Continuo

- [ ] Agregar tests para nuevos scripts
- [ ] Actualizar casos de prueba
- [ ] Revisar y mejorar覆盖率

---

## Ejecución y Mantenimiento

### Comandos de Uso Diario

```bash
# Ejecutar todos los tests
./scripts/test-runner.sh all

# Solo tests de configuración
./scripts/test-runner.sh config

# Modo CI (fallo rápido)
./scripts/test-runner.sh ci

# Tests específicos
./scripts/test-runner.sh bats tests/bats/hypr/
./scripts/test-runner.sh pytest tests/pytest/eww/
```

### Métricas a Monitorear

| Métrica | Objetivo |
|---------|----------|
| Coverage Bash | > 70% |
| Coverage Python | > 80% |
| Coverage Go (Engram) | > 85% |
| Tiempo de ejecución | < 5 min |
| Flaky tests | 0% |

### Integración con Engram

Para proyectos Engram, crear memoria de los resultados:

```bash
# Después de ejecutar tests
engram save "Test run $(date +%Y-%m-%d)" \
  "BATS: $bats_pass/$bats_total passed\npytest: $pytest_pass/$pytest_total passed" \
  --type "learning" --project "sano-dots"
```

---

## Referencias y Recursos 2026

### Testing Framework Updates 2026

- **BATS-Core v1.11+**: Mejor soporte para CI/CD, parallel execution mejorada
- **Pytest 8.x**: Nuevos features de asyncio testing, mejor coverage reporting
- **Go 1.26+**: Native fuzzing integrado, mejores benchmark tools
- **DeepEval**: Open source LLM testing framework gaining traction in 2026
- **Confident AI**: Platform para CI/CD integrated LLM evaluation

### Agentic Testing 2026

- **Autonomous Testing**: AI agents que determinan qué testear, generan tests, ejecutan y analizan resultados
- **Self-Healing Tests**: AI que repara broken tests automáticamente
- **LLM-as-Judge**: Usar LLMs para evaluar outputs complejos con semantic similarity
- **Shift-left + Shift-right**: Testing distribuido entre development y production

### Latest Trends (Q1-Q2 2026)

| Trend | Descripción | Aplicación |
|-------|-------------|------------|
| Agentic QA | AI agents como QA team completo | Test generation + execution + analysis |
| Quality Engineering | De QA manual a risk-based testing | Prioritization automatizada |
| LLM Observability | Tracing de todo el AI pipeline | Debugging de complejos workflows |
| Production-to-Eval Pipeline | Metrics de producción → test datasets | Continuous improvement |

### Tools Recomendados 2026

- **Test Generation**: Baserock.ai, testRigor, Mabl
- **LLM Evaluation**: DeepEval, Confident AI, LangSmith
- **Observability**: W&B Weave, Langfuse, Helicone
- **CI/CD Integration**: GitHub Actions con AI test runners

---

**Documento creado:** 2026-05-11
**Última actualización:** 2026-05-11
**Estado:** En desarrollo