# Google Messages Desktop App

A desktop application for Google Messages built with Electron, providing a native desktop experience for Google's web-based messaging service.

## Features

- **Native Desktop Experience**: Dedicated window for Google Messages without browser tabs
- **System Tray Integration**: Minimize to system tray with click-to-show/hide functionality
- **Keyboard Shortcuts**: 
  - `Cmd/Ctrl+N` - New message
  - `Cmd/Ctrl+R` - Reload
  - `F12` - Developer tools
  - Standard copy/paste/select all shortcuts
- **Desktop Notifications**: Native notification support
- **Cross-Platform**: Works on macOS, Windows, and Linux
- **Auto-hide on minimize**: App hides to tray instead of staying in dock/taskbar (macOS)
- **Zoom Controls**: Built-in zoom in/out functionality
- **External Link Handling**: Opens external links in default browser

## Installation

### Prerequisites
- Node.js (v16 or later)
- npm

### Quick Setup
```bash
# Clone and install
git clone https://github.com/YOUR_USERNAME/google-messages-app.git
cd google-messages-app
npm install

# Set up environment (optional - for distribution)
cp .env.example .env
chmod +x scripts/*.sh
./scripts/setup-env.sh
```

### Install Dependencies
```bash
npm install
```

## Usage

### Development Mode
```bash
npm start
# or
npm run dev
```

### Building for Distribution

Build for current platform:
```bash
npm run build
```

Build for specific platforms:
```bash
npm run build:mac    # macOS
npm run build:win    # Windows
npm run build:linux  # Linux
```

Built applications will be available in the `dist/` directory.

## Project Structure

```
google-messages-app/
├── package.json          # Project configuration and dependencies
├── main.js              # Main Electron process
├── preload.js           # Preload script for security
├── assets/
│   └── icon.png         # Application icon
├── build/               # Build configurations (auto-generated)
└── dist/                # Built applications (auto-generated)
```

## Security Features

- **Context Isolation**: Enabled for security
- **Node Integration**: Disabled in renderer process
- **External Link Protection**: External URLs open in default browser
- **Content Security Policy**: Configured for Google Messages

## System Requirements

- **macOS**: 10.11 or later
- **Windows**: Windows 7 or later
- **Linux**: Most modern distributions

## How It Works

This application is a web wrapper that loads Google Messages (https://messages.google.com) in a dedicated Electron window. It does not modify or access Google's code - all authentication and messaging functionality is handled by Google's existing web interface.

The app provides desktop integration features like:
- Native window management
- System tray integration
- Keyboard shortcuts
- Desktop notifications
- Native menus

## Distribution Setup

For distributing the app through package managers and app stores, see:
- **[DISTRIBUTION-PLAN.md](./DISTRIBUTION-PLAN.md)** - Complete distribution strategy
- **[INSTALLATION.md](./INSTALLATION.md)** - User installation guide
- **Environment Setup**: Run `./scripts/setup-env.sh` for guided setup

### Quick Distribution Setup
```bash
# Set up environment variables
cp .env.example .env
# Edit .env with your certificates and API keys

# Validate build environment
./scripts/validate-build.sh

# Encode certificates for GitHub Secrets
./scripts/encode-certificate.sh

# Create a release (triggers CI/CD)
git tag v1.0.0
git push origin v1.0.0
```

## Troubleshooting

### App won't start
- Ensure Node.js is installed (`node --version`)
- Try reinstalling dependencies: `rm -rf node_modules && npm install`
- Run validation: `./scripts/validate-build.sh`

### Notifications not working
- Check system notification permissions for the app
- The app requests notification permission on first load

### Build fails
- Ensure you have the latest version of electron-builder
- Check that all dependencies are installed: `npm install`
- Validate environment: `./scripts/validate-build.sh`

### Distribution issues
- Verify all environment variables in `.env`
- Check GitHub Secrets are properly set
- Review certificate encoding with `./scripts/encode-certificate.sh`

## License

MIT License - See LICENSE file for details.

## Disclaimer

This is an unofficial desktop wrapper for Google Messages. Google Messages and all related trademarks are property of Google LLC. This application is not affiliated with or endorsed by Google.