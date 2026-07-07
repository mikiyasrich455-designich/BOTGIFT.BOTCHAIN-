# 🔬 Technical Deep Dive

## Smart Contract: SoulboundGift

### Overview
The SoulboundGift contract implements a non-transferable ERC-721 token that can be burned to release BOT tokens to the holder. This creates a "gift card" mechanic on-chain.

### Key Functions

```solidity
// Mint a new gift NFT to recipient
function mintSoulboundGift(
    address recipient,
    string memory tokenURI,
    string memory message
) external payable returns (uint256)

// Burn NFT and release BOT to caller
function convertToBot(uint256 _tokenId) external

// Get gift metadata
function getGiftData(uint256 _tokenId) external view returns (
    address sender,
    address recipient,
    uint256 amount,
    string message,
    uint256 timestamp
)

// Token metadata URI
function tokenURI(uint256 tokenId) external view returns (string memory)
```

### Token Standard
- **ERC-721** with soulbound restrictions
- `transferFrom()` and `safeTransferFrom()` are disabled
- Only `convertToBot()` can "use" the token (burn)

### Burn-to-Claim Mechanic
1. Recipient calls `convertToBot(tokenId)`
2. Contract verifies `msg.sender == ownerOf(tokenId)`
3. NFT is burned (transferred to dead address)
4. BOT tokens equal to `gift.amount` are sent to recipient
5. Event emitted for frontend tracking

---

## Gas Grant System

### Problem
New wallet addresses have 0 BOT and cannot pay gas to claim gifts.

### Solution
After minting, the sender automatically transfers 0.01 BOT to the recipient:

```javascript
async function grantGasToRecipient(recipientAddr) {
    if (!systemSigner || !recipientAddr) return null;
    const gasTx = await systemSigner.sendTransaction({
        to: recipientAddr,
        value: ethers.parseEther('0.01')
    });
    return gasTx;
}
```

### Flow
```
Sender mints NFT (pays gas)
    ↓
grantGasToRecipient() sends 0.01 BOT
    ↓
Recipient receives BOT in wallet
    ↓
Recipient calls convertToBot() (gas-free, covered by 0.01 BOT)
    ↓
NFT burns → BOT released
```

---

## IPFS Integration

### Pinata Setup
- JWT authentication for pinning
- Metadata uploaded as JSON
- Images uploaded as base64 or URLs

### Metadata Structure
```json
{
    "name": "GIFT BOT #123",
    "description": "A cryptoBro gift from 0x1234...5678",
    "image": "ipfs://Qm...",
    "attributes": [
        { "trait_type": "Gift Type", "value": "cryptoBro" },
        { "trait_type": "Amount", "value": "1.5 BOT" },
        { "trait_type": "Message", "value": "Happy Birthday!" },
        { "trait_type": "Sender", "value": "0x1234...5678" },
        { "trait_type": "Timestamp", "value": "1720000000" }
    ]
}
```

### Upload Flow
```
createGiftMetadata()
    ↓
Build metadata JSON
    ↓
Pin to IPFS via Pinata API
    ↓
Return ipfs:// URI
    ↓
Pass to mintSoulboundGift() as tokenURI
```

---

## AI Chatbot

### Architecture
- **Model:** Groq llama-3.3-70b-versatile
- **System Prompt:** Constrains to gift-related topics
- **History:** Last 20 messages (user + assistant)
- **Input:** HTML-escaped (XSS prevention)

### System Prompt
```
You are GIFT BOT's AI assistant on BOT Chain Testnet. You help users with:
- Gift type selection
- Amount recommendations
- Platform features
- Troubleshooting
- BOT Chain information

Never reveal you are an AI language model. Always stay helpful and on-topic.
```

### Integration
```javascript
async function sendToGroq(messages) {
    const response = await fetch('https://api.groq.com/openai/v1/chat/completions', {
        method: 'POST',
        headers: {
            'Authorization': 'Bearer ' + GROQ_API_KEY,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            model: 'llama-3.3-70b-versatile',
            messages: messages,
            max_tokens: 500,
            temperature: 0.7
        })
    });
    return response.json();
}
```

---

## Wallet Connection

### MetaMask Integration
```javascript
// Connect
const accounts = await window.ethereum.request({
    method: 'eth_requestAccounts'
});

// Switch chain
await window.ethereum.request({
    method: 'wallet_switchEthereumChain',
    params: [{ chainId: '0x3C8' }]
});

// Add chain if missing
await window.ethereum.request({
    method: 'wallet_addEthereumChain',
    params: [BOT_CHAIN_TESTNET]
});
```

### Error Handling
- **4001:** User rejected connection
- **-32002:** Connection already pending
- **4902:** Chain not added (auto-add)
- **-32603:** Internal error (retry)

---

## Claim Page Animations

### Architecture
Each gift type has a renderer:
```javascript
{
    html: `<div class="claim-love-envelope">...</div>`,
    open() { /* trigger animation */ },
    openDelay: 1200, // ms before transitioning
    particles(layer, colors) { /* create particles */ }
}
```

### Animation Types
| Type | Key Effect | Duration |
|------|-----------|----------|
| Love Letter | Envelope flap unfold | 1.2s |
| Heart | Pulse wave burst | 1.0s |
| Vault | Dial spin + door swing | 1.4s |
| Birthday | Balloon pop + cake rise | 1.8s |
| Diamond | Prism split + gem glow | 1.1s |
| Golden Ticket | Shimmer sweep | 1.5s |
| Mystery | Rattle + shatter | 1.3s |
| Treasure | Chest open + coin spill | 1.6s |
| Christmas | Ornament crack + snow | 1.5s |
| DAO | Temple doors open | 1.4s |

### CSS Techniques
- `transform-style: preserve-3d` for 3D boxes
- `clip-path: polygon()` for diamond shapes
- `perspective` for depth perception
- `@keyframes` for all animations
- CSS custom properties for dynamic values

---

## Performance Metrics

### Load Time
- **First Contentful Paint:** ~1.2s
- **Largest Contentful Paint:** ~2.0s
- **Time to Interactive:** ~2.5s

### Bundle Size
- **HTML:** ~7,700 lines
- **CSS:** ~1,000 lines (inline)
- **JS:** ~4,000 lines (inline)
- **Total:** ~250KB (uncompressed)

### External Dependencies (CDN)
- Tailwind CSS v4: ~100KB
- ethers.js 6.7: ~150KB
- React 18: ~40KB
- Babel: ~80KB

---

## Browser Support

| Browser | Status |
|---------|--------|
| Chrome 90+ | ✅ Full support |
| Firefox 90+ | ✅ Full support |
| Safari 15+ | ✅ Full support |
| Edge 90+ | ✅ Full support |
| Mobile Chrome | ✅ Deep-link |
| Mobile Safari | ⚠️ Limited wallet |
| MetaMask Mobile | ✅ Deep-link |
