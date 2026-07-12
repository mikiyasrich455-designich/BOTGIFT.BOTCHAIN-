# Features

## Gift Types

### 1. Standard Gift
Send BOT with a custom Soulbound NFT card. Upload an image, write a message, and mint a non-transferable NFT that holds the gift value.

- Custom image upload (stored on IPFS via Pinata)
- Personal message (140 characters)
- Sender name
- On-chain Soulbound NFT with metadata
- Optional gas grant for recipient

### 2. Secret Gift
Encrypted vault wallet system. Lock BOT in a randomly generated wallet, encrypt the private key with a claim code, and share the code. First person to claim gets the funds.

- Random wallet generation per gift
- AES-256-GCM encryption (PBKDF2, 100k iterations)
- Claim code generation (format: `SG-XXXX-XXXX`)
- Gas buffer included (0.001 BOT)
- Sweep-to-claim (decrypts vault, transfers to claimer)
- Custom image support
- Supabase cross-device storage
- Real-time claimed status check

### 3. Mystery Box
Randomized rewards with animated reveal. Send a mystery gift that reveals a random amount to the recipient.

### 4. Time-Locked Vault
Gift with an unlock date. Recipient must wait until the timer expires before claiming.

- Configurable unlock duration
- Countdown display
- Locked/unlocked status badges
- Auto-release on expiry

### 5. Gasless Claim
Sender pays gas for the recipient to claim. Removes the barrier for first-time crypto users.

- Auto gas grant (0.02 BOT)
- One-click claim experience

### 6. DAO Batch Gift
Send gifts to multiple addresses in a single transaction. Designed for community rewards and airdrops.

- Multi-recipient support
- Batch transaction
- Individual amounts per recipient

### 7. Custom Designer
Full card designer with image upload, text customization, and live preview.

- Drag-and-drop image upload
- Live card preview
- Custom text and styling
- IPFS storage for artwork

### 8. Soulbound NFT (SBT)
Non-transferable ERC-721 tokens with on-chain metadata. Every gift is a unique NFT with custom artwork, traits, and message.

- ERC-721 Soulbound standard
- IPFS metadata (image + JSON)
- Token ID generation
- Convert-to-BOT function (unwrap)
- On-chain viewing via block explorer

---

## Pages

### Home
Animated hero section with headline, subtext, and CTA buttons. Desktop shows left-aligned layout with background image. Mobile shows centered 3-zone layout with gift box artwork.

### Gift
Standard gift sending form with multi-step flow:
1. Select gift type
2. Enter recipient, amount, message
3. Upload custom image
4. Review and confirm
5. Mint on-chain

### Special Gifts
Grid of special gift types (Secret Gift, Mystery Box, Time-Lock, Gasless, DAO Batch, Custom Designer). Each card has icon, description, and click-to-navigate.

### Gift History
On-chain explorer showing all sent and received gifts. Merges Supabase database records with blockchain transaction data.

- Filter by sent/received
- Transaction hash links to explorer
- Gift amount and status
- Timestamp display

### About
Project information page with typewriter animations. Explains the GIFT BOT vision, BOT Chain, and technical details.

### Profile / Soulbound Gifts
View all minted Soulbound NFTs. Shows NFT card with image, amount, message, and token ID. Includes convert-to-BOT functionality.

---

## Navigation

### Desktop
- Top navigation bar with pill tabs
- Wallet connection button with address display
- Profile dropdown (copy address, view explorer, edit profile, soulbound gifts)
- BOT Chain network indicator

### Mobile
- Bottom navigation bar (5 tabs: Home, Gift, Special, History, Profile)
- Special button has elevated circular design
- Top wallet bar (compact, fixed)
- Safe-area padding for notch devices
- Touch-optimized (44px minimum tap targets)

---

## Animations

| Animation | Trigger | Description |
|-----------|---------|-------------|
| `fadeUpReveal` | Page load | Content slides up with fade |
| `slideIn` | Panel open | Panel slides in from bottom |
| `pulseGlow` | Active elements | Green glow pulse |
| `shineSweep` | Card hover | Light sweep across card |
| `checkPop` | Selection | Checkmark pop animation |
| `confettiFall` | Success | Confetti particles |
| `floatParticle` | Background | Floating gift emojis |
| `giftBoxShake` | Claim | Gift box shake on open |
| `claimSuccessPop` | Claim success | Success checkmark animation |
| `aboutFadeUp` | About page | Staggered content reveal |
| `typewriter` | About page | Typewriter text effect |

---

## AI Assistant

Floating chatbot widget available on all pages. Powered by Botchain AI, provides:
- Gift recommendations
- How-to guidance
- Feature explanations
- Message suggestions
