# OffGridUSB (offgridusb.com) // Universal Offline Knowledge & Adaptive AI Harness

**Zero-Install • Single-Click Portable USB • Zero Docker • Zero Cloud • 100% Air-Gapped**

**OffGridUSB** ([offgridusb.com](https://offgridusb.com)) turns any ordinary USB flash drive into an offline civilization, medical, engineering, and adaptive AI command center. Unlike existing offline servers that demand dedicated Linux machines and Docker installations, OffGridUSB boots with **one click** across **Windows, macOS, Linux, Raspberry Pi (ARM64), and locked Chromebooks**—dynamically scaling from a 512MB SBC or 10-year-old 4GB laptop up to a scavenged multi-laptop `exo`/RPC cluster or 70B multi-GPU workstation.

---

## 1-Click Quick Start (Plug In & Launch)

Turn **Wi-Fi OFF** if desired, open the USB drive (or project folder), and double-click the launcher for your device:

| Platform / Architecture | 1-Click Launcher | Fallback / CLI |
| :--- | :--- | :--- |
| **Windows 10/11 (x86_64 & ARM64)** | Double-click **`START_EMYRGE_WINDOWS.bat`** | `run_windows.bat --port 8000` |
| **macOS (Apple Silicon M1–M4 & Intel)** | Double-click **`START_EMYRGE_MAC.command`** | `./run_macos.command --port 8000` |
| **Linux & Raspberry Pi (x86_64 & ARM64)** | Run **`./START_EMYRGE_LINUX.sh`** | `./run_linux.sh --port 8000` |
| **Locked Chromebook / Tablet (No Exec)** | Open **`web/static/wasm/chromebook.html`** in Chrome | Pure-Browser WebAssembly Mode |

Your browser opens automatically at **`http://127.0.0.1:8000`** (with the bundled Kiwix offline ZIM library live on **`http://127.0.0.1:8081`**).

---

## Cloning Multiple Pitch / Field USB Flash Drives (`< 45 Seconds`)

Need to make 2, 3, or 10 identical ready-to-run OffGridUSB flash drives?
1. Plug in a USB stick and double-click **`MAKE_USB_DRIVES.bat`** (runs `scripts/clone_to_usb.ps1`).
2. Select your USB drive letter (`C:` is hard-blocked for safety).
3. Multi-threaded `robocopy /MT:16` copies all portable binaries, offline `.zim` encyclopedias, `.gguf` AI weights, and multi-OS launchers—then prompts you to swap in the next flash drive!

---

## Why OffGridUSB Beats Project N.O.M.A.D. & Off-Grid AI

| Capability | Project N.O.M.A.D. | Off-Grid AI | **OffGridUSB (`offgridusb.com`)** |
| :--- | :--- | :--- | :--- |
| **Installation** | Linux + Docker Compose required | Per-device app install | **1-Click Zero-Install off USB (+ Wasm Browser Mode)** |
| **Hardware Elasticity** | Fails on old 4GB / non-AVX2 PCs | Static local LLM | **Probes SSE4/AVX2/AVX-512/ARM/VRAM (Tier -1 to Tier 4)** |
| **Knowledge Grounding** | Siloed Kiwix & Ollama tabs | Static survival PDFs | **Unified RAG over ZIM Encyclopedias + Khan Academy** |
| **Life-Safety Math** | Raw LLM (prone to hallucination) | Raw LLM | **Deterministic CDC/WHO/IEEE Calculators + 2-Pass Audit** |
| **Self-Improving USB** | Stateless | Basic chat log | **SQLite FTS5 Vault + "Distillation-on-Dock" Upgrades** |
| **Scavenged Swarm** | Single-node only | Single-device only | **Pools mismatched laptops via `exo` & `llama.cpp` RPC** |

---

## Core Subsystems Included

1. **AI Professor Harness (Grounded RAG + 2-Pass Numerical Audit):** Synthesizes answers across offline ZIM encyclopedias, Khan Academy lessons, and Verified Master Notes with clickable `[Source: ...]` and `[Lesson: ...]` citations, backed by an automated numerical claim auditor.
2. **Internet-in-a-Box (Kiwix ZIM + Khan Academy Tutor):** Embedded `kiwix-serve` library hosting real offline medical, water purification, and Wikipedia Medicine `.zim` archives alongside interactive STEM lessons and graded exercises.
3. **Zero-Hallucination Survival Calculators:** Deterministic Python engines for **CDC/WHO Water Disinfection**, **IEEE 1562 Solar & LiFePO4 Sizing**, **WHO Oral Rehydration & Pediatric/Adult Dosing**, and **NEC DC Voltage Drop & Ohm's Law**.
4. **Self-Improving Memory & Distillation-on-Dock:** Portable SQLite FTS5 knowledge vault that flags uncertain low-tier field queries and automatically upgrades them into permanent **Verified Master Field Notes** whenever the USB docks with a higher-tier machine.
5. **Visual Field Vault:** Offline EXIF/GPS extraction and OCR indexing so pill labels, schematics, and equipment plates remain keyword-searchable on any hardware.
6. **Exo / RPC Scavenged Supercomputer Swarm:** Pools RAM across heterogeneous LAN laptops/SBCs with fault-tolerant local fallback if any node drops.

See **[`docs/PRD_ARD.md`](docs/PRD_ARD.md)** for complete product & architecture specifications.
