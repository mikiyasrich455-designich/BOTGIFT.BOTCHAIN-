# 🤝 Contributing to GIFT BOT

Thanks for your interest in contributing! Here's how to get started.

---

## 🐛 Found a Bug?

1. Check [existing issues](https://github.com/yourusername/gift-bot/issues) first
2. If not found, open a new issue with:
   - Clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Browser/OS info

---

## 💡 Suggest a Feature

1. Open an issue with label `enhancement`
2. Describe the feature and use case
3. Explain why it fits GIFT BOT's mission

---

## 🔧 Submit a Pull Request

### Setup

```bash
git clone https://github.com/yourusername/gift-bot.git
cd gift-bot
# No build step needed — single HTML file
```

### Guidelines

- **Single file architecture** — keep `index.html` self-contained
- **No external dependencies** — everything via CDN
- **Follow existing code style** — match indentation, naming
- **Test on multiple browsers** — Chrome, Firefox, Safari, Mobile
- **Don't break wallet connection** — MetaMask flow is critical

### PR Checklist

- [ ] Code works in Chrome and Firefox
- [ ] Mobile responsive
- [ ] No console errors
- [ ] Wallet connect/disconnect works
- [ ] Gift send flow complete
- [ ] Gift claim flow complete
- [ ] History loads correctly

---

## 📝 Code Style

- Use `camelCase` for variables/functions
- Use `PascalCase` for React components
- 4-space indentation
- Comments for complex logic
- No global variable pollution (use IIFE scope)

---

## 🎨 Adding a New Gift Type

1. Add theme colors in `giftThemeColor()`
2. Add icon in `giftIconFor()`
3. Add card in HTML gift grid
4. Add animation CSS (keyframes + classes)
5. Add renderer in `renderThemedGiftBox()`
6. Add form theme in `getGiftFormTheme()`
7. Test claim flow end-to-end

---

## ❓ Questions?

Open an issue with label `question` or reach out directly.

---

Thank you for contributing! 🎁
