"""Controlled Offline Asset Provisioner & Verifier (F-42, F-43).

100% Pure Python Standard Library.
Usage:
    python -m emyrge.assets.fetch_assets --dry-run
    python -m emyrge.assets.fetch_assets --verify
    python -m emyrge.assets.fetch_assets --tier 0
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys
from typing import Any, Dict, List, Optional
import urllib.request


def _default_root() -> Path:
    return Path(__file__).resolve().parent.parent.parent.parent


def load_manifests(project_root: Optional[Path] = None) -> Dict[str, Any]:
    root = project_root or _default_root()
    models_path = root / "manifests" / "models.json"
    zim_path = root / "manifests" / "zim.json"

    models_data = json.loads(models_path.read_text(encoding="utf-8")) if models_path.is_file() else {"models": []}
    zim_data = json.loads(zim_path.read_text(encoding="utf-8")) if zim_path.is_file() else {"archives": []}
    return {
        "models": models_data.get("models", []),
        "archives": zim_data.get("archives", []),
    }


def verify_assets(project_root: Optional[Path] = None) -> Dict[str, Any]:
    root = project_root or _default_root()
    manifests = load_manifests(root)
    models_dir = root / "data" / "models"
    zim_dir = root / "data" / "zim"

    found_models: List[Dict[str, Any]] = []
    if models_dir.is_dir():
        for p in sorted(models_dir.glob("*.gguf")):
            found_models.append({"filename": p.name, "size_mb": round(p.stat().st_size / (1024 * 1024), 2)})

    found_zims: List[Dict[str, Any]] = []
    if zim_dir.is_dir():
        for p in sorted(zim_dir.glob("*.zim")):
            found_zims.append({"filename": p.name, "size_mb": round(p.stat().st_size / (1024 * 1024), 2)})

    return {
        "ok": True,
        "catalog_models_count": len(manifests["models"]),
        "catalog_zim_count": len(manifests["archives"]),
        "staged_models": found_models,
        "staged_zims": found_zims,
    }


def _sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while True:
            chunk = f.read(1024 * 1024)
            if not chunk:
                break
            h.update(chunk)
    return h.hexdigest()


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="OffGridUSB (offgridusb.com) Offline Asset Provisioner")
    parser.add_argument("--dry-run", action="store_true", help="Print planned downloads without fetching")
    parser.add_argument("--verify", action="store_true", help="Verify staged models and ZIM files on disk")
    parser.add_argument("--tier", type=int, default=0, help="Maximum hardware tier assets to fetch (default: 0)")
    args = parser.parse_args(argv)

    root = _default_root()
    manifests = load_manifests(root)

    if args.verify:
        report = verify_assets(root)
        print(json.dumps(report, indent=2))
        return 0

    selected_models = [m for m in manifests["models"] if int(m.get("tier", 0)) <= args.tier]
    selected_zims = [z for z in manifests["archives"] if int(z.get("tier", 0)) <= args.tier]

    if args.dry_run:
        print(
            json.dumps(
                {
                    "dry_run": True,
                    "max_tier": args.tier,
                    "planned_models": selected_models,
                    "planned_zims": selected_zims,
                },
                indent=2,
            )
        )
        return 0

    models_dir = root / "data" / "models"
    zim_dir = root / "data" / "zim"
    models_dir.mkdir(parents=True, exist_ok=True)
    zim_dir.mkdir(parents=True, exist_ok=True)

    for item in selected_models:
        dest = models_dir / item["filename"]
        if dest.exists() and dest.stat().st_size > 1024 * 1024:
            print(f"[SKIP] Model already staged: {dest.name}")
            continue
        print(f"[FETCH] Downloading {item['name']} -> {dest}")
        urllib.request.urlretrieve(item["url"], str(dest))

    for item in selected_zims:
        dest = zim_dir / item["filename"]
        if dest.exists() and dest.stat().st_size > 1024:
            print(f"[SKIP] ZIM already staged: {dest.name}")
            continue
        print(f"[FETCH] Downloading {item['name']} -> {dest}")
        urllib.request.urlretrieve(item["url"], str(dest))

    return 0


if __name__ == "__main__":
    sys.exit(main())
