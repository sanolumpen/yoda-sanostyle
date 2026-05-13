#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# BATS Installation Script - Sano Dots Testing Suite
# ═══════════════════════════════════════════════════════════════════

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[BATS-INSTALL]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
err() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

install_bats_debian() {
    log "Installing BATS on Debian/Ubuntu..."
    sudo apt update
    sudo apt install -y bats
    
    # Also install helper libraries
    if [ ! -d "$(pwd)/tests/bats/lib" ]; then
        mkdir -p tests/bats/lib
    fi
    
    # Clone BATS support libraries if needed
    if [ ! -f "tests/bats/lib/bats-support/load.bash" ]; then
        log "Installing BATS support libraries..."
        git clone --depth 1 https://github.com/bats-core/bats-support.git tests/bats/lib/bats-support 2>/dev/null || true
        git clone --depth 1 https://github.com/bats-core/bats-assert.git tests/bats/lib/bats-assert 2>/dev/null || true
    fi
}

install_bats_arch() {
    log "Installing BATS on Arch Linux..."
    sudo pacman -Sy --noconfirm bats
}

install_bats_macos() {
    log "Installing BATS on macOS..."
    if command -v brew &> /dev/null; then
        brew install bats-core
    else
        err "Homebrew not found. Install from: https://brew.sh"
        exit 1
    fi
}

install_bats_from_source() {
    log "Installing BATS from source..."
    local tmp_dir=$(mktemp -d)
    cd "$tmp_dir"
    git clone --depth 1 https://github.com/bats-core/bats-core.git
    cd bats-core
    ./install.sh /usr/local
    cd ~
    rm -rf "$tmp_dir"
}

main() {
    local os=$(detect_os)
    
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║         BATS Installation for Sano Dots                   ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    log "Detected OS: $os"
    echo ""
    
    case "$os" in
        debian|ubuntu|linuxmint)
            install_bats_debian
            ;;
        arch|manjaro|endeavouros)
            install_bats_arch
            ;;
        darwin|macos)
            install_bats_macos
            ;;
        *)
            warn "Unknown OS: $os, trying installation from source..."
            install_bats_from_source
            ;;
    esac
    
    # Verify installation
    echo ""
    if command -v bats &> /dev/null; then
        log "✓ BATS installed successfully: $(bats --version)"
    else
        err "BATS installation failed"
        exit 1
    fi
    
    # Install Python test dependencies
    echo ""
    log "Installing Python test dependencies..."
    pip install pytest pytest-cov pytest-mock --quiet 2>/dev/null || \
        pip3 install pytest pytest-cov pytest-mock --quiet 2>/dev/null || \
        warn "Python pytest installation failed (may already be installed)"
    
    echo ""
    log "✓ Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Run tests: ./scripts/test-runner.sh all"
    echo "  2. Run specific: ./scripts/test-runner.sh bats hypr"
    echo "  3. CI mode: ./scripts/test-runner.sh ci"
}

main "$@"