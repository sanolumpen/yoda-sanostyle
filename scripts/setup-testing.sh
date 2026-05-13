#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# Sano Dots Quick Setup - Install all testing dependencies
# ═══════════════════════════════════════════════════════════════════

set -e

REPO="$HOME/Documentos/dotfiles"
LOG="/tmp/sano-dots-setup.log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[SETUP]${NC} $1" | tee -a "$LOG"; }
step() { echo -e "${BLUE}[STEP]${NC} $1" | tee -a "$LOG"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOG"; }
err() { echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG"; }

echo "
╔════════════════════════════════════════════════════════════╗
║        KURI-DOTS TESTING SUITE - QUICK SETUP                ║
║              Agentic Testing v2.0 (2026)                   ║
╚════════════════════════════════════════════════════════════╝
"

# Check requirements
step "Checking requirements..."

# Check if running from correct directory
if [ ! -d "$REPO" ]; then
    err "Repository not found at $REPO"
    exit 1
fi

cd "$REPO"

# Install BATS
step "Installing BATS..."
if command -v bats &> /dev/null; then
    log "BATS already installed: $(bats --version)"
else
    if [ -f "/etc/debian_version" ]; then
        sudo apt update && sudo apt install -y bats
    elif [ -f "/etc/arch-release" ]; then
        sudo pacman -Sy --noconfirm bats
    elif command -v brew &> /dev/null; then
        brew install bats-core
    fi
fi

# Install Python dependencies
step "Installing Python dependencies..."
pip install pytest pytest-cov pytest-mock requests-mock 2>/dev/null || \
pip3 install pytest pytest-cov pytest-mock requests-mock 2>/dev/null || \
warn "Python pytest already installed"

# Make scripts executable
step "Making scripts executable..."
chmod +x scripts/test-runner.sh
chmod +x scripts/install-bats.sh

# Verify test files exist
step "Verifying test files..."
if [ -f "tests/bats/hypr/discord.bats" ]; then
    log "✓ BATS tests found"
fi

if [ -f "tests/pytest/eww/test_football.py" ]; then
    log "✓ pytest tests found"
fi

# Check GitHub Actions
step "Checking GitHub Actions..."
if [ -f ".github/workflows/test-all.yml" ]; then
    log "✓ GitHub Actions workflow found"
fi

# Summary
echo "
╔════════════════════════════════════════════════════════════╗
║                    SETUP COMPLETE                          ║
╠════════════════════════════════════════════════════════════╣
║  Run tests:                                                ║
║    ./scripts/test-runner.sh all       # All tests         ║
║    ./scripts/test-runner.sh bats       # BATS only         ║
║    ./scripts/test-runner.sh pytest     # Pytest only       ║
║    ./scripts/test-runner.sh ci         # CI mode           ║
║                                                             ║
║  Logs: $LOG                                  ║
╚════════════════════════════════════════════════════════════╝
"

log "Setup complete!"