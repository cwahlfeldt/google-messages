# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Electron-based desktop application that wraps Google Messages (messages.google.com) in a native desktop interface. The app acts as a secure web wrapper with desktop integration features like system tray, notifications, and keyboard shortcuts.

## Architecture

### Core Application Structure
- **main.js**: Main Electron process that creates the application window, handles system tray, menus, and window lifecycle
- **preload.js**: Security-focused preload script that exposes limited APIs to the renderer with context isolation enabled
- **Web Content**: Loads Google Messages directly from messages.google.com/web - no local web assets

### Key Architectural Decisions
- **Security-First**: Node integration disabled, context isolation enabled, external URLs open in default browser
- **Desktop Integration**: System tray with show/hide, native notifications, platform-specific menus
- **Cross-Platform**: Configured for macOS, Windows, and Linux with platform-specific behaviors (e.g., macOS hides to tray on minimize)

### Distribution Infrastructure
The project includes comprehensive multi-platform distribution setup:
- **packaging/**: Contains package manager configurations (Homebrew, Flatpak, Debian, Chocolatey, Winget)
- **.github/workflows/**: Automated CI/CD pipeline for building and releasing across all platforms
- **scripts/**: Helper scripts for environment setup, certificate encoding, and build validation

## Essential Commands

### Development
```bash
npm start                    # Launch app in development mode
npm run dev                  # Launch with --dev flag
```

### Building
```bash
npm run build               # Build for current platform
npm run build:mac           # Build macOS DMG
npm run build:win           # Build Windows installer (NSIS)
npm run build:linux         # Build Linux AppImage and DEB
```

### Environment Setup
```bash
cp .env.example .env        # Copy environment template
./scripts/setup-env.sh      # Interactive setup guide
./scripts/validate-build.sh # Validate build environment
./scripts/encode-certificate.sh # Helper for certificate encoding
```

### Release Process
```bash
git tag v1.0.0             # Create version tag
git push origin v1.0.0     # Push tag (triggers CI/CD pipeline)
```

## Code Signing and Distribution

### Requirements for Full Distribution
- **macOS**: Apple Developer account ($99/year) required for code signing and notarization
- **Windows**: Code signing certificate recommended for trust
- **Linux**: No signing required, but GPG signing available for APT packages

### Environment Variables (see .env.example)
All sensitive credentials are managed through environment variables:
- Apple Developer credentials and certificates (base64 encoded)
- Windows code signing certificates
- GitHub tokens for releases and package manager updates
- Package manager API keys (Chocolatey, etc.)

### CI/CD Pipeline
GitHub Actions workflow triggers on version tags and:
1. Builds for all platforms (macOS, Windows, Linux)
2. Code signs applications (when certificates available)
3. Creates GitHub releases with platform-specific installers
4. Updates package managers automatically where possible

## Security Model

### Electron Security
- Node integration disabled in renderer process
- Context isolation enabled
- Preload script provides minimal, safe API surface
- External links automatically open in default browser
- Content Security Policy configured for Google Messages domain

### Certificate Management
- All certificates stored as base64-encoded GitHub secrets
- Helper scripts provided for secure certificate encoding
- Temporary keychains used during CI builds
- No certificates or private keys stored in repository

## Development Workflow

### Local Development
The app loads Google Messages directly from the web, so local development requires internet connection. The preload script adds minimal desktop integration features like custom scrollbars and version information.

### Testing Distribution
Use the validation script to ensure all build dependencies and environment variables are properly configured before attempting distribution builds.

### Adding New Features
Most functionality comes from Google's web interface. Desktop integration features (notifications, shortcuts, tray behavior) are implemented in main.js. Any renderer process communication should go through the secure preload script.