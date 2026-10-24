# `data/models/` — Elastic GGUF Local AI Weights

Place quantized `.gguf` instruction-tuned models from Hugging Face (or run `DOWNLOAD_INTERNET_IN_A_BOX.bat` / `./scripts/download_internet_in_a_box.sh`) in this directory.

`ModelRunner` verifies the `GGUF` magic header (`0x47 0x47 0x55 0x46`) and automatically pairs the active model with your host's probed CPU vector flags (`SSE4.2`, `AVX2`, `AVX-512`, `ARM NEON`) and available RAM/VRAM:

- **Tier 0 Default (`<= 500 MB`):** `qwen2.5-0.5b-instruct-q4_k_m.gguf`
- **Tier 1 (`4 GB` Legacy PC / Pi 4–5):** `qwen2.5-1.5b-instruct-q4_k_m.gguf`
- **Tier 2 (`8–16 GB` Laptop):** `llama-3.2-3b-instruct-q4_k_m.gguf`
- **Tier 3 (`24–36 GB` Exo/RPC Swarm):** `qwen2.5-32b-instruct-q4_k_m.gguf`
- **Tier 4 (`64 GB+` Workstation / Dock Teacher):** `llama-3.3-70b-instruct-q4_k_m.gguf`

*OffGridUSB Team — `@TheBlindHacker` • `@johndikeman` • `@organized-nick`*
