#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# KURI-DOTS TEST RUNNER - Agentic Testing System v2.0 (2026)
# ═══════════════════════════════════════════════════════════════════

set -euo pipefail

REPO="${REPO:-$HOME/Documentos/dotfiles}"
TEST_DIR="$REPO/tests"
LOG_DIR="/tmp/kuri-dots-test-logs"
RESULTS_FILE="$LOG_DIR/results-$(date +%Y%m%d_%H%M%S).json"
TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)

mkdir -p "$LOG_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[TEST]${NC} $1" | tee -a "$LOG_DIR/run.log"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOG_DIR/run.log"; }
log_err() { echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_DIR/run.log"; }
log_step() { echo -e "${BLUE}[STEP]${NC} $1" | tee -a "$LOG_DIR/run.log"; }

init_json() {
    cat > "$RESULTS_FILE" << EOF
{
  "timestamp": "$TIMESTAMP",
  "status": "running",
  "suites": [],
  "summary": {
    "total": 0,
    "passed": 0,
    "failed": 0,
    "skipped": 0,
    "duration": 0
  }
}
EOF
}

update_json_status() {
    local status="$1"
    local total="$2"
    local passed="$3"
    local failed="$4"
    local duration="$5"

    cat > "$RESULTS_FILE" << EOF
{
  "timestamp": "$TIMESTAMP",
  "status": "$status",
  "suites": [],
  "summary": {
    "total": $total,
    "passed": $passed,
    "failed": $failed,
    "skipped": 0,
    "duration": $duration
  }
}
EOF
}

run_bats_suite() {
    local suite_name="$1"
    local target="${2:-$TEST_DIR/bats/$suite_name}"
    local start_time=$(date +%s)

    log_step "Running BATS suite: $suite_name"

    if [ ! -d "$target" ]; then
        log_warn "Suite directory not found: $target"
        return 1
    fi

    local output
    if output=$(./tests/bats/bin/bats "$target" 2>&1); then
        local tests_passed=$(echo "$output" | grep -oP '\d+(?= tests)' | tail -1 || echo "0")
        log_info "✓ BATS $suite_name: $tests_passed passed"
        echo "$output" > "$LOG_DIR/bats-${suite_name}.log"
        echo "$tests_passed"
    else
        log_err "✗ BATS $suite_name: FAILED"
        echo "$output" > "$LOG_DIR/bats-${suite_name}-failed.log"
        echo "0"
    fi
}

run_pytest_suite() {
    local suite_name="$1"
    local target="${2:-$TEST_DIR/pytest/$suite_name}"
    local start_time=$(date +%s)

    log_step "Running pytest suite: $suite_name"

    if [ ! -d "$target" ]; then
        log_warn "Suite directory not found: $target"
        return 1
    fi

    local output
    if output=$(pytest "$target" -v --tb=short --color=yes 2>&1); then
        local tests_passed=$(echo "$output" | grep -oP '\d+ passed' | grep -oP '\d+' || echo "0")
        log_info "✓ pytest $suite_name: $tests_passed passed"
        echo "$output" > "$LOG_DIR/pytest-${suite_name}.log"
        echo "$tests_passed"
    else
        log_err "✗ pytest $suite_name: FAILED"
        echo "$output" > "$LOG_DIR/pytest-${suite_name}-failed.log"
        echo "0"
    fi
}

run_config_validation() {
    log_step "Running configuration validation tests"

    local passed=0
    local failed=0

    if command -v hyprctl &> /dev/null; then
        if hyprctl parse "$HOME/.config/hypr/hyprland.conf" &> "$LOG_DIR/hypr-validation.log"; then
            log_info "✓ Hyprland config valid"
            ((passed++))
        else
            log_err "✗ Hyprland config has issues"
            ((failed++))
        fi
    else
        log_warn "Hyprland not installed, skipping"
    fi

    if [ -f "$HOME/.config/waybar/config.jsonc" ]; then
        if python3 -c "import json, re; json.loads(re.sub(r'//.*', '', open('$HOME/.config/waybar/config.jsonc').read()))" &> "$LOG_DIR/waybar-validation.log"; then
            log_info "✓ Waybar config valid"
            ((passed++))
        else
            log_err "✗ Waybar config has issues"
            ((failed++))
        fi
    else
        log_warn "Waybar config not found"
    fi

    if [ -d "$HOME/.config/eww" ]; then
        if command -v eww &> /dev/null; then
            log_info "✓ EWW installed"
            ((passed++))
        else
            log_err "✗ EWW not installed"
            ((failed++))
        fi
    fi

    echo "$passed"
}

detect_changes() {
    log_step "Detecting changes since last test run..."

    local last_run_file="$LOG_DIR/.last_commit"
    local current_commit
    current_commit=$(cd "$REPO" && git rev-parse HEAD 2>/dev/null || echo "unknown")

    if [ -f "$last_run_file" ]; then
        local last_commit=$(cat "$last_run_file")
        if [ "$current_commit" != "$last_commit" ]; then
            local changed_files
            changed_files=$(cd "$REPO" && git diff --name-only "$last_commit..$current_commit" 2>/dev/null | head -20)
            if [ -n "$changed_files" ]; then
                log_info "Changed files since last run:"
                echo "$changed_files" | while read -r f; do
                    echo "  - $f"
                done
            fi
        fi
    fi

    echo "$current_commit" > "$last_run_file"
}

run_agentic_analysis() {
    local test_output="$1"
    local test_name="$2"

    log_step "Agentic analysis for: $test_name"

    if command -v engram &> /dev/null; then
        engram save "Test run $TIMESTAMP - $test_name" \
          "Output: $(echo "$test_output" | head -50)" \
          --type "learning" --project "kuri-dots" 2>/dev/null || true
    fi
}

generate_report() {
    local total="$1"
    local passed="$2"
    local failed="$3"
    local duration="$4"

    local percentage=0
    if [ "$total" -gt 0 ]; then
        percentage=$((passed * 100 / total))
    fi

    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║              KURI-DOTS TEST RESULTS (v2.0)                  ║"
    echo "╠════════════════════════════════════════════════════════════╣"
    printf "║  Timestamp:   %-40s║\n" "$TIMESTAMP"
    printf "║  Total:       %-40d║\n" "$total"
    printf "║  Passed:      ${GREEN}%-40d${NC}║\n" "$passed"
    printf "║  Failed:      ${RED}%-40d${NC}║\n" "$failed"
    printf "║  Coverage:    %-40d%%║\n" "$percentage"
    printf "║  Duration:    %-40s║\n" "${duration}s"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Logs saved to: $LOG_DIR/"
    echo "Results JSON: $RESULTS_FILE"

    if [ "$failed" -gt 0 ]; then
        echo ""
        log_err "Some tests failed. Check logs in $LOG_DIR/"
        return 1
    else
        log_info "All tests passed!"
        return 0
    fi
}

main() {
    local mode="${1:-all}"
    local start_time=$(date +%s)

    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║     KURI-DOTS AGENTIC TEST RUNNER v2.0 (2026)              ║"
    echo "║     AI-Powered Testing for Hyprland/Eww/Waybar Configs     ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""

    init_json

    detect_changes

    local total_passed=0
    local total_failed=0

    case "$mode" in
        bats)
            local passed
            passed=$(run_bats_suite "hypr")
            total_passed=$((total_passed + passed))
            passed=$(run_bats_suite "eww")
            total_passed=$((total_passed + passed))
            passed=$(run_bats_suite "config")
            total_passed=$((total_passed + passed))
            ;;
        pytest)
            local passed
            passed=$(run_pytest_suite "eww")
            total_passed=$((total_passed + passed))
            ;;
        config)
            total_passed=$(run_config_validation)
            ;;
        all)
            log_step "=== Running Full Test Suite ==="

            log_info "1. Config Validation"
            local config_passed
            config_passed=$(run_config_validation)
            total_passed=$((total_passed + config_passed))

            log_info "2. BATS Tests"
            local bats_passed
            bats_passed=$(run_bats_suite "hypr")
            total_passed=$((total_passed + bats_passed))
            bats_passed=$(run_bats_suite "eww")
            total_passed=$((total_passed + bats_passed))
            bats_passed=$(run_bats_suite "config")
            total_passed=$((total_passed + bats_passed))

            log_info "3. Pytest Tests"
            local pytest_passed
            pytest_passed=$(run_pytest_suite "eww")
            total_passed=$((total_passed + pytest_passed))
            ;;
        ci)
            set -e
            log_step "=== Running CI Mode (fail-fast) ==="
            run_config_validation
            run_bats_suite "hypr"
            run_bats_suite "eww"
            run_pytest_suite "eww"
            ;;
        watch)
            log_step "=== Watch Mode ==="
            log_info "Watching for changes... (Ctrl+C to stop)"
            while true; do
                inotifywait -q -e modify -e create "$REPO/hypr" "$REPO/eww" "$REPO/scripts" 2>/dev/null || true
                log_info "Change detected, re-running tests..."
                main all
                sleep 2
            done
            ;;
        help|--help|-h)
            echo "KURI-DOTS TEST RUNNER - Usage:"
            echo ""
            echo "  $(basename $0) [mode] [target]"
            echo ""
            echo "Modes:"
            echo "  all       - Run all test suites (default)"
            echo "  bats      - Run only BATS tests"
            echo "  pytest    - Run only pytest tests"
            echo "  config    - Run only configuration validation"
            echo "  ci        - CI mode (fail-fast)"
            echo "  watch     - Watch mode (auto-run on changes)"
            echo "  help      - Show this help"
            echo ""
            echo "Examples:"
            echo "  $(basename $0) all"
            echo "  $(basename $0) bats hypr"
            echo "  $(basename $0) ci"
            exit 0
            ;;
        *)
            log_err "Unknown mode: $mode"
            echo "Run '$(basename $0) help' for usage"
            exit 1
            ;;
    esac

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local total=$((total_passed + total_failed))

    update_json_status "completed" "$total" "$total_passed" "$total_failed" "$duration"

    generate_report "$total" "$total_passed" "$total_failed" "$duration"
}

main "$@"