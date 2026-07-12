# Contributing

Thanks for your interest in contributing to GIFT BOT!

## How to Contribute

### 1. Fork the Repository
```bash
git clone https://github.com/YOUR-USERNAME/gift-bot.git
cd gift-bot
```

### 2. Create a Branch
```bash
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes
- Edit `index.html` for UI/logic changes
- Edit `setup.sql` for database schema changes
- Keep all changes in the single-file architecture

### 4. Test Locally
```bash
npx serve .
```
Open `http://localhost:8000` and test your changes.

### 5. Commit and Push
```bash
git add .
git commit -m "Add your feature description"
git push origin feature/your-feature-name
```

### 6. Open a Pull Request
- Go to the original repo on GitHub
- Click **New Pull Request**
- Select your branch
- Describe your changes
- Submit

## Development Guidelines

### Code Style
- Use Tailwind CSS classes for styling
- Use React functional components with hooks
- Keep JavaScript in `<script type="text/babel">` blocks
- Use `!important` sparingly (only in mobile CSS overrides)

### Single-File Architecture
GIFT BOT is intentionally a single `index.html` file. When adding features:
- Add HTML in the appropriate `<div>` view section
- Add CSS in the `<style>` block
- Add JS in a `<script type="text/babel">` block
- Keep the file organized with section comments

### Mobile Responsiveness
All new features must work on both desktop and mobile:
- Use responsive Tailwind classes (`md:`, `sm:`)
- Add CSS overrides in the `@media (max-width: 768px)` block
- Ensure 44px minimum tap targets
- Test with MetaMask Mobile

### Blockchain Integration
- Use ethers.js v6.7 API
- Handle errors gracefully (user rejections, network issues)
- Always show loading states during transactions
- Never expose private keys in logs

### Database Changes
- If modifying the `secret_gifts` table, update `setup.sql`
- Maintain backward compatibility with existing data
- Test both new and existing gift flows

## Reporting Issues

When reporting bugs, include:
1. Browser and version
2. Device (desktop/mobile)
3. Steps to reproduce
4. Expected behavior
5. Actual behavior
6. Console errors (if any)

## Feature Requests

Open an issue with:
- Clear description of the feature
- Use case (why it's needed)
- Expected behavior
- Any design mockups

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
