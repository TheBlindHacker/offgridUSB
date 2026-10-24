#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

PORT="${EMYRGE_PORT:-8000}"

clear 2>/dev/null || true
echo "================================================================================"
echo "  OffGridUSB (offgridusb.com) // Universal Offline Knowledge & Adaptive AI Harness"
echo "  macOS USB Portable Edition (Apple Silicon ARM64 & Intel x86_64)"
echo "  Zero Docker  |  Zero Cloud  |  100% Air-Gapped"
echo "================================================================================"
echo "  Local Command Center : http://127.0.0.1:${PORT}"
echo "  Offline ZIM Library  : http://127.0.0.1:8081"
echo "================================================================================"
echo ""

(sleep 1.5 && open "http://127.0.0.1:${PORT}" >/dev/null 2>&1) &
chmod +x "${SCRIPT_DIR}/run_macos.command" 2>/dev/null || true
exec "${SCRIPT_DIR}/run_macos.command" --host 0.0.0.0 --port "${PORT}" --headless
