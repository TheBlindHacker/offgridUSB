#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

PORT="${EMYRGE_PORT:-8000}"
ARCH="$(uname -m)"

clear 2>/dev/null || true
cat <<'BANNER'
================================================================================
    ____   __  __  _____      _     _ _    _  _____ ____      _______
   / __ \ / _|/ _|/ ____|    (_)   | | |  | |/ ____|  _ \    |  ___  |===+
  | |  | | |_| |_| |  __ _ __ _  __| | |  | | (___ | |_) |   | [AI+] |:::|
  | |  | |  _|  _| | |_ | '__| |/ _` | |  | |\___ \|  _ <    | [ZIM] |:::|
  | |__| | | | | | |__| | |  | | (_| | |__| |____) | |_) |   |_______|===+
   \____/|_| |_|  \_____|_|  |_|\__,_|\____/|_____/|____/   OFFGRIDUSB.COM
--------------------------------------------------------------------------------
  Signed: @TheBlindHacker  •  @johndikeman  •  @organized-nick  •  OffGridUSB Team
================================================================================
BANNER
echo "  Linux & Raspberry Pi USB Portable Edition (${ARCH} — x86_64 & ARM64)"
echo "  Local Command Center : http://127.0.0.1:${PORT}"
echo "  Offline ZIM Library  : http://127.0.0.1:8081"
echo "================================================================================"
echo ""

(
    for _ in $(seq 1 30); do
        if command -v curl >/dev/null 2>&1 && curl -sf "http://127.0.0.1:${PORT}/api/status" >/dev/null 2>&1; then
            break
        elif command -v python3 >/dev/null 2>&1 && python3 -c "import socket; s=socket.create_connection(('127.0.0.1', int('${PORT}')), 0.3); s.close()" >/dev/null 2>&1; then
            break
        fi
        sleep 0.5
    done
    if [[ -n "${DISPLAY:-}" || -n "${WAYLAND_DISPLAY:-}" ]]; then
        xdg-open "http://127.0.0.1:${PORT}" >/dev/null 2>&1 || sensible-browser "http://127.0.0.1:${PORT}" >/dev/null 2>&1 || true
    fi
) &

chmod +x "${SCRIPT_DIR}/run_linux.sh" 2>/dev/null || true
exec bash "${SCRIPT_DIR}/run_linux.sh" --host 0.0.0.0 --port "${PORT}" --headless
