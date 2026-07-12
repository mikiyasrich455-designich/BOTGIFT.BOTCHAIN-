# Architecture

## System Overview

GIFT BOT is a single-file decentralized application (dApp) built on BOT Chain Testnet. The entire frontend — UI, blockchain logic, database integration, and IPFS storage — lives in one `index.html` file (~9600 lines).

```
┌─────────────────────────────────────────────────────────┐
│                      index.html                         │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │  React   │  │  ethers  │  │    Supabase JS v2    │  │
│  │  18 UI   │  │  v6.7    │  │    (Gift Database)   │  │
│  └────┬─────┘  └────┬─────┘  └──────────┬───────────┘  │
│       │              │                    │              │
│       │         ┌────┴────┐        ┌─────┴─────┐       │
│       │         │ BOT Chain│        │  Pinata   │       │
│       │         │ Testnet  │        │  IPFS     │       │
│       │         └─────────┘        └───────────┘       │
└─────────────────────────────────────────────────────────┘
```

## File Structure

```
gift-bot/
├── index.html         Single-file app (mobile + desktop)
│
│   ┌─ <style>         Tailwind CSS v4 + custom animations
│   ├─ <nav>           Desktop navigation bar
│   ├─ #mobileNav      Mobile bottom navigation (5 tabs)
│   ├─ #mobileWalletBar Mobile wallet bar (top)
│   ├─ #homeView       Hero section (React component)
│   ├─ #giftView       Standard gift send form
│   ├─ #specialGiftsView  Special gift types grid
│   ├─ #secretGiftView Secret Gift create/redeem
│   ├─ #soulboundView  SBT minting form + review
│   ├─ #timelockView   Time-locked vault form
│   ├─ #historyView    On-chain gift explorer
│   ├─ #aboutView      Project info page
│   └─ <script>        All JS: wallet, DB, IPFS, UI logic
│
├── setup.sql          Supabase table schema
├── vercel.json        Vercel deploy config
├── README.md          Project documentation
├── ARCHITECTURE.md    This file
├── FEATURES.md        Feature documentation
├── TECHNICAL.md       Technical deep-dive
├── DEPLOY.md          Deployment guide
├── CONTRIBUTING.md    Contribution guide
└── LICENSE            MIT License
```

## Data Flow

### Standard Gift
```
User → Connect MetaMask → Select Gift Type → Fill Form
  → Upload Image to Pinata (IPFS)
  → Create Metadata on Pinata (IPFS)
  → Mint Soulbound NFT on BOT Chain
  → Grant Gas to Recipient (optional)
  → Display Success + Transaction Hash
```

### Secret Gift (Vault System)
```
Creator:
  User → Enter Amount + Message + Custom Image
  → Generate Random Wallet (ethers.Wallet.createRandom)
  → Send BOT + Gas Buffer to Vault Address
  → Encrypt Vault Private Key with Claim Code (AES-256-GCM)
  → Store Encrypted Data in Supabase
  → Share Claim Code with Recipient

Claimer:
  Enter Claim Code → Lookup in Supabase
  → Decrypt Vault Private Key with Code
  → Import Vault Wallet → Estimate Gas
  → Sweep BOT to Claimer Wallet
  → Mark as Claimed in Supabase
  → Show Success Popup with Balance Update
```

### Gift History
```
User → Connect Wallet → Navigate to History
  → Query Supabase for Sender/Recipient Records
  → Fetch On-Chain Data via RPC (ethers.js)
  → Merge Database + Blockchain Data
  → Display Combined Gift List
```

## Responsive Layout

### Desktop (>768px)
- Top navigation bar with pill tabs
- Desktop wallet connection button with dropdown
- Hero: left-aligned headline, side-by-side CTA buttons
- Background: PC hero image (full viewport)
- Multi-column gift card grid

### Mobile (<=768px)
- Bottom navigation bar (5 tabs with safe-area padding)
- Top wallet bar (fixed, compact)
- Hero: centered headline, stacked CTA buttons at bottom
- Background: Gift box hero image (centered 60%)
- Single-column layouts, touch-optimized (44px min targets)
- PWA meta tags (apple-mobile-web-app-capable, theme-color)

## Smart Contract

**SoulboundGiftNFTV2** — `0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16`

- ERC-721 Soulbound (non-transferable)
- `mint(address to, uint256 tokenId)` — Mint gift NFT
- `convertToBot(uint256 tokenId)` — Convert NFT back to BOT
- `balanceOf(address)` — Check SBT balance
- `tokenURI(uint256)` — Get IPFS metadata URI

## Encryption Flow (Secret Gift)

```
Claim Code (e.g. "SG-ABCD-1234")
        │
        ▼
   PBKDF2 (100,000 iterations)
   Salt: derived from code
   Key:  256-bit AES key
        │
        ▼
   AES-256-GCM Encrypt
   Input:  Vault Private Key
   Output: Base64 (salt + iv + ciphertext)
        │
        ▼
   Stored in Supabase `encrypted_pk` column
```

## Network Configuration

| Property | Value |
|----------|-------|
| Chain Name | BOT Chain Testnet |
| Chain ID | `968` (`0x3C8`) |
| RPC URL | `https://rpc.bohr.life` |
| Explorer | `https://scan.bohr.life` |
| Currency | `BOT` (18 decimals) |
| Block Time | ~0.75s |
