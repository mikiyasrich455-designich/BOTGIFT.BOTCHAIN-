# 🏗️ Architecture Overview

## Single-File Architecture

GIFT BOT is a **single HTML file** (`index.html`) containing all HTML, CSS, and JavaScript. This approach was chosen for:
- **Zero build step** — open and run
- **Easy deployment** — drag and drop anywhere
- **Portability** — works offline after first load
- **Demo-friendly** — no setup required

---

## 📐 File Structure

```
index.html (7,700+ lines)
├── <style> (CSS)
│   ├── Base styles (glassmorphism, scrollbars, cursor glow)
│   ├── Gift card animations (10 keyframe sets)
│   ├── Claim page animations (10 themed sequences)
│   ├── Themed form styles (10 color schemes)
│   └── Responsive utilities
│
├── <body> (HTML)
│   ├── Navbar (wallet button, navigation)
│   ├── Home section (hero, stats, gift grid)
│   ├── Gift section (send flow, form, review)
│   ├── Special gifts (SBT, mystery, DAO, designer, timelock)
│   ├── History section (cards, filters)
│   ├── About section (typewriter, features)
│   ├── Modals (wallet, info, success, claim)
│   └── Claim overlay (full-screen animated)
│
└── <script> (JavaScript)
    ├── Script 1: Main app (IIFE scope)
    │   ├── DOM element cache
    │   ├── Gift type definitions
    │   ├── Wallet connection
    │   ├── Contract interactions
    │   ├── Gift sending logic
    │   ├── History loading
    │   └── UI state management
    │
    ├── Script 2: React components (Babel)
    │   ├── Gift cards grid
    │   ├── AI chatbot
    │   └── Special gift forms
    │
    ├── Script 3: Claim page (IIFE)
    │   ├── Themed renderers (10 types)
    │   ├── Claim flow
    │   └── Wallet connection (self-contained)
    │
    └── Script 4: AI chatbot (IIFE)
        ├── Groq API integration
        ├── System prompt
        └── Chat history
```

---

## 🔗 Data Flow

### Gift Sending
```
User fills form
    ↓
selectGiftType() → theme applied
    ↓
sendGift() → validate inputs
    ↓
dispatchRealGift()
    ├── createGiftMetadata() → Pinata IPFS
    ├── sbtContract.mintSoulboundGift() → BOT Chain
    ├── addGift() → localStorage
    └── grantGasToRecipient() → 0.01 BOT transfer
    ↓
Success overlay + confetti + share link
```

### Gift Claiming (via link)
```
URL: ?gift=TOKEN_ID
    ↓
showGiftClaimPage(tokenId)
    ├── renderThemedGiftBox(style) → themed HTML
    └── Show Step 1 (preview + animated box)
    ↓
User taps box → claimOpenGift()
    ├── themed.open() → type-specific animation
    └── Transition to Step 2 (connect wallet)
    ↓
startClaimFlow()
    ├── Connect wallet (self-contained)
    ├── Verify recipient matches
    └── sbtContract.convertToBot(tokenId)
    ↓
Step 3 (success) + themed particles
```

---

## 🗄️ Storage

### On-Chain (BOT Chain)
- Soulbound NFTs (ERC-721)
- Token metadata (IPFS URI)
- Gift data (sender, recipient, amount, message, timestamp)
- BOT token balances

### Off-Chain (localStorage)
- Gift records (JSON array)
- Time-lock data (token ID → unlock time)
- Wallet address
- Profile data

### IPFS (Pinata)
- NFT metadata JSON
- Gift artwork images
- Card designer exports

---

## 🔐 Security Model

### Wallet
- Private keys stay in MetaMask
- No private keys in code
- `systemSigner` is MetaMask's provider signer

### Contract
- Soulbound = non-transferable
- `convertToBot()` burns NFT, releases BOT
- Only recipient can claim (owner check)

### Client-Side
- Input validation (address format, amount > 0)
- Self-send prevention
- HTML escaping (XSS prevention)

---

## ⚡ Performance

### Optimizations
- CDN libraries (no bundling)
- Lazy section rendering (hidden by default)
- Staggered animations (CSS only)
- Balance polling (10s interval)
- History caching (localStorage)

### Known Limitations
- SBT history: sequential `ownerOf()` calls
- Single-file: no code splitting
- Client-side timelock: localStorage only

---

## 🧪 Testing

### Manual Test Checklist

#### Wallet
- [ ] Connect MetaMask
- [ ] Disconnect
- [ ] Switch accounts
- [ ] Wrong chain detection

#### Gift Flow
- [ ] Select each gift type
- [ ] Fill form with themed placeholders
- [ ] Review step shows correct info
- [ ] Send triggers mint + gas grant
- [ ] Success overlay + confetti

#### Claim Flow
- [ ] Open claim link (`?gift=TOKEN_ID`)
- [ ] See themed animation
- [ ] Tap box → animation plays
- [ ] Connect wallet
- [ ] Verify recipient check
- [ ] Claim succeeds
- [ ] NFT burns, BOT received

#### History
- [ ] Load with wallet connected
- [ ] Filter tabs work
- [ ] Cards show correct data
- [ ] Share link copies
- [ ] TX hash links to explorer

#### Mobile
- [ ] Responsive layout
- [ ] Touch interactions
- [ ] MetaMask mobile deep-link
- [ ] Scrollable sections
