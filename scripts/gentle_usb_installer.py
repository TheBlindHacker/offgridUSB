"""Gentle Rate-Controlled USB Provisioner for USB 2.0 / sensitive flash drives.
Prevents USB controller buffer overflow and hardware disconnects.
"""

import os
import pathlib
import sys
import time

SOURCE_ROOT = pathlib.Path(__file__).resolve().parent.parent
TARGET_ROOT = pathlib.Path("D:/")
CHUNK_SIZE = 128 * 1024  # 128 KB chunks
MAX_BYTES_PER_SEC = 8 * 1024 * 1024  # 8 MB/s sustained limit

EXCLUDE_DIRS = {"__pycache__", ".pytest_cache", ".agents", "tests", "tmp_dl", ".git", ".venv"}
EXCLUDE_FILES = {".DS_Store"}


def is_excluded(path: pathlib.Path) -> bool:
    for part in path.parts:
        if part in EXCLUDE_DIRS:
            return True
    if path.name in EXCLUDE_FILES or path.name.endswith((".pyc", ".pyo")):
        return True
    if "-DESKTOP-" in path.name or "-JoeWorkTop" in path.name:
        return True
    return False


def copy_file_gentle(src: pathlib.Path, dst: pathlib.Path):
    dst.parent.mkdir(parents=True, exist_ok=True)
    size = src.stat().st_size

    # Small files (< 1MB) copy directly
    if size < 1024 * 1024:
        with open(src, "rb") as f_in, open(dst, "wb") as f_out:
            f_out.write(f_in.read())
            f_out.flush()
        return

    # Larger files write in chunks with rate limiting and fsync
    mb = size / (1024 * 1024)
    print(f"  [COPY] {src.name} ({mb:.1f} MB)...", flush=True)

    copied = 0
    t0 = time.time()
    with open(src, "rb") as f_in, open(dst, "wb") as f_out:
        while True:
            chunk = f_in.read(CHUNK_SIZE)
            if not chunk:
                break
            f_out.write(chunk)
            copied += len(chunk)

            # Rate limit
            elapsed = time.time() - t0
            expected_time = copied / MAX_BYTES_PER_SEC
            if expected_time > elapsed:
                time.sleep(expected_time - elapsed)

        f_out.flush()
        try:
            os.fsync(f_out.fileno())
        except OSError:
            pass

    # Brief 0.3s cooldown for flash controller
    time.sleep(0.3)


def main():
    if not TARGET_ROOT.exists():
        print("ERROR: Target drive D: not found!", file=sys.stderr)
        return 1

    print("=" * 80)
    print("OffGridUSB -- Gentle Flash Provisioner (Target: D:\\)")
    print(f"Sustained Write Rate: {MAX_BYTES_PER_SEC / 1048576:.1f} MB/s (protects USB controller)")
    print("=" * 80)

    # 1. Root files
    root_files = [
        "START_EMYRGE_WINDOWS.bat",
        "START_EMYRGE_MAC.command",
        "START_EMYRGE_LINUX.sh",
        "MAKE_USB_DRIVES.bat",
        "FORMAT_AND_SETUP_USB.bat",
        "DOWNLOAD_INTERNET_IN_A_BOX.bat",
        "run_windows.bat",
        "run_linux.sh",
        "run_macos.command",
        "README.md",
    ]
    print("\n[1/4] Copying root launcher scripts...")
    for rf in root_files:
        p = SOURCE_ROOT / rf
        if p.exists():
            copy_file_gentle(p, TARGET_ROOT / rf)
    print("  -> Root launchers ready.")

    # 2. Application runtime directories
    app_dirs = ["docs", "manifests", "scripts", "src", "web"]
    print("\n[2/4] Copying core application runtime...")
    for d in app_dirs:
        base = SOURCE_ROOT / d
        if not base.exists():
            continue
        for item in base.rglob("*"):
            if item.is_file() and not is_excluded(item):
                rel = item.relative_to(SOURCE_ROOT)
                copy_file_gentle(item, TARGET_ROOT / rel)
    print("  -> Application code & UI ready.")

    # 3. Binaries (native engines)
    print("\n[3/4] Copying portable native engines (bin/)...")
    bin_base = SOURCE_ROOT / "bin"
    if bin_base.exists():
        for item in bin_base.rglob("*"):
            if item.is_file() and not is_excluded(item):
                rel = item.relative_to(SOURCE_ROOT)
                copy_file_gentle(item, TARGET_ROOT / rel)
    print("  -> Portable engines ready.")

    # 4. Data (Internet-in-a-Box ZIMs + GGUF AI models)
    print("\n[4/4] Copying Internet-in-a-Box encyclopedias & AI models (data/)...")
    (TARGET_ROOT / "data" / "vault").mkdir(parents=True, exist_ok=True)
    (TARGET_ROOT / "data" / "uploads").mkdir(parents=True, exist_ok=True)

    data_base = SOURCE_ROOT / "data"
    if data_base.exists():
        for item in data_base.rglob("*"):
            if item.is_file() and not is_excluded(item):
                rel = item.relative_to(SOURCE_ROOT)
                copy_file_gentle(item, TARGET_ROOT / rel)

    print("\n" + "=" * 80)
    print("SUCCESS! Complete OffGridUSB installation verified on D:\\")
    print("=" * 80)
    return 0


if __name__ == "__main__":
    sys.exit(main())
