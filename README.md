<p align="center">
  <img src="https://res.cloudinary.com/dguexkgjw/image/upload/v1784278138/Screenshot_2026-07-08_121902_ja0ywy.png" alt="BOT Chain" width="100%">
</p>

<h1 align="center">GIFT BOT</h1>

<p align="center">
  <b>The First On-Chain Gifting Protocol on BOT Chain Mainnet</b><br>
  Send crypto gifts as Soulbound NFTs. No wallets needed to claim.
</p>

<p align="center">
  <a href="https://scan.botchain.ai/address/0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3">
    <img src="https://img.shields.io/badge/Contract-0x29F6...C9F3-green" alt="Contract">
  </a>
  <a href="https://scan.botchain.ai">
    <img src="https://img.shields.io/badge/Network-BOT%20Chain%20Mainnet-blue" alt="Network">
  </a>
  <a href="https://scan.botchain.ai/address/0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3">
    <img src="https://img.shields.io/badge/Chain%20ID-677-purple" alt="Chain ID">
  </a>
</p>

---

## What is GIFT BOT?

GIFT BOT is a fully decentralized gifting dApp built on **BOT Chain Mainnet**. Send cryptocurrency gifts as **Soulbound NFTs** — non-transferable tokens that carry your gift, your message, and your token of love forever on-chain.

Recipients don't need crypto knowledge. They receive a **claim link**, connect their wallet, and the gift is theirs.

---

## Features

| Feature | Description |
|---------|-------------|
| **10+ Gift Types** | Crypto Bro, Love Letter, Birthday, Heart, Mystery Box, Golden Ticket, Treasure Chest, Christmas, Diamond Hands |
| **Soulbound NFTs** | Each gift is minted as a non-transferable NFT — permanently on-chain |
| **Secret Gifts** | Create claim-code based gifts with encrypted vault wallets |
| **Card Designer** | Design custom gift cards with drag-and-drop canvas |
| **Time-Locked Gifts** | Lock gifts until a specific date — recipient can't claim early |
| **DAO Treasury** | Batch-send gifts to multiple addresses at once |
| **Gasless Claiming** | Sender pre-funds claim gas so recipients pay nothing |
| **Gift History** | Full on-chain history of sent, received, and claimed gifts |
| **AI Gift Advisor** | AI-powered chatbot helps pick the perfect gift |
| **Mystery Boxes** | Random reward tiers — common, rare, or legendary |

---

## How It Works

```
Sender                                         Recipient
  |                                               |
  |-- 1. Select gift type + amount ------------> |
  |-- 2. Mint Soulbound NFT (on-chain) --------> |
  |-- 3. Share claim link ---------------------> |
  |                                      4. Open claim link
  |                                      5. Connect wallet
  |                                      6. Claim NFT -> BOT tokens in wallet
  | <-- 7. Gift burned, BOT released ----------- |
```

1. **Sender** connects wallet, picks a gift type, enters amount and message
2. **Smart Contract** mints a Soulbound NFT containing the BOT value
3. **Recipient** gets a unique claim link (no wallet needed to receive)
4. **Recipient** opens link, connects wallet, clicks "Claim"
5. **Contract** burns the NFT and releases BOT to the recipient

---

## Smart Contract

| | |
|---|---|
| **Contract** | [`0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3`](https://scan.botchain.ai/address/0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3) |
| **Network** | BOT Chain Mainnet |
| **Chain ID** | 677 |
| **RPC** | `https://rpc.botchain.ai` |
| **Explorer** | [`scan.botchain.ai`](https://scan.botchain.ai) |
| **Token** | BOT (18 decimals) |

### Contract Functions

- `mintSoulboundGift(recipient, tokenURI, message)` — Mint a gift NFT (payable)
- `convertToBot(tokenId)` — Claim gift: burn NFT, receive BOT
- `getGiftData(tokenId)` — Read gift details on-chain
- `tokenURI(tokenId)` — Get IPFS metadata
- `ownerOf(tokenId)` — Check NFT ownership
- `tokenCounter()` — Total gifts minted

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Blockchain** | BOT Chain Mainnet (EVM-compatible) |
| **Smart Contract** | Solidity 0.8.22 (SoulboundGiftNFTV2) |
| **Frontend** | Vanilla HTML/CSS/JS + React (CDN) |
| **Wallet** | MetaMask (Injected Provider) |
| **NFT Metadata** | IPFS via Pinata |
| **AI Chatbot** | Groq API (Llama 3.1) |
| **Secret Gift DB** | Supabase (encrypted vault keys) |
| **Styling** | Tailwind CSS |

---

## Quick Start

1. **Install MetaMask** browser extension
2. **Add BOT Chain Mainnet** to MetaMask:
   - Network Name: `BOT Chain Mainnet`
   - RPC URL: `https://rpc.botchain.ai`
   - Chain ID: `677`
   - Symbol: `BOT`
   - Explorer: `https://scan.botchain.ai`
3. **Get BOT tokens** on mainnet
4. **Open `index.html`** in your browser
5. **Connect wallet** and start gifting!

---

## Project Structure

```
GIFT BOT/
  index.html           # Main dApp (full-stack single file)
  indexhui.html        # Alternate UI version
  mobile.html          # Mobile-optimized version
  mobile - Copy.html   # Mobile backup
  setup.sql            # Supabase database schema
  README.md            # This file
```

---

## Network Configuration

```javascript
const BOT_CHAIN_MAINNET = {
  chainId: '0x2A5',           // 677 in decimal
  chainName: 'BOT Chain Mainnet',
  nativeCurrency: {
    name: 'BOT',
    symbol: 'BOT',
    decimals: 18
  },
  rpcUrls: ['https://rpc.botchain.ai'],
  blockExplorerUrls: ['https://scan.botchain.ai']
};
```

---

## Deployed On

<p align="center">
  <a href="https://scan.botchain.ai/address/0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3">
    <img src="https://res.cloudinary.com/dguexkgjw/image/upload/v1784278138/Screenshot_2026-07-08_121902_ja0ywy.png" alt="BOT Chain Mainnet" width="600">
  </a>
</p>

<p align="center">
  <b>Live on BOT Chain Mainnet</b><br>
  <a href="https://scan.botchain.ai/address/0x29F624c97FF1623697592EEe5c63Eb657A2DC9F3">View on Explorer</a>
</p>

---

## License

MIT
