# Contoh Output Skill

Berikut contoh output yang dihasilkan skill `rpow-cli-miner` untuk berbagai skenario:

---

## Skenario 1: Setup & Install

> User: "Setup RPOW CLI miner di laptop Linux saya"

### Output:

**Step 1 — Clone repo**

```bash
git clone https://github.com/stablemarkk/rpow_cli_miner.git
cd rpow_cli_miner
```

**Step 2 — Verifikasi Node.js**

```bash
node -v
# Output: v22.12.0 ✓ (minimum 18+)
```

**Step 3 — Build native CPU miner**

```bash
bash build-native.sh
# Output: Built ./rpow-native-miner
```

**Step 4 — Verifikasi instalasi**

```bash
node rpow-cli.js map
# Output: API origin, endpoints, dan pipeline sequence

node rpow-cli.js ledger
# Output: statistik ledger (total minted, supply, difficulty, dll)
```

Instalasi selesai. Native miner sudah siap di `./rpow-native-miner`.

---

## Skenario 2: Login + Mining

> User: "Login dan mine 10 RPOW token"

### Output:

**Step 1 — Request magic link**

```bash
node rpow-cli.js login --email user@example.com --state .rpow-a.json
```

Cek email Anda untuk magic link. Jangan jalankan command ini lagi sampai link datang.

**Step 2 — Complete login**

```bash
node rpow-cli.js complete-login --link "https://rpow2.com/..." --state .rpow-a.json
```

**Step 3 — Verifikasi sesi**

```bash
node rpow-cli.js me --state .rpow-a.json
# Output: email, balance, counters
```

**Step 4 — Mulai mining**

```bash
node rpow-cli.js mine --count 10 --engine native --workers 8 --state .rpow-a.json
```

Progress akan ditampilkan setiap 5 detik:

```text
mining hashes=... nonce=... workers=8 engine=native speed="21.00 MH/s"
```

---

## Skenario 3: Optimasi Mining Lambat

> User: "Mining saya lambat, gimana cara optimasi?"

### Output:

**Diagnosis:**

1. Engine apa yang dipakai? Jika `node`, itu 700x lebih lambat dari `native`.
2. Berapa workers? Default max 8, bisa dinaikkan.
3. Ada GPU? GPU mining 35x lebih cepat dari CPU.

**Solusi bertahap:**

| Level | Aksi | Command |
| --- | --- | --- |
| 1 | Pakai native engine | `--engine native` |
| 2 | Naikkan workers | `--workers 12` (sesuai jumlah core) |
| 3 | Pakai GPU | `--engine gpu --gpu-batch 2097152 --gpu-local-size 256` |

**Command rekomendasi (CPU):**

```bash
node rpow-cli.js mine --count 100 --engine native --workers 12 --state .rpow-a.json
```

**Command rekomendasi (GPU):**

```bash
node rpow-cli.js mine --count 1000 --engine gpu --workers 16 --gpu-batch 2097152 --gpu-local-size 256 --state .rpow-a.json
```

---

## Skenario 4: Kirim RPOW

> User: "Kirim 5 RPOW ke friend@example.com"

### Output:

```bash
# Pastikan sesi aktif dulu
node rpow-cli.js me --state .rpow-a.json

# Kirim
node rpow-cli.js send --to friend@example.com --amount 5 --state .rpow-a.json
```

Verifikasi pengiriman:

```bash
node rpow-cli.js activity --state .rpow-a.json
```

---

## Skenario 5: Statistik Ledger

> User: "Cek statistik ledger RPOW"

### Output:

```bash
node rpow-cli.js ledger
```

Contoh output:

```text
ledger total_minted_base_units=9981561564162818
       circulating_supply_base_units=4017688509520451
       max_supply_base_units=19000000000000000
       current_difficulty_bits=25
       current_reward_base_units=10000000
       user_count=60310
```

Artinya:
- Total minted: ~9.98M RPOW
- Circulating supply: ~4.02M RPOW
- Max supply: 19M RPOW
- Difficulty: 25 bits
- Reward per token: 0.01 RPOW
- Total user: 60.310
