#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

PORT="${EMYRGE_PORT:-8000}"
ARCH="$(uname -m)"

clear 2>/dev/null || true
echo "================================================================================"
echo "  OffGridUSB (offgridusb.com) // Universal Offline Knowledge & Adaptive AI Harness"
echo "  Linux & Raspberry Pi USB Portable Edition (${ARCH} — x86_64 & ARM64)"
echo "  Zero Docker  |  Zero Cloud  |  100% Air-Gapped"
echo "================================================================================"
echo "  Local Command Center : http://127.0.0.1:${PORT}"
echo "  Offline ZIM Library  : http://127.0.0.1:8081"
echo "================================================================================"
echo ""

(
    sleep 1.5
    if [[ -n "${DISPLAY:-}" || -n "${WAYLAND_DISPLAY:-}" ]]; then
        xdg-open "http://127.0.0.1:${PORT}" >/dev/null 2>&1 || sensible-browser "http://127.0.0.1:${PORT}" >/dev/null 2>&1 || true
    fi
) &

chmod +x "${SCRIPT_DIR}/run_linux.sh" 2>/dev/null || true
exec "${SCRIPT_DIR}/run_linux.sh" --host 0.0.0.0 --port "${PORT}" --headless
