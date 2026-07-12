<div align="center">

# GIFT BOT

### Web3 Gifting on BOT Chain

**Send on-chain Soulbound NFT gifts with custom artwork, encrypted vaults, and gasless claiming.**

[![BOT Chain](https://img.shields.io/badge/BOT%20Chain-Testnet-10b981?style=for-the-badge&logo=ethereum&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-MIT-blueviolet?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Live-brightgreen?style=for-the-badge)](#)

[Live App](https://gift-bot.vercel.app) · [BOT Chain Scan](https://scan.bohr.life) · [Report Bug](https://github.com/your-username/gift-bot/issues)

</div>

---

## What is GIFT BOT?

GIFT BOT is a full-stack Web3 gifting dApp built natively on **BOT Chain Testnet** — a high-performance L1 with 0.75s finality and near-zero fees. Users can send crypto as beautiful, personalized Soulbound NFT gifts with custom artwork, messages, and traits stored on IPFS.

The app features **10+ gift types** including standard transfers, mystery boxes, DAO batch gifting, time-locked vaults, and the signature **Secret Gift** — an encrypted voucher system where private keys are locked behind claim codes.

---

## Features

### Gift Types
| Type | Description |
|------|-------------|
| **Standard Gift** | Send BOT with a custom Soulbound NFT card |
| **Secret Gift** | Encrypted vault wallet — lock BOT, share a code, first claimant wins |
| **Mystery Box** | Randomized rewards with animated reveal |
| **Time-Locked Vault** | Gift with unlock date — recipient waits until the timer expires |
| **Gasless Claim** | Sender pays gas for recipient to claim |
| **DAO Batch Gift** | Send gifts to multiple addresses in one transaction |
| **Custom Designer** | Upload custom artwork for NFT gift cards |
| **About Page** | Project info with typewriter animations |
| **Gift History** | On-chain explorer for sent/received gifts |
| **AI Assistant** | Chatbot for gifting advice and navigation |

### Technical Highlights

- **Soulbound NFTs** — Non-transferable ERC-721 tokens with on-chain metadata (IPFS via Pinata)
- **Encrypted Vault Wallets** — Private keys encrypted with claim codes via AES-256-GCM (PBKDF2, 100k iterations)
- **MetaMask Integration** — Wallet connection, chain switching, transaction signing
- **Cross-Device Sync** — Gift data stored in Supabase, claimable from any device
- **Real-Time History** — On-chain gift explorer with live blockchain data
- **Single-File Architecture** — Entire app in one `index.html` (React 18 + Tailwind CSS + ethers.js)

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | React 18, Tailwind CSS v4, ethers.js v6.7 |
| **Blockchain** | BOT Chain Testnet (chainId: `968`) |
| **Smart Contract** | SoulboundGiftNFTV2 — `0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16` |
| **Database** | Supabase (PostgreSQL + Row Level Security) |
| **IPFS** | Pinata (JWT-based pinning + metadata storage) |
| **Wallet** | MetaMask (injected provider) |
| **Build** | Zero build step — Babel standalone transpilation in browser |
| **Deploy** | Vercel (static hosting) |

---

## Getting Started

### Prerequisites

- [MetaMask](https://metamask.io) browser extension
- BOT Chain Testnet configured in MetaMask
- Supabase project (for gift database)

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/gift-bot.git
   cd gift-bot
   ```

2. **Set up the database**
   - Go to your [Supabase Dashboard](https://supabase.com/dashboard)
   - Open SQL Editor
   - Run the contents of `setup.sql`

3. **Configure environment**
   
   Open `index.html` and update these constants:
   ```javascript
   // Line ~4866 — Supabase config
   const SG_SUPABASE_URL = 'https://YOUR_PROJECT.supabase.co';
   const SG_SUPABASE_KEY = 'YOUR_ANON_KEY';
   
   // Line ~4792 — Contract address (already deployed on BOT Chain)
   const SBT_CONTRACT_ADDRESS = "0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16";
   
   // Line ~4860 — Pinata IPFS config
   const PINATA_JWT = 'YOUR_PINATA_JWT';
   ```

4. **Run locally**
   ```bash
   # No build step needed — just serve the file
   npx serve .
   # or
   python -m http.server 8000
   ```

5. **Deploy to Vercel**
   ```bash
   npx vercel --prod
   ```

### BOT Chain Testnet

Add to MetaMask manually:

| Field | Value |
|-------|-------|
| Network Name | BOT Chain Testnet |
| Chain ID | `968` |
| RPC URL | `https://rpc.bohr.life` |
| Currency | `BOT` |
| Explorer | `https://scan.bohr.life` |

---

## Database Schema

The `secret_gifts` table stores encrypted vault gift data:

```sql
CREATE TABLE secret_gifts (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  code         TEXT UNIQUE NOT NULL,           -- Short claim code (e.g. SG-XXXX-XXXX)
  amount       NUMERIC NOT NULL,               -- BOT amount locked
  sender       TEXT NOT NULL,                  -- Creator address
  sender_name  TEXT DEFAULT '',
  recipient    TEXT DEFAULT '',
  message      TEXT DEFAULT '',
  image_url    TEXT DEFAULT '',                 -- Custom card image
  encrypted_pk TEXT DEFAULT '',                 -- AES-encrypted vault private key
  claimed      BOOLEAN DEFAULT false,
  claimed_by   TEXT DEFAULT '',
  claimed_at   TIMESTAMPTZ,
  created_at   TIMESTAMPTZ DEFAULT now()
);
```

---

## Architecture

```
gift-bot/
├── index.html    # Single-file app (~9600 lines)
│   ├── <style>       CSS + Tailwind + animations
│   ├── <nav>         Desktop navigation bar
│   ├── #mobileNav    Mobile bottom navigation
│   ├── #homeView     Hero section (React)
│   ├── #giftView     Standard gift form
│   ├── #specialGiftsView  Special gift types grid
│   ├── #secretGiftView    Secret Gift create/redeem
│   ├── #soulboundView     SBT minting form
│   ├── #timelockView      Time-locked vault form
│   ├── #historyView       On-chain gift history
│   ├── #aboutView         Project info page
│   └── <script>      Blockchain + DB + UI logic
└── setup.sql      # Supabase table setup
```

---

## How Secret Gift Works

```
Creator                          Vault Wallet                    Claimer
  │                                    │                            │
  ├─ 1. Enter amount + message         │                            │
  │                                    │                            │
  ├─ 2. Generate random wallet ────────┤                            │
  │   (ethers.Wallet.createRandom)     │                            │
  │                                    │                            │
  ├─ 3. Send BOT + gas to vault ───────┤                            │
  │   (amount + 0.001 BOT)            │                            │
  │                                    │                            │
  ├─ 4. Encrypt vault PK with code     │                            │
  │   (AES-256-GCM, PBKDF2 100k)      │                            │
  │                                    │                            │
  ├─ 5. Store encrypted PK in DB ──────┤──── Supabase ─────────────┤
  │                                    │                            │
  ├─ 6. Share claim code ──────────────┤────────────────────────────┤
  │                                    │                            │
  │                                    │  7. Enter code ────────────┤
  │                                    │                            │
  │                                    │  8. Decrypt vault PK       │
  │                                    │  9. Sweep BOT to wallet    │
  │                                    │ 10. Mark claimed in DB     │
```

---

## Screenshots

<div align="center">

**Desktop** — Full navigation, animated hero, multi-step gift forms

**Mobile** — Bottom nav, touch-optimized, app-like experience with PWA support

</div>

---

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

MIT License — use freely, build freely.

---

<div align="center">

**Built for the BOT Chain Builder Challenge**

</div>
