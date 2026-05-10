# RPOW CLI Miner — OpenClaw Skill

Skill **OpenClaw / AgentSkills-compatible** untuk setup, operasi, dan optimasi mining **RPOW2** menggunakan CLI miner unofficial.

Skill ini mengubah agent OpenClaw Anda menjadi spesialis yang:

- Menginstall dan build RPOW CLI miner (CPU native / GPU / Node fallback)
- Menjalankan login flow (magic link) dan manajemen sesi
- Mining RPOW token dengan optimasi performa
- Mengirim RPOW ke akun lain
- Monitoring saldo, aktivitas, dan statistik ledger
- Troubleshoot error mining, koneksi, dan build
- Manajemen multi-akun via state file terpisah

## Referensi Sumber

Skill ini berdasarkan repo asli: [stablemarkk/rpow_cli_miner](https://github.com/stablemarkk/rpow_cli_miner)

## Persyaratan

- [OpenClaw](https://openclaw.ai) terinstall (`npm install -g openclaw@latest`)
- Node.js 18+ (rekomendasi: Node 22+)
- C compiler (`gcc` / `cc`) untuk build native miner (opsional, tapi sangat direkomendasikan)
- GPU driver dengan OpenCL support (opsional, untuk GPU mining)

## Cara install

### Opsi 1 — Install ke shared skills folder (rekomendasi, semua agent bisa pakai)

```bash
git clone https://github.com/buffmaxx65/rpow-cli-miner-skill \
  ~/.openclaw/skills/rpow-cli-miner
```

### Opsi 2 — Install ke per-profil agent skills

```bash
git clone https://github.com/buffmaxx65/rpow-cli-miner-skill \
  ~/.agents/skills/rpow-cli-miner
```

### Opsi 3 — One-liner install script

```bash
curl -fsSL https://raw.githubusercontent.com/buffmaxx65/rpow-cli-miner-skill/main/install.sh | bash
```

> Script ini akan clone repo ke `~/.openclaw/skills/rpow-cli-miner`. Periksa isi `install.sh` sebelum dieksekusi.

## Cara mengaktifkan

Setelah install, restart gateway OpenClaw atau mulai sesi baru:

```bash
# Restart gateway
openclaw gateway restart

# Atau dari chat
/new
```

Verifikasi skill ter-load:

```bash
openclaw skills list | grep rpow-cli-miner
```

## Cara pakai

Cukup chat dengan agent OpenClaw, contoh:

```
Setup RPOW CLI miner di laptop saya
```

```
Login ke akun RPOW saya pakai email user@example.com
```

```
Mine 100 RPOW token pakai native CPU miner
```

```
Kirim 5 RPOW ke friend@example.com
```

```
Cek saldo dan statistik ledger RPOW
```

```
Build GPU miner dan mine dengan GPU
```

```
Troubleshoot kenapa mining saya lambat
```

Skill akan otomatis aktif karena trigger kontekstual yang tertulis di `SKILL.md`.

## Fitur utama

### 3 Engine Mining

| Engine | Kecepatan | Syarat |
| --- | --- | --- |
| `native` (CPU) | Cepat (MH/s) | C compiler |
| `gpu` (OpenCL) | Tercepat | GPU + OpenCL driver |
| `node` (fallback) | Lambat | Hanya Node.js |

### Multi-Akun

Gunakan `--state` berbeda untuk setiap akun — skill akan memandu setup multi-akun dengan benar.

### Auto-Recovery

Mining progress disimpan di state file. Jika crash, mining dilanjutkan dari posisi terakhir.

### Retry & Backoff

Auto-retry untuk error transient (timeout, rate limit, server error) dengan exponential backoff.

## Update skill

```bash
cd ~/.openclaw/skills/rpow-cli-miner
git pull
openclaw gateway restart
```

## Uninstall

```bash
rm -rf ~/.openclaw/skills/rpow-cli-miner
openclaw gateway restart
```

## Struktur repo

```
rpow-cli-miner-skill/
├── SKILL.md            # File utama (frontmatter + instruksi agent)
├── README.md           # Dokumentasi (file ini)
├── LICENSE             # MIT
├── install.sh          # One-liner install script
└── examples/
    ├── output-sample.md    # Contoh output skill
    └── prompts.md          # Contoh prompt yang men-trigger skill
```

## Keamanan

- CLI hanya mengakses host resmi RPOW2 (allowlist)
- State file berisi cookies — **jangan pernah commit ke git**
- Ini adalah tool **unofficial** — bukan produk resmi RPOW2

## Lokasi load OpenClaw (referensi)

OpenClaw memuat skill dari (urutan presedensi tertinggi → terendah):

1. `<workspace>/skills` — per-agent
2. `<workspace>/.agents/skills` — per-workspace
3. `~/.agents/skills` — shared agent profile
4. `~/.openclaw/skills` — shared all agents ✅ rekomendasi
5. Bundled skills
6. `skills.load.extraDirs` (config)

## Lisensi

[MIT](LICENSE) — silakan fork, modifikasi, dan adaptasi.

## Kontribusi

PR & issue welcome. Jika Anda mengembangkan varian untuk mining crypto lain, feel free fork & adaptasi.
