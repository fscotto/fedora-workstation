#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# --- Configurazione Logging Avanzato ---

LOG_FILE="./fedora-workstation.log"

# Livello di log: ERROR=0, WARN=1, INFO=2, DEBUG=3
LOG_LEVEL=2  # Default INFO

if [[ -n "${LOG_LEVEL_ENV-}" ]]; then
    LOG_LEVEL=$LOG_LEVEL_ENV
elif [[ -n "${LOG_LEVEL:-}" ]]; then
    LOG_LEVEL=$LOG_LEVEL
fi

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

_log() {
    local level=$1
    local color=$2
    local label=$3
    shift 3
    local message="$*"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    if (( level <= LOG_LEVEL )); then
        echo -e "${color}[${label}]${NC} ${timestamp} - ${message}"
    fi

    echo "[${label}] ${timestamp} - ${message}" >> "$LOG_FILE"
}

log_error() { _log 0 "$RED" "ERROR" "$@"; }
log_warn()  { _log 1 "$YELLOW" "WARN"  "$@"; }
log_info()  { _log 2 "$GREEN" "INFO"  "$@"; }
log_debug() { _log 3 "$CYAN" "DEBUG" "$@"; }

