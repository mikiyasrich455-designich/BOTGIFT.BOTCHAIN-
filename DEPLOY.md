# Deployment Guide

## Prerequisites

- [Node.js](https://nodejs.org) (v18+)
- [Vercel CLI](https://vercel.com/docs/cli) (`npm i -g vercel`)
- [MetaMask](https://metamask.io) browser extension
- Supabase account
- Pinata account (for IPFS)

## Quick Deploy

### Option 1: Vercel CLI
```bash
# Clone the repo
git clone https://github.com/YOUR-USERNAME/gift-bot.git
cd gift-bot

# Deploy to Vercel
npx vercel --prod
```

### Option 2: Vercel Dashboard
1. Push to GitHub
2. Go to [vercel.com/new](https://vercel.com/new)
3. Import your GitHub repo
4. Framework Preset: **Other**
5. Click **Deploy**

### Option 3: Manual Upload
1. Go to [vercel.com/new](https://vercel.com/new)
2. Drag and drop the entire `gift-bot` folder
3. Click **Deploy**

## Environment Setup

### 1. Supabase Database

1. Go to [supabase.com/dashboard](https://supabase.com/dashboard)
2. Create a new project (or use existing)
3. Open **SQL Editor**
4. Run `setup.sql`:
```sql
DROP TABLE IF EXISTS secret_gifts;

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

ALTER TABLE secret_gifts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all" ON secret_gifts FOR ALL USING (true) WITH CHECK (true);
```

5. Go to **Settings → API** and copy:
   - Project URL
   - Anon public key

### 2. Pinata IPFS

1. Go to [pinata.cloud](https://pinata.cloud)
2. Create account / sign in
3. Go to **API Keys → New Key**
4. Select permissions: `pinFileToIPFS`, `pinJSONToIPFS`
5. Copy the JWT token

### 3. Update Configuration

Open `index.html` and update these lines:

```javascript
// Line ~4866 — Supabase
const SG_SUPABASE_URL = 'https://YOUR_PROJECT.supabase.co';
const SG_SUPABASE_KEY = 'YOUR_ANON_KEY';

// Line ~4860 — Pinata
const PINATA_JWT = 'YOUR_PINATA_JWT';
```

### 4. BOT Chain Testnet

The smart contract is already deployed at:
```
0x740e1ce98364EfF4d5e3d89b2b1fa513e0F75b16
```

No deployment needed. Just configure MetaMask:

| Field | Value |
|-------|-------|
| Network Name | BOT Chain Testnet |
| Chain ID | 968 |
| RPC URL | https://rpc.bohr.life |
| Currency Symbol | BOT |
| Explorer URL | https://scan.bohr.life |

## Local Development

```bash
# Serve locally (no build needed)
npx serve .

# Or with Python
python -m http.server 8000

# Or with PHP
php -S localhost:8000
```

Open `http://localhost:8000` in your browser.

## Custom Domain

1. Go to your Vercel project settings
2. Click **Domains**
3. Add your custom domain
4. Configure DNS as instructed by Vercel

## Troubleshooting

### "Failed to fetch" on Supabase
- Check your Supabase URL and key
- Ensure the `secret_gifts` table exists
- Check RLS policies are correct

### Wallet not connecting
- Ensure MetaMask is installed
- Check BOT Chain Testnet is added
- Try refreshing the page

### IPFS upload failing
- Check Pinata JWT is valid
- Ensure API key has correct permissions
- Check file size (Pinata free tier: 100MB)

### Background image not loading on mobile
- Check the Cloudinary URL is accessible
- Clear browser cache
- Check mobile data/WiFi connection
