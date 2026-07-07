# ✨ Feature Breakdown

## 🎁 Gift System

### 10 Themed Gift Types
Each gift type has:
- Unique card design with gradient and glow
- Themed form styling (borders, focus states, button color)
- Custom placeholders ("Who holds your heart?" for Love Letter, "Fellow pirate" for Treasure)
- Animated claim experience (envelope unseal, vault door, box shatter, etc.)
- Type-specific confetti/particles on claim success

### Gift Cards
- 3D tilt effect on mouse hover
- Staggered entrance animation
- Glow effect on selection
- Info modal with description

---

## ⛓️ Blockchain

### Soulbound NFTs
- Non-transferable ERC-721 tokens
- Burn-to-claim via `convertToBot()`
- Metadata stored on IPFS (Pinata)
- Token URI with full gift data

### Gasless Claims
- Sender auto-sends 0.01 BOT to recipient
- Recipient pays $0 to claim
- Works via `systemSigner.sendTransaction()`

### Time-Locked Gifts
- Set unlock date/time when sending
- Countdown display in history
- Blocked claim before unlock (client-side)

---

## 🎨 UI/UX

### Animations
- 10 unique claim page animations
- 3D gift box with perspective transforms
- Confetti on every success state
- Smooth section transitions
- Floating particle effects
- Card tilt on hover

### Theming
- Glassmorphism panels
- Custom scrollbars
- Gradient backgrounds per section
- Responsive design (mobile → desktop)

### Gift Claim Page
- Full-screen overlay with `?gift=TOKEN_ID` URL
- Three-step flow: Preview → Connect → Claim
- Animated claim button
- Success screen with TX link

---

## 🤖 AI Integration

### Gift Assistant Chatbot
- Groq API with llama-3.3-70b-versatile
- Context-aware (knows gift types, amounts, features)
- Themed per gift type
- Quick prompt buttons
- 20-message history cap

---

## 📊 History & Tracking

### Gift History
- Card-based grid layout
- Filter tabs (All, Pending, Claimed)
- 3D tilt hover effect
- Staggered entrance animation
- Share link + preview buttons
- Timelock status badges

### On-Chain Data
- Real-time balance updates
- Token counter tracking
- Owner verification
- TX hash links to explorer

---

## 🔐 Security

### Wallet Connection
- MetaMask-only (clean modal)
- Auto-reconnect on page load
- Disconnect flag in sessionStorage
- Chain switching with auto-add
- Error handling for all edge cases

### Data Validation
- Address format validation (0x + 40 chars)
- Amount > 0 check
- Self-send prevention
- Timelock enforcement

---

## 📱 Mobile

### Responsive Design
- Tailwind CSS responsive utilities
- Mobile-first approach
- Touch-friendly buttons
- Scrollable containers

### MetaMask Mobile
- Deep-linking to MetaMask app
- Protocol detection (http vs file)
- Helpful error messages for local files

---

## 🎯 Special Features

### Mystery Box
- Randomized reward amounts
- Shaking animation
- Crack + shatter effect
- Surprise reveal

### DAO Treasury
- Batch-send to multiple wallets
- Progress tracking per recipient
- Individual error handling

### Card Designer
- Canvas-based artwork
- Custom text and images
- Export to IPFS
- Mint as NFT

### Shareable Links
- URL format: `?gift=TOKEN_ID`
- Copy to clipboard
- QR code generation
- Works on any device
