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

# --- 1. Ensure Nix is installed ---
if ! command -v nix &> /dev/null; then
    echo -e "${BLUE}==>${NC} Nix not found. Installing Nix..."
    if [ "$OS" == "Darwin" ]; then
        curl -L https://nixos.org/nix/install | sh -s -- --daemon
    elif [ "$OS" == "Linux" ]; then
        if [ -d /run/systemd/system ]; then
            curl -L https://nixos.org/nix/install | sh -s -- --daemon
        else
            curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
        fi
    fi
    
    # Source nix profile
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    elif [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
fi

# --- 2. Ensure Flakes are enabled ---
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

# --- 3. Ensure Repository is cloned ---
REPO_URL="https://github.com/the-c0d3r/dot-files.git"
TARGET_DIR="$HOME/dot-files"

if [ -d "$TARGET_DIR/.git" ]; then
    echo -e "${GREEN}==>${NC} Repository already exists at $TARGET_DIR"
    cd "$TARGET_DIR"
elif [[ "${BASH_SOURCE[0]:-}" == *"apply.sh"* ]]; then
    # We are running a local file, but maybe not in the right dir
    REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cd "$REPO_ROOT"
else
    # We are likely running via curl | bash
    echo -e "${BLUE}==>${NC} Cloning dotfiles repository to $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR"
fi


# --- 4. Generate vars.nix if missing (Pure & Private pattern) ---
echo -e "${BLUE}==>${NC} Generating vars.nix for pure evaluation..."
echo "{ username = \"$(whoami)\"; }" > vars.nix
git add -N -f vars.nix 2>/dev/null || true

# --- 5. Activate Configuration ---
if [ "$OS" == "Darwin" ]; then
    if [ "$ARCH" == "arm64" ]; then
        FLAKE_ATTR="mac-arm"
    else
        FLAKE_ATTR="mac-intel"
    fi
    echo -e "${BLUE}==>${NC} Detected macOS ($ARCH). Using fragment: $FLAKE_ATTR"

    # Apply Home Manager
    echo -e "${BLUE}==>${NC} Applying User Configuration (home-manager)..."
    if command -v home-manager &> /dev/null; then
        home-manager switch --flake ".#$FLAKE_ATTR"
    else
        nix run home-manager -- switch --flake ".#$FLAKE_ATTR"
    fi

    # Apply System Configuration (nix-darwin)
    echo -e "${BLUE}==>${NC} Applying System Configuration (nix-darwin)..."
    if command -v darwin-rebuild &> /dev/null; then
        darwin-rebuild switch --flake "."
    else
        nix run nix-darwin -- switch --flake "."
    fi

elif [ "$OS" == "Linux" ]; then
    if grep -q "Kali" /etc/os-release 2>/dev/null; then
         FLAKE_ATTR="kali"
    else
         FLAKE_ATTR="linux"
    fi
    echo -e "${BLUE}==>${NC} Detected $FLAKE_ATTR. Applying User Configuration..."
    
    if command -v home-manager &> /dev/null; then
        home-manager switch --flake ".#$FLAKE_ATTR"
    else
        # Fallback to nix run if home-manager is not yet in path
        nix run ".#homeConfigurations.$FLAKE_ATTR.activationPackage"
    fi
else
    echo -e "${RED}Error:${NC} Unsupported OS: $OS"
    exit 1
fi

echo -e "${GREEN}==>${NC} Configuration applied successfully!"
