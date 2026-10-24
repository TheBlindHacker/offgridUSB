"""Controlled Asset Provisioning & Manifest Verification CLI."""

from typing import Any

__all__ = ["load_manifests", "verify_assets"]


def __getattr__(name: str) -> Any:
    if name in __all__:
        from emyrge.assets import fetch_assets
        return getattr(fetch_assets, name)
    raise AttributeError(f"module 'emyrge.assets' has no attribute {name!r}")
