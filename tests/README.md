# Sano Dots Testing Suite

## Quick Start

```bash
cd ~/Documentos/dotfiles

# Run all tests
./scripts/test-runner.sh all

# Run specific suite
./scripts/test-runner.sh bats hypr
./scripts/test-runner.sh pytest eww

# CI mode (fail-fast)
./scripts/test-runner.sh ci
```

## Estructura

```
tests/
├── bats/              # Bash tests (BATS-Core)
│   ├── hypr/         # Hyprland scripts
│   ├── eww/          # Eww widgets
│   └── config/       # Config validation
├── pytest/           # Python tests
│   └── eww/          # Python widgets
└── pytest.ini        # Pytest config
```

## Requisitos

- **BATS**: `brew install bats-core` o `sudo apt install bats`
- **Pytest**: `pip install pytest pytest-cov pytest-mock`

## Integración con Engram

Guardar resultados de tests en memoria:

```bash
engram save "Test run $(date)" "Results: $passed/$total" --type learning
```