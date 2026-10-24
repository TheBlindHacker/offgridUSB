# `data/zim/` — Internet-in-a-Box OpenZIM Archives

Drop **any** valid `.zim` encyclopedia from **[library.kiwix.org](https://library.kiwix.org/)** or **[download.kiwix.org/zim/](https://download.kiwix.org/zim/)** into this folder!

On startup (and dynamically at runtime), `KiwixRunner` verifies the `ZIM\x04` magic bytes (`0x5A 0x49 0x4D 0x04`), mounts every `.zim` file on **`http://127.0.0.1:8081`**, and feeds live passages directly into OffGridUSB's Grounded AI Professor RAG pipeline.

### Default Tier 0 Packs Provisioned Automatically
- `zimgit-water_en_2024-08.zim` (~20 MB — Safe Water & Sanitation)
- `zimgit-medicine_en_2024-08.zim` (~67 MB — Austere Field Medicine)
- `wikipedia_en_medicine_mini_2026-10.zim` (~166 MB — Wikipedia Medicine Mini)

*(Remember to format your USB drive as **`exFAT`** before adding >4 GB archives such as `khanacademy_en_all` or `wikipedia_en_all`!)*

*OffGridUSB Team — `@TheBlindHacker` • `@johndikeman` • `@organized-nick`*
