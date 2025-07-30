#!/bin/bash

# Google Messages App - Environment Setup Script
# This script helps set up the development environment and GitHub Secrets

set -e

echo "🚀 Google Messages App - Environment Setup"
echo "=========================================="

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

# Check if .env exists
if [ ! -f .env ]; then
    print_step "Creating .env file from .env.example"
    cp .env.example .env
    print_success ".env file created"
else
    print_warning ".env file already exists"
fi

print_step "Environment Setup Checklist"
echo ""

echo "1. 🍎 APPLE DEVELOPER SETUP (for macOS builds)"
echo "   - Sign up for Apple Developer Program (\$99/year)"
echo "   - Create Developer ID Application certificate"
echo "   - Generate App-Specific Password"
echo "   - Export certificate as .p12 and base64 encode it"
echo ""

echo "2. 🪟 WINDOWS CODE SIGNING (for Windows builds)"
echo "   - Purchase code signing certificate from trusted CA"
echo "   - Export as .p12 file and base64 encode it"
echo "   - Consider Extended Validation (EV) certificate"
echo ""

echo "3. 🔑 GITHUB SECRETS SETUP"
echo "   Required secrets for GitHub Actions:"
echo "   - APPLE_ID"
echo "   - APPLE_ID_PASS"
echo "   - TEAM_ID"
echo "   - APPLE_CERT_DATA"
echo "   - APPLE_CERT_PASSWORD"
echo "   - KEYCHAIN_PASSWORD"
echo "   - WIN_CSC_LINK"
echo "   - WIN_CSC_KEY_PASSWORD"
echo "   - HOMEBREW_GITHUB_API_TOKEN"
echo ""

echo "4. 📦 PACKAGE MANAGER ACCOUNTS"
echo "   - Chocolatey.org account (Windows)"
echo "   - Flathub account (Linux)"
echo ""

# Check if GitHub CLI is available
if command -v gh &> /dev/null; then
    print_step "GitHub CLI detected. Would you like to set up secrets now? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo ""
        print_step "Setting up GitHub secrets (you'll be prompted for each value)"
        
        # Check if we're in a git repository with GitHub remote
        if git remote get-url origin &> /dev/null; then
            REPO_URL=$(git remote get-url origin)
            if [[ $REPO_URL == *"github.com"* ]]; then
                print_success "GitHub repository detected: $REPO_URL"
                
                echo ""
                print_warning "You'll be prompted to enter each secret value."
                print_warning "Press Enter to skip any secret you don't have yet."
                echo ""
                
                # Apple Developer secrets
                echo "🍎 Apple Developer Secrets:"
                gh secret set APPLE_ID --body ""
                gh secret set APPLE_ID_PASS --body ""
                gh secret set TEAM_ID --body ""
                gh secret set APPLE_CERT_DATA --body ""
                gh secret set APPLE_CERT_PASSWORD --body ""
                gh secret set KEYCHAIN_PASSWORD --body ""
                
                # Windows signing secrets
                echo ""
                echo "🪟 Windows Code Signing Secrets:"
                gh secret set WIN_CSC_LINK --body ""
                gh secret set WIN_CSC_KEY_PASSWORD --body ""
                
                # Other secrets
                echo ""
                echo "🔧 Other Secrets:"
                gh secret set HOMEBREW_GITHUB_API_TOKEN --body ""
                gh secret set CHOCOLATEY_API_KEY --body ""
                
                print_success "GitHub secrets setup completed!"
            else
                print_error "Not a GitHub repository. Please push to GitHub first."
            fi
        else
            print_error "No Git remote found. Please add GitHub remote first."
        fi
    fi
else
    print_warning "GitHub CLI not found. Install it to set up secrets automatically:"
    echo "   macOS: brew install gh"
    echo "   Windows: winget install GitHub.cli"
    echo "   Linux: See https://cli.github.com/manual/installation"
fi

echo ""
print_step "Next Steps:"
echo "1. Edit .env file with your actual values"
echo "2. Set up GitHub repository secrets (manually or with 'gh' CLI)"
echo "3. Get code signing certificates"
echo "4. Test the build process: npm run build"
echo "5. Create a release tag to trigger CI/CD: git tag v1.0.0 && git push origin v1.0.0"
echo ""

print_step "Useful Commands:"
echo "• Test local build: npm run build"
echo "• Start development: npm start"
echo "• View GitHub secrets: gh secret list"
echo "• Check build status: gh run list"
echo ""

print_success "Setup script completed! Check the output above for next steps."