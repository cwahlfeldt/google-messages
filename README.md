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

## Troubleshooting

### App won't start
- Ensure Node.js is installed (`node --version`)
- Try reinstalling dependencies: `rm -rf node_modules && npm install`

### Notifications not working
- Check system notification permissions for the app
- The app requests notification permission on first load

### Build fails
- Ensure you have the latest version of electron-builder
- Check that all dependencies are installed: `npm install`

## License

MIT License - See LICENSE file for details.

## Disclaimer

This is an unofficial desktop wrapper for Google Messages. Google Messages and all related trademarks are property of Google LLC. This application is not affiliated with or endorsed by Google.