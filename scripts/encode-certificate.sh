#!/bin/bash

# Certificate Encoding Helper Script
# Helps encode certificates for GitHub Secrets

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

echo "🔐 Certificate Encoding Helper"
echo "============================="
echo ""

print_step "This script helps you encode certificates for GitHub Secrets"
echo ""

echo "What would you like to encode?"
echo "1) Apple Developer Certificate (.p12)"
echo "2) Windows Code Signing Certificate (.p12)"
echo "3) Custom file"
echo ""

read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        cert_type="Apple Developer Certificate"
        secret_name="APPLE_CERT_DATA"
        ;;
    2)
        cert_type="Windows Code Signing Certificate"
        secret_name="WIN_CSC_LINK"
        ;;
    3)
        read -p "Enter description: " cert_type
        read -p "Enter secret name: " secret_name
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
print_step "Processing $cert_type"
echo ""

read -p "Enter the path to your certificate file: " cert_path

# Check if file exists
if [ ! -f "$cert_path" ]; then
    print_error "File not found: $cert_path"
    exit 1
fi

# Get file size
file_size=$(wc -c < "$cert_path")
print_step "File size: $file_size bytes"

# Encode the certificate
print_step "Encoding certificate to base64..."
encoded_cert=$(base64 -i "$cert_path")

# Create output file
output_file="encoded-certificate.txt"
echo "$encoded_cert" > "$output_file"

print_success "Certificate encoded successfully!"
echo ""

print_step "Results:"
echo "• Encoded certificate saved to: $output_file"
echo "• GitHub Secret name: $secret_name"
echo "• Original file size: $file_size bytes"
echo "• Encoded size: $(wc -c < "$output_file") characters"
echo ""

print_step "Next steps:"
echo "1. Copy the content of $output_file"
echo "2. Go to your GitHub repository settings"
echo "3. Navigate to Secrets and variables > Actions"
echo "4. Create a new secret named: $secret_name"
echo "5. Paste the encoded content as the secret value"
echo ""

print_warning "Security reminder:"
echo "• Delete $output_file after copying to GitHub"
echo "• Never commit certificate files to Git"
echo "• Keep your certificate password secure"
echo ""

# Option to set secret directly if GitHub CLI is available
if command -v gh &> /dev/null; then
    echo ""
    read -p "Set this secret in GitHub now using GitHub CLI? (y/n): " set_now
    if [[ "$set_now" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_step "Setting GitHub secret..."
        if gh secret set "$secret_name" < "$output_file"; then
            print_success "Secret $secret_name set successfully!"
        else
            print_error "Failed to set secret. You may need to authenticate with 'gh auth login'"
        fi
    fi
fi

echo ""
read -p "Delete the encoded file now for security? (y/n): " delete_file
if [[ "$delete_file" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    rm "$output_file"
    print_success "Encoded file deleted for security"
else
    print_warning "Remember to delete $output_file manually after use"
fi

echo ""
print_success "Certificate encoding completed!"