# `data/uploads/` — Visual Field Vault Photo Store

Photos uploaded through **Tab 05 — Visual Field Vault** (`POST /api/vision/upload`) are content-addressed by SHA-256 hash (`<sha256_prefix>_<filename>`), stored in this folder, and indexed in SQLite with binary PNG/JPEG dimensions, camera EXIF/GPS coordinates, and offline Stage-1 OCR notes so every image remains keyword-searchable even on zero-GPU hardware.

*OffGridUSB Team — `@TheBlindHacker` • `@johndikeman` • `@organized-nick`*
