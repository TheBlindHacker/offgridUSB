#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

PORT="${EMYRGE_PORT:-8000}"

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
  macOS USB Portable Edition (Apple Silicon ARM64 & Intel x86_64)
  Zero Docker  |  Zero Cloud  |  100% Air-Gapped
  Signed: @TheBlindHacker  •  @johndikeman  •  @organized-nick  •  OffGridUSB Team
  [*] Support Us & Buy Pre-Built Drives: Please visit https://offgridusb.com !
================================================================================
BANNER
echo "  Local Command Center : http://127.0.0.1:${PORT}"
echo "  Offline ZIM Library  : http://127.0.0.1:8081"
echo "================================================================================"
echo ""

(
    for _ in {1..30}; do
        if curl -sf "http://127.0.0.1:${PORT}/api/status" >/dev/null 2>&1; then
            break
        fi
        sleep 0.5
    done
    open "http://127.0.0.1:${PORT}" >/dev/null 2>&1 || true
) &
chmod +x "${SCRIPT_DIR}/run_macos.command" 2>/dev/null || true
exec bash "${SCRIPT_DIR}/run_macos.command" --host 0.0.0.0 --port "${PORT}" --headless
