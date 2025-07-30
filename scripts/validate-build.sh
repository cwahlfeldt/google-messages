#!/bin/bash

# Build Validation Script
# Validates that all required environment variables and tools are set up

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

echo "🔍 Build Environment Validation"
echo "==============================="
echo ""

# Track validation status
validation_passed=true

# Load .env file if it exists
if [ -f .env ]; then
    print_step "Loading .env file"
    set -a
    source .env
    set +a
    print_success ".env file loaded"
else
    print_warning ".env file not found (using system environment variables only)"
fi

echo ""
print_step "Checking Required Tools"

# Check Node.js
if command -v node &> /dev/null; then
    node_version=$(node --version)
    print_success "Node.js: $node_version"
    
    # Check if version is 16 or higher
    node_major=$(echo $node_version | cut -d'.' -f1 | cut -d'v' -f2)
    if [ "$node_major" -lt 16 ]; then
        print_error "Node.js version 16 or higher required (found: $node_version)"
        validation_passed=false
    fi
else
    print_error "Node.js not found"
    validation_passed=false
fi

# Check npm
if command -v npm &> /dev/null; then
    npm_version=$(npm --version)
    print_success "npm: v$npm_version"
else
    print_error "npm not found"
    validation_passed=false
fi

# Check if we're in a Git repository
if git rev-parse --git-dir > /dev/null 2>&1; then
    print_success "Git repository detected"
    
    # Check for GitHub remote
    if git remote get-url origin &> /dev/null; then
        remote_url=$(git remote get-url origin)
        if [[ $remote_url == *"github.com"* ]]; then
            print_success "GitHub remote configured: $remote_url"
        else
            print_warning "Non-GitHub remote detected: $remote_url"
        fi
    else
        print_warning "No Git remote configured"
    fi
else
    print_error "Not in a Git repository"
    validation_passed=false
fi

echo ""
print_step "Checking Platform-Specific Tools"

# macOS specific tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_step "macOS detected - checking code signing tools"
    
    if command -v security &> /dev/null; then
        print_success "Keychain tools available"
    else
        print_error "Keychain tools not found"
        validation_passed=false
    fi
    
    if command -v codesign &> /dev/null; then
        print_success "Code signing tools available"
    else
        print_error "Code signing tools not found"
        validation_passed=false
    fi
fi

# Windows specific tools
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    print_step "Windows detected - checking signing tools"
    # Windows-specific validation would go here
fi

echo ""
print_step "Checking Package Dependencies"

if [ -f package.json ]; then
    print_success "package.json found"
    
    # Check if node_modules exists
    if [ -d node_modules ]; then
        print_success "Dependencies installed"
        
        # Check specific dependencies
        if [ -d node_modules/electron ]; then
            electron_version=$(npm list electron --depth=0 2>/dev/null | grep electron | cut -d'@' -f2 || echo "unknown")
            print_success "Electron: $electron_version"
        else
            print_error "Electron not installed"
            validation_passed=false
        fi
        
        if [ -d node_modules/electron-builder ]; then
            builder_version=$(npm list electron-builder --depth=0 2>/dev/null | grep electron-builder | cut -d'@' -f2 || echo "unknown")
            print_success "electron-builder: $builder_version"
        else
            print_error "electron-builder not installed"
            validation_passed=false
        fi
    else
        print_error "Dependencies not installed (run: npm install)"
        validation_passed=false
    fi
else
    print_error "package.json not found"
    validation_passed=false
fi

echo ""
print_step "Checking Environment Variables for Distribution"

# Apple Developer variables
if [ -n "$APPLE_ID" ]; then
    print_success "APPLE_ID configured"
else
    print_warning "APPLE_ID not set (required for macOS distribution)"
fi

if [ -n "$TEAM_ID" ]; then
    print_success "TEAM_ID configured"
else
    print_warning "TEAM_ID not set (required for macOS distribution)"
fi

if [ -n "$APPLE_CERT_DATA" ]; then
    print_success "APPLE_CERT_DATA configured"
else
    print_warning "APPLE_CERT_DATA not set (required for macOS signing)"
fi

# Windows signing variables
if [ -n "$WIN_CSC_LINK" ]; then
    print_success "WIN_CSC_LINK configured"
else
    print_warning "WIN_CSC_LINK not set (required for Windows signing)"
fi

# GitHub token
if [ -n "$GITHUB_TOKEN" ]; then
    print_success "GITHUB_TOKEN configured"
else
    print_warning "GITHUB_TOKEN not set (required for releases)"
fi

echo ""
print_step "Checking Build Configuration"

# Check if build scripts exist in package.json
if [ -f package.json ]; then
    if grep -q '"build"' package.json; then
        print_success "Build script configured"
    else
        print_error "Build script not found in package.json"
        validation_passed=false
    fi
    
    if grep -q '"build:mac"' package.json; then
        print_success "macOS build script configured"
    else
        print_warning "macOS build script not found"
    fi
    
    if grep -q '"build:win"' package.json; then
        print_success "Windows build script configured"
    else
        print_warning "Windows build script not found"
    fi
    
    if grep -q '"build:linux"' package.json; then
        print_success "Linux build script configured"
    else
        print_warning "Linux build script not found"
    fi
fi

echo ""
print_step "Checking GitHub Actions"

if [ -f .github/workflows/build-and-release.yml ]; then
    print_success "GitHub Actions workflow configured"
else
    print_error "GitHub Actions workflow not found"
    validation_passed=false
fi

echo ""
print_step "Validation Summary"

if [ "$validation_passed" = true ]; then
    print_success "All critical validations passed! ✨"
    echo ""
    print_step "You can now:"
    echo "• Run local builds: npm run build"
    echo "• Test the app: npm start"
    echo "• Create a release: git tag v1.0.0 && git push origin v1.0.0"
else
    print_error "Some validations failed. Please fix the issues above."
    echo ""
    print_step "Common fixes:"
    echo "• Install dependencies: npm install"
    echo "• Set up environment: cp .env.example .env"
    echo "• Configure GitHub secrets"
    echo "• Install required tools (Node.js 16+, Git)"
    exit 1
fi

echo ""
print_step "Optional GitHub CLI Commands:"
if command -v gh &> /dev/null; then
    print_success "GitHub CLI available"
    echo "• View secrets: gh secret list"
    echo "• Check workflow runs: gh run list"
    echo "• View releases: gh release list"
else
    print_warning "GitHub CLI not installed (optional but recommended)"
    echo "• Install: brew install gh (macOS) or see https://cli.github.com"
fi

echo ""
print_success "Validation completed! 🎉"