#!/usr/bin/env bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# --- Color Definitions ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}==>${NC} Applying Dotfiles Configuration..."

# Set USER if not set
export USER="${USER:-$(whoami)}"
OS="$(uname -s)"
ARCH="$(uname -m)"

# Navigate to the script directory
cd "$(dirname "$0")"

# 1. Detect Configuration Fragment
if [ "$OS" == "Darwin" ]; then
    if [ "$ARCH" == "arm64" ]; then
        FLAKE_ATTR="mac-arm"
    else
        FLAKE_ATTR="mac-intel"
    fi
    echo -e "${BLUE}==>${NC} Detected macOS ($ARCH). Using fragment: $FLAKE_ATTR"

    # Apply Home Manager (User settings)
    echo -e "${BLUE}==>${NC} Applying User Configuration (home-manager)..."
    if command -v home-manager &> /dev/null; then
        home-manager switch --flake "./nix#$FLAKE_ATTR" --impure
    else
        echo -e "${BLUE}==>${NC} home-manager not found. Bootstrapping with nix run..."
        nix run --impure home-manager -- switch --flake "./nix#$FLAKE_ATTR"
    fi

    # Apply System Configuration (nix-darwin)
    echo -e "${BLUE}==>${NC} Applying System Configuration (nix-darwin)..."
    if command -v darwin-rebuild &> /dev/null; then
        darwin-rebuild switch --flake "./nix" --impure
    else
        echo -e "${BLUE}==>${NC} darwin-rebuild not found. Bootstrapping with nix run..."
        nix run --impure nix-darwin -- switch --flake "./nix"
    fi

elif [ "$OS" == "Linux" ]; then
    if grep -q "Kali" /etc/os-release 2>/dev/null; then
         FLAKE_ATTR="kali"
    else
         FLAKE_ATTR="linux"
    fi
    echo -e "${BLUE}==>${NC} Detected $FLAKE_ATTR. Applying User Configuration..."
    
    if command -v home-manager &> /dev/null; then
        home-manager switch --flake "./nix#$FLAKE_ATTR" --impure
    else
        echo -e "${BLUE}==>${NC} home-manager not found. Bootstrapping with nix run..."
        nix run --impure home-manager -- switch --flake "./nix#$FLAKE_ATTR"
    fi
else
    echo -e "${RED}Error:${NC} Unsupported OS: $OS"
    exit 1
fi

echo -e "${GREEN}==>${NC} Configuration applied successfully!"
