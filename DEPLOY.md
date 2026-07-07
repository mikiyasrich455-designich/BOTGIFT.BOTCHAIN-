# 🚀 Deployment Guide

## Option 1: GitHub Pages (Recommended)

### Steps

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: GIFT BOT"
   git remote add origin https://github.com/yourusername/gift-bot.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to your repo → Settings → Pages
   - Source: Deploy from a branch
   - Branch: `main` / `/ (root)`
   - Click Save

3. **Access your site**
   ```
   https://yourusername.github.io/gift-bot/
   ```

---

## Option 2: Netlify

### Steps

1. **Drag & Drop**
   - Go to [netlify.com](https://netlify.com)
   - Drag the `gift-bot` folder onto the deploy area
   - Done! Get your live URL instantly

2. **Or connect GitHub repo**
   - New site from Git → Select your repo
   - Build command: (leave empty)
   - Publish directory: `.` or `/`
   - Deploy

---

## Option 3: Vercel

### Steps

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Deploy**
   ```bash
   cd gift-bot
   vercel
   ```

3. **Follow prompts**
   - Link to repo? No
   - Override settings? No
   - Done!

---

## Option 4: Local Server (Development)

### Python
```bash
cd gift-bot
python -m http.server 8000
# Open http://localhost:8000
```

### Node.js
```bash
npx serve .
# Open http://localhost:3000
```

### PHP
```bash
php -S localhost:8000
# Open http://localhost:8000
```

---

## ⚠️ Important Notes

### Must Use HTTP
MetaMask requires a secure context. **Do not** open `index.html` directly via `file://` protocol.

### MetaMask Deep-Linking
On mobile, the app auto-detects MetaMask and deep-links to the mobile app when possible.

### BOT Chain Testnet
Ensure your MetaMask is connected to BOT Chain Testnet:
- **Chain ID:** `0x3C8`
- **RPC:** `https://rpc.bohr.life`
- **Explorer:** `https://scan.bohr.life`

The app auto-prompts to add/switch to BOT Chain on first connect.

---

## 🔐 Security Notes

- API keys (Groq, Pinata) are client-side for demo purposes
- For production, move API keys to a serverless function
- The smart contract is deployed on BOT Chain Testnet
- No user data is collected or stored externally
