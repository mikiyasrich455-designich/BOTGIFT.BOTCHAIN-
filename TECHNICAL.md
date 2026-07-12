# Technical Documentation

## Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| UI Framework | React | 18 (UMD production) |
| CSS Framework | Tailwind CSS | v4 (browser build) |
| Blockchain | ethers.js | v6.7.0 |
| Database | Supabase JS | v2 |
| Transpiler | Babel Standalone | Latest |
| Fonts | Inter + Playfair Display | Google Fonts |
| IPFS | Pinata | JWT-based API |
| Hosting | Vercel | Static |

## Key Libraries (CDN)

```html
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ethers/6.7.0/ethers.umd.min.js"></script>
<script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
```

## Configuration Constants

```javascript
// BOT Chain Testnet
const CHAIN_ID = 968;                    // 0x3C8
const RPC_URL = 'https://rpc.bohr.life';
const EXPLORER = 'https://scan.bohr.life';

// Smart Contract
const SBT_CONTRACT_ADDRESS = '0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16';
const CLAIM_GAS_GRANT = '0.02';          // BOT sent to cover claim gas

// Supabase
const SG_SUPABASE_URL = 'https://vjljoydtwvpvhqiecbqr.supabase.co';
const SG_SUPABASE_KEY = 'eyJ...';

// Pinata IPFS
const PINATA_JWT = 'eyJ...';
const PINATA_GATEWAY = 'https://gateway.pinata.cloud/ipfs/';
```

## Encryption System (Secret Gift)

### Algorithm
- **Cipher:** AES-256-GCM
- **Key Derivation:** PBKDF2
- **Iterations:** 100,000
- **Output Format:** Base64 (salt + iv + ciphertext + auth tag)

### Functions

```javascript
// Encrypt vault private key with claim code
async function encryptAES(text, password) {
    const salt = crypto.getRandomValues(new Uint8Array(16));
    const iv = crypto.getRandomValues(new Uint8Array(12));
    const key = await deriveKey(password, salt);
    const encrypted = await crypto.subtle.encrypt(
        { name: 'AES-GCM', iv },
        key,
        new TextEncoder().encode(text)
    );
    return btoa(String.fromCharCode(...salt, ...iv, ...new Uint8Array(encrypted)));
}

// Decrypt vault private key with claim code
async function decryptAES(encryptedBase64, password) {
    const data = Uint8Array.from(atob(encryptedBase64), c => c.charCodeAt(0));
    const salt = data.slice(0, 16);
    const iv = data.slice(16, 28);
    const ciphertext = data.slice(28);
    const key = await deriveKey(password, salt);
    const decrypted = await crypto.subtle.decrypt(
        { name: 'AES-GCM', iv },
        key,
        ciphertext
    );
    return new TextDecoder().decode(decrypted);
}
```

### Claim Code Format
- Pattern: `SG-XXXX-XXXX`
- Characters: `ABCDEFGHJKLMNPQRSTUVWXYZ23456789` (no confusing chars like I/1/O/0)
- Length: 13 characters total

## IPFS Integration

### Upload Image
```javascript
async function uploadImageToPinata(file) {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('pinataMetadata', JSON.stringify({
        name: `gift-${Date.now()}`
    }));
    const res = await fetch('https://api.pinata.cloud/pinning/pinFileToIPFS', {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${PINATA_JWT}` },
        body: formData
    });
    const data = await res.json();
    return data.IpfsHash;
}
```

### Upload Metadata
```javascript
async function uploadMetadataToPinata(metadata) {
    const res = await fetch('https://api.pinata.cloud/pinning/pinJSONToIPFS', {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${PINATA_JWT}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            pinataContent: metadata,
            pinataMetadata: { name: `gift-meta-${Date.now()}` }
        })
    });
    const data = await res.json();
    return data.IpfsHash;
}
```

### Metadata Format
```json
{
    "name": "GIFT BOT Gift",
    "description": "A Soulbound NFT gift on BOT Chain",
    "image": "ipfs://Qm... (image hash)",
    "attributes": [
        { "trait_type": "Amount", "value": "1.5 BOT" },
        { "trait_type": "Sender", "value": "0x1234...abcd" },
        { "trait_type": "Message", "value": "Happy Birthday!" },
        { "trait_type": "Network", "value": "BOT Chain Testnet" }
    ]
}
```

## Supabase Integration

### Table Schema
```sql
CREATE TABLE secret_gifts (
    id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    code         TEXT UNIQUE NOT NULL,
    amount       NUMERIC NOT NULL,
    sender       TEXT NOT NULL,
    sender_name  TEXT DEFAULT '',
    recipient    TEXT DEFAULT '',
    message      TEXT DEFAULT '',
    image_url    TEXT DEFAULT '',
    encrypted_pk TEXT DEFAULT '',
    claimed      BOOLEAN DEFAULT false,
    claimed_by   TEXT DEFAULT '',
    claimed_at   TIMESTAMPTZ,
    created_at   TIMESTAMPTZ DEFAULT now()
);
```

### CRUD Functions
```javascript
// Store new gift
async function sgStoreGift(giftData) {
    const { data, error } = await sgDB
        .from('secret_gifts')
        .insert(giftData);
    return { data, error };
}

// Lookup by claim code
async function sgLookupGift(code) {
    const { data, error } = await sgDB
        .from('secret_gifts')
        .select('*')
        .eq('code', code)
        .single();
    return { data, error };
}

// Mark as claimed
async function sgMarkClaimed(code, claimerAddress) {
    const { data, error } = await sgDB
        .from('secret_gifts')
        .update({
            claimed: true,
            claimed_by: claimerAddress,
            claimed_at: new Date().toISOString()
        })
        .eq('code', code);
    return { data, error };
}
```

## Blockchain Integration

### Wallet Connection
```javascript
async function connectWallet() {
    if (!window.ethereum) {
        alert('Please install MetaMask');
        return;
    }
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const address = await signer.getAddress();

    // Switch to BOT Chain Testnet
    await window.ethereum.request({
        method: 'wallet_switchEthereumChain',
        params: [{ chainId: '0x3C8' }]
    });

    window.systemProvider = provider;
    window.systemSigner = signer;
    window.realWalletAddress = address;
}
```

### Gift Sweep (Secret Claim)
```javascript
async function sweepVaultToClaimer(vaultPrivateKey, claimerAddress) {
    const vaultWallet = new ethers.Wallet(vaultPrivateKey, systemProvider);
    const balance = await systemProvider.getBalance(vaultWallet.address);
    const gasPrice = await systemProvider.getFeeData();
    const gasCost = 21000n * gasPrice.gasPrice;
    const sendAmount = balance - gasCost;

    const tx = await vaultWallet.sendTransaction({
        to: claimerAddress,
        value: sendAmount
    });
    await tx.wait();
    return tx.hash;
}
```

## Mobile Responsive System

### CSS Media Query Strategy
- **Base styles:** Desktop-first (left-aligned hero, side-by-side buttons)
- **`@media (max-width: 768px)`:** Mobile overrides (centered layout, stacked buttons, bg image)
- **`@media (max-width: 400px)`:** Small phone adjustments (smaller fonts, tighter spacing)

### Mobile-Specific Features
- Bottom navigation bar with safe-area padding
- Top wallet bar (compact)
- Touch-optimized tap targets (44px minimum)
- PWA meta tags (apple-mobile-web-app-capable)
- Viewport lock (no pinch-to-zoom)
- Background: Gift box hero image (center 60%)
- Non-home pages: Dark solid background
- Glass panels with increased blur

### Background System
```
Desktop:  PC hero image (center center, cover)
Mobile:   Gift box hero image (center 60%, cover)
          + dark gradient overlay on non-home pages
```
