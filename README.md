<div align="center">

# 🎁 GIFT BOT

### *The On-Chain Gifting Protocol on BOT Chain*

![BOT Chain](https://img.shields.io/badge/BOT%20Chain-Testnet-059669?style=for-the-badge&logo=ethereum&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-0.8+-363636?style=for-the-badge&logo=solidity&logoColor=white)
![IPFS](https://img.shields.io/badge/IPFS-Pinata-65CFF0?style=for-the-badge&logo=ipfs&logoColor=white)
![MetaMask](https://img.shields.io/badge/MetaMask-Supported-F6851B?style=for-the-badge&logo=metamask&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-10b981?style=for-the-badge)

<br>

**Send crypto gifts as Soulbound NFTs. Recipients claim for free. No gas fees.**

<br>

[🚀 Live Demo](#-quick-start) • [📖 How It Works](#-how-it-works) • [🎨 Gift Types](#-gift-types) • [⚙️ Tech Stack](#-tech-stack) • [🔧 Setup](#-setup)

<br>

</div>

---

## 🌟 What is GIFT BOT?

GIFT BOT is a **decentralized gifting protocol** built on BOT Chain Testnet that transforms how people send crypto. Instead of boring wallet transfers, gifts become **Soulbound NFTs** — non-transferable digital collectibles with themed animations, personal messages, and a premium claim experience.

> **The sender pays everything. The recipient claims for free. Zero gas fees.**

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎨 10 Themed Gift Types
- 💌 Love Letter — sealed envelope animation
- 💖 Heart — 3D beat & pulse
- 🎁 Crypto Bro — vault door opening
- 🎂 Birthday — balloons & cake reveal
- 💎 Diamond — prismatic light split
- 🎫 Golden Ticket — shimmer unfold
- 🎲 Mystery — box shatter effect
- 🏴‍☠️ Treasure — chest & gold spill
- 🎄 Christmas — ornament & snowfall
- 🏛️ DAO — temple doors opening

</td>
<td width="50%">

### ⚡ Core Capabilities
- **Soulbound NFT Gifts** — non-transferable, burn-to-claim
- **$0 Claim Fee** — sender pre-funds 0.01 BOT for gas
- **Shareable Claim Links** — `?gift=TOKEN_ID` URL
- **Time-Locked Gifts** — unlock at a specific date
- **Mystery Box** — randomized reward amounts
- **DAO Treasury** — batch-send to multiple wallets
- **Card Designer** — custom NFT artwork
- **AI Gift Assistant** — Groq-powered chatbot

</td>
</tr>
</table>

---

## 🎬 How It Works

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐
│   SENDER    │────▶│  MINT SBT    │────▶│  AUTO-GAS   │
│  Connects   │     │  NFT Gift    │     │  0.01 BOT   │
│  Wallet     │     │  + IPFS      │     │  to Recipient│
└─────────────┘     └──────────────┘     └──────────────┘
                           │                     │
                           ▼                     ▼
                    ┌──────────────┐     ┌──────────────┐
                    │  SHARE LINK  │     │  RECIPIENT   │
                    │  ?gift=ID    │────▶│  Claims FREE │
                    └──────────────┘     │  Burns NFT   │
                                         │  Gets BOT    │
                                         └──────────────┘
```

### The Flow

1. **Sender** connects MetaMask → selects gift type → fills recipient, amount, message
2. **Smart Contract** mints a Soulbound NFT to the recipient + uploads metadata to IPFS
3. **Auto-Gas** sends 0.01 BOT to the recipient's wallet (they pay nothing)
4. **Sender** shares the claim link via any platform
5. **Recipient** opens link → connects wallet → sees themed claim animation → claims instantly
6. **NFT burns** → BOT tokens released to recipient's wallet

---

## 🎁 Gift Types

| Type | Icon | Theme | Animation | Use Case |
|------|------|-------|-----------|----------|
| Love Letter | 💌 | Rose/Pink | Envelope unseal + hearts | Romantic gestures |
| Heart | 💖 | Purple/Magenta | 3D beat + pulse rings | Express love |
| Crypto Bro | 🎁 | Green/Gold | Vault door + coin spill | Crypto community |
| Birthday | 🎂 | Indigo/Colorful | Balloons + cake reveal | Birthday gifts |
| Diamond | 💎 | Cyan/Teal | Prism split + gem glow | Premium gifts |
| Golden Ticket | 🎫 | Amber/Gold | Ticket shimmer unfold | Lottery/wins |
| Mystery | 🎲 | Violet/Purple | Box rattle + shatter | Surprise gifts |
| Treasure | 🏴‍☠️ | Brown/Gold | Chest open + gold spill | Pirate theme |
| Christmas | 🎄 | Red/Green | Ornament crack + snow | Holiday gifts |
| DAO | 🏛️ | Purple/Violet | Temple doors open | Governance |

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Blockchain** | BOT Chain Testnet (EVM-compatible L1) |
| **Smart Contract** | Solidity — Soulbound NFT with `convertToBot()` burn-to-claim |
| **Frontend** | Vanilla JS + Tailwind CSS v4 + React 18 (CDN) |
| **Web3** | ethers.js 6.7 — wallet connection, contract interactions |
| **Storage** | IPFS via Pinata — NFT metadata + artwork |
| **AI** | Groq API — llama-3.3-70b-versatile gift assistant |
| **Wallet** | MetaMask — browser extension + mobile deep-link |
| **Animations** | Pure CSS — 10 unique claim sequences, 3D transforms, keyframes |
| **Claim Page** | Next.js 14 + Framer Motion + canvas-confetti (optional) |

---

## 🔧 Setup

### Quick Start (Single File)

```bash
# Clone the repo
git clone https://github.com/yourusername/gift-bot.git

# Open index.html in any browser
open index.html
# or
python -m http.server 8000
```

> **Note:** Must be served over HTTP (not `file://`) for MetaMask connection to work.

### Prerequisites

- [MetaMask](https://metamask.io/) browser extension installed
- BOT Chain Testnet added to MetaMask (auto-prompts on first connect)
- Some BOT tokens in your wallet ([Faucet](https://faucet.botchain.ai))

### Environment

No `.env` file needed — all configuration is in the HTML file:
- **Contract:** `0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16`
- **Chain ID:** `0x3C8` (BOT Chain Testnet)
- **RPC:** `https://rpc.bohr.life`
- **Explorer:** `https://scan.bohr.life`

---

## 📁 Project Structure

```
gift-bot/
├── index.html              # 🎯 Main application (single-file)
├── gift-dapp/              # Optional: Next.js claim page
│   ├── app/
│   │   └── gifts/claim/
│   │       └── [giftId]/
│   │           └── page.tsx
│   ├── lib/
│   │   ├── contracts.ts
│   │   ├── gift-themes.ts
│   │   ├── gift-data.ts
│   │   ├── types.ts
│   │   └── use-wallet.ts
│   ├── package.json
│   └── tailwind.config.js
├── README.md
├── LICENSE
└── .gitignore
```

---

## 🏆 BOT Chain Builder Challenge

Built for the **BOT Chain Builder Challenge** (7-day sprint, deadline: Jul 8, 2026).

### What Makes This Different

- **10 unique animated claim experiences** — not just a boring claim button
- **Gasless claiming** — recipient pays absolutely nothing
- **Soulbound mechanics** — NFTs that burn to release value
- **AI-powered gift assistant** — contextual help for every gift type
- **Full-stack in one file** — HTML + CSS + JS + React + Web3 + IPFS + AI

---

## 📜 Smart Contract

```solidity
// SoulboundGift.sol (simplified)
function mintSoulboundGift(
    address recipient,
    string memory tokenURI,
    string memory message
) external payable returns (uint256);

function convertToBot(uint256 tokenId) external;
// Burns the NFT and releases BOT to the caller
```

- **Token Standard:** ERC-721 (Soulbound — non-transferable)
- **Claim Function:** `convertToBot()` — burns NFT, sends BOT to recipient
- **Metadata:** Stored on IPFS via Pinata, retrieved via `tokenURI()`

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- [BOT Chain](https://botchain.ai) — blockchain infrastructure
- [Pinata](https://pinata.cloud) — IPFS pinning service
- [ethers.js](https://docs.ethers.org) — Ethereum library
- [Tailwind CSS](https://tailwindcss.com) — utility-first CSS
- [Groq](https://groq.com) — AI inference API
- [MetaMask](https://metamask.io) — wallet provider

---

<div align="center">

**Built with 💚 for BOT Chain Builder Challenge 2026**

![GIFT BOT](https://img.shields.io/badge/GIFT%20BOT-v1.0-10b981?style=for-the-badge&logo=ethereum&logoColor=white)

</div>
