# `data/` — Air-Gapped Knowledge, AI Weights & Self-Improving Memory Vault

All offline encyclopedias, quantized neural weights, persistent SQLite field memory, and OCR-indexed field photos live inside `data/` directly on the **OffGridUSB (`offgridusb.com`)** flash drive:

```text
data/
├── zim/      # Drop-in *.zim OpenZIM encyclopedias (served live on :8081 + RAG-indexed)
├── models/   # Drop-in *.gguf quantized local AI models (0.13B -> 70B)
├── vault/    # Persistent SQLite FTS5 ledger + "Distillation-on-Dock" Master Notes
└── uploads/  # Field photos indexed by offline binary EXIF/GPS + Stage-1 OCR
```

## Populating `data/`

- **Windows:** Double-click **`DOWNLOAD_INTERNET_IN_A_BOX.bat`** (or `.\scripts\download_internet_in_a_box.ps1 -Tier 0 -NonInteractive`)
- **Linux / Raspberry Pi / macOS:** `./scripts/download_internet_in_a_box.sh --tier 0`
- **Pure Python CLI:** `PYTHONPATH=src python3 -m emyrge.assets.fetch_assets --tier 0`

---
*Signed — `@TheBlindHacker` • `@johndikeman` • `@organized-nick` • The OffGridUSB Team (`offgridusb.com`)*
