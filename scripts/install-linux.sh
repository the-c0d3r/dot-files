#!/usr/bin/env bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# --- Color Definitions ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Error handler
trap 'echo -e "${RED}Error:${NC} Installation failed on line $LINENO"' ERR

echo -e "${BLUE}==>${NC} Starting Dotfiles Installation..."

# Set USER if not set (needed for home-manager)
export USER="${USER:-$(whoami)}"

# 1. Check for Nix
if ! command -v nix &> /dev/null; then
    echo -e "${BLUE}==>${NC} Nix not found. Installing Nix..."
    
    # Auto-detect if we can use daemon (multi-user) or need no-daemon (single-user)
    # Most containers don't have systemd, so they need --no-daemon
    if [ -d /run/systemd/system ]; then
        echo -e "${BLUE}==>${NC} Systemd detected. Using multi-user install..."
        curl -L https://nixos.org/nix/install | sh -s -- --daemon
    else
        echo -e "${BLUE}==>${NC} No systemd detected. Using single-user install..."
        curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    fi
    
    # Source nix profile for current shell
    for profile in "$HOME/.nix-profile/etc/profile.d/nix.sh" /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh "$HOME/.profile"; do
        if [ -f "$profile" ]; then
            echo -e "${BLUE}==>${NC} Sourcing $profile"
            . "$profile"
        fi
    done

    # Final fallback: add bin directly to path
    export PATH="$HOME/.nix-profile/bin:$PATH"
else
    echo -e "${GREEN}==>${NC} Nix is already installed."
fi

# Double check nix is available
if ! command -v nix &> /dev/null; then
    echo -e "${RED}Error:${NC} Nix installation seems to have failed or is not in PATH."
    exit 1
fi

# 2. Enable Flakes
echo -e "${BLUE}==>${NC} Ensuring Nix Flakes are enabled..."
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

# 3. Clone Repository (if not already in a dot-files dir)
REPO_URL="https://github.com/the-c0d3r/dot-files.git"
TARGET_DIR="$HOME/dot-files"

# If we are already in the target directory (or a subdirectory of it), don't clone
if [[ "$PWD" == "$TARGET_DIR"* ]]; then
    echo -e "${GREEN}==>${NC} Already inside dot-files directory."
elif [ ! -d "$TARGET_DIR/.git" ]; then
    echo -e "${BLUE}==>${NC} Cloning dotfiles repository to $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR" || exit
else
    echo -e "${GREEN}==>${NC} Repository already exists at $TARGET_DIR"
    cd "$TARGET_DIR" || exit
fi

# 4. Bootstrap Home Manager and Activate
echo -e "${BLUE}==>${NC} Activating dotfiles profile..."

# Activate the configuration directly using Nix
# This works without having home-manager pre-installed
echo -e "${BLUE}==>${NC} Running: nix run --impure ./nix#homeConfigurations.linux.activationPackage"
nix run --impure ./nix#homeConfigurations.linux.activationPackage

echo -e "${GREEN}==>${NC} Installation Complete! Restart your shell to see changes."
