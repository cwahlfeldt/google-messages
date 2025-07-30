# Installation Guide

This guide provides installation instructions for the Google Messages Desktop App across all supported platforms.

## 🍎 macOS

### Method 1: Homebrew (Recommended)
```bash
# Add the tap (when available)
brew tap YOUR_USERNAME/google-messages-app

# Install the application
brew install --cask google-messages-app
```

### Method 2: Direct Download
1. Download the latest `.dmg` file from [GitHub Releases](https://github.com/YOUR_USERNAME/google-messages-app/releases)
2. Open the `.dmg` file
3. Drag "Google Messages.app" to your Applications folder
4. Launch from Applications or Spotlight

### Method 3: Build from Source
```bash
git clone https://github.com/YOUR_USERNAME/google-messages-app.git
cd google-messages-app
npm install
npm run build:mac
```

## 🐧 Linux

### Method 1: Flatpak (Recommended)
```bash
# Install from Flathub (when available)
flatpak install flathub com.example.GoogleMessagesApp

# Run the application
flatpak run com.example.GoogleMessagesApp
```

### Method 2: Debian/Ubuntu (APT)
```bash
# Add the repository GPG key
wget -qO - https://YOUR_USERNAME.github.io/google-messages-app/gpg.key | sudo apt-key add -

# Add the repository
echo "deb https://YOUR_USERNAME.github.io/google-messages-app/apt stable main" | sudo tee /etc/apt/sources.list.d/google-messages-app.list

# Update package lists and install
sudo apt update
sudo apt install google-messages-app
```

### Method 3: AppImage (Universal)
1. Download the latest `.AppImage` file from [GitHub Releases](https://github.com/YOUR_USERNAME/google-messages-app/releases)
2. Make it executable:
   ```bash
   chmod +x GoogleMessages-v1.0.0-linux.AppImage
   ```
3. Run the application:
   ```bash
   ./GoogleMessages-v1.0.0-linux.AppImage
   ```

### Method 4: Debian Package (.deb)
1. Download the latest `.deb` file from [GitHub Releases](https://github.com/YOUR_USERNAME/google-messages-app/releases)
2. Install using dpkg:
   ```bash
   sudo dpkg -i google-messages-app_1.0.0_amd64.deb
   sudo apt-get install -f  # Fix any dependency issues
   ```

### Method 5: Snap (Ubuntu)
```bash
# Install from Snap Store (when available)
sudo snap install google-messages-app
```

### Method 6: Arch Linux (AUR)
```bash
# Using yay
yay -S google-messages-app

# Using paru
paru -S google-messages-app

# Manual installation
git clone https://aur.archlinux.org/google-messages-app.git
cd google-messages-app
makepkg -si
```

## 🪟 Windows

### Method 1: Chocolatey
```powershell
# Install using Chocolatey (when available)
choco install google-messages-app
```

### Method 2: Winget (Windows Package Manager)
```powershell
# Install using winget (when available)
winget install YourName.GoogleMessagesApp
```

### Method 3: Direct Download
1. Download the latest `.exe` installer from [GitHub Releases](https://github.com/YOUR_USERNAME/google-messages-app/releases)
2. Run the installer as Administrator
3. Follow the installation wizard
4. Launch from Start Menu or Desktop shortcut

### Method 4: Microsoft Store
*Coming soon - pending Microsoft Store approval*

## 🔧 Build from Source (All Platforms)

### Prerequisites
- Node.js 16 or later
- npm or yarn
- Git

### Steps
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/google-messages-app.git
cd google-messages-app

# Install dependencies
npm install

# Development mode
npm start

# Build for your platform
npm run build

# Build for specific platforms
npm run build:mac     # macOS
npm run build:win     # Windows
npm run build:linux   # Linux
```

## 🚀 First Launch

1. **Grant Permissions**: The app may request permission for notifications
2. **System Tray**: Look for the Google Messages icon in your system tray
3. **Keyboard Shortcuts**: See the View menu for available shortcuts
4. **Auto-start**: Configure in your system's startup applications if desired

## 🔄 Updates

### Automatic Updates
The app includes built-in update checking and will notify you when updates are available.

### Manual Updates

**macOS (Homebrew):**
```bash
brew upgrade --cask google-messages-app
```

**Linux (Flatpak):**
```bash
flatpak update com.example.GoogleMessagesApp
```

**Linux (APT):**
```bash
sudo apt update && sudo apt upgrade google-messages-app
```

**Windows (Chocolatey):**
```powershell
choco upgrade google-messages-app
```

**Windows (Winget):**
```powershell
winget upgrade YourName.GoogleMessagesApp
```

## 🛠️ Troubleshooting

### App Won't Start
- **Check Node.js version**: Ensure Node.js 16+ is installed
- **Clear cache**: Delete application data folder
  - macOS: `~/Library/Application Support/google-messages-app`
  - Linux: `~/.config/google-messages-app`
  - Windows: `%APPDATA%\google-messages-app`

### Notifications Not Working
- **Check permissions**: Ensure notification permissions are granted
- **System settings**: Check your OS notification settings
- **Restart app**: Try closing and reopening the application

### System Tray Missing
- **Linux**: Install `libappindicator3-1` package
- **Windows**: Check if system tray is enabled in Windows settings
- **macOS**: Check menu bar settings

### Build Issues
- **Clear dependencies**: `rm -rf node_modules && npm install`
- **Update tools**: Ensure latest versions of Node.js and npm
- **Platform tools**: Install platform-specific build tools

### Permission Errors (Linux)
```bash
# Fix AppImage permissions
chmod +x GoogleMessages-*.AppImage

# Fix .deb installation
sudo apt-get install -f
```

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/google-messages-app/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/google-messages-app/discussions)
- **Documentation**: [README.md](./README.md)

## 📋 System Requirements

### Minimum Requirements
- **macOS**: 10.11 El Capitan or later
- **Windows**: Windows 7 or later (Windows 10 recommended)
- **Linux**: Most modern distributions with X11 or Wayland

### Recommended Requirements
- **RAM**: 2GB available memory
- **Storage**: 200MB free disk space
- **Network**: Active internet connection
- **Display**: 1024x768 minimum resolution

## 🔒 Security Notes

- The app uses Google's official web interface
- No Google credentials are stored locally
- All authentication is handled by Google
- The app follows Electron security best practices
- Regular security updates are provided

## 📝 Uninstall Instructions

### macOS
```bash
# Homebrew
brew uninstall --cask google-messages-app

# Manual
rm -rf /Applications/Google\ Messages.app
rm -rf ~/Library/Application\ Support/google-messages-app
```

### Linux
```bash
# Flatpak
flatpak uninstall com.example.GoogleMessagesApp

# APT
sudo apt remove google-messages-app

# AppImage
rm GoogleMessages-*.AppImage
```

### Windows
```powershell
# Chocolatey
choco uninstall google-messages-app

# Winget
winget uninstall YourName.GoogleMessagesApp

# Manual: Use Windows "Add or Remove Programs"
```