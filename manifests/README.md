# `manifests/` — Declarative Knowledge & Model Catalogs

This folder defines the curated **OffGridUSB (`offgridusb.com`)** tier catalogs consumed by `emyrge.assets.fetch_assets` and the cross-platform build scripts (`scripts/download_internet_in_a_box.ps1` and `scripts/download_internet_in_a_box.sh`):

- **[`zim.json`](zim.json):** OpenZIM offline encyclopedia packs (`Tier 0` micro survival manuals up to `Tier 4` 110 GB Illustrated English Wikipedia).
- **[`models.json`](models.json):** Quantized `Q4_K_M` GGUF model ladder (`SmolLM2-135M` and `Qwen2.5-0.5B` up to `Qwen2.5-32B` Swarm and `Llama-3.3-70B` Settlement Hub).

## Adding a New Pack to the Catalog

Append an entry to `zim.json` (`archives[]`) or `models.json` (`models[]`) with:
```json
{
  "id": "ifixit-en",
  "name": "iFixit Complete Repair & Hardware Teardown Manual",
  "filename": "ifixit_en_all_2025-06.zim",
  "tier": 2,
  "category": "engineering_repair",
  "size_bytes": 3328599654,
  "size_mb": 3174.4,
  "url": "https://download.kiwix.org/zim/ifixit/ifixit_en_all_2025-06.zim"
}
```
Then verify with:
```bash
PYTHONPATH=src python3 -m emyrge.assets.fetch_assets --dry-run --tier 2
```

---
*Signed — `@TheBlindHacker` • `@johndikeman` • `@organized-nick` • The OffGridUSB Team (`offgridusb.com`)*
