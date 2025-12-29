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

echo -e "${BLUE}==>${NC} Starting Dotfiles Bootstrap..."

# Set USER if not set (needed for home-manager)
export USER="${USER:-$(whoami)}"
OS="$(uname -s)"
ARCH="$(uname -m)"

# 1. Check for Nix
if ! command -v nix &> /dev/null; then
    echo -e "${BLUE}==>${NC} Nix not found. Installing Nix..."

    # Linux installation logic
    if [ -d /run/systemd/system ]; then
        echo -e "${BLUE}==>${NC} Systemd detected. Using multi-user install..."
        curl -L https://nixos.org/nix/install | sh -s -- --daemon
    else
        echo -e "${BLUE}==>${NC} No systemd detected. Using single-user install..."
        curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    fi

    # Source nix profile for current shell
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    elif [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
    
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
    # Ensure variables are set correctly even if we are already inside
    if [ "$PWD" != "$TARGET_DIR" ]; then
        cd "$TARGET_DIR" || exit
    fi
elif [ ! -d "$TARGET_DIR/.git" ]; then
    echo -e "${BLUE}==>${NC} Cloning dotfiles repository to $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR" || exit
else
    echo -e "${GREEN}==>${NC} Repository already exists at $TARGET_DIR"
    cd "$TARGET_DIR" || exit
fi

# 4. Activate Configuration
echo -e "${BLUE}==>${NC} Activating configuration for $OS..."

if [ "$OS" == "Darwin" ]; then
    # -- MacOS Logic --
    if [ "$ARCH" == "arm64" ]; then
        FLAKE_ATTR="mac-arm"
        echo "Detected Apple Silicon (arm64). Using flake: $FLAKE_ATTR"
    else
        FLAKE_ATTR="mac-intel"
        echo "Detected Intel Mac (x86_64). Using flake: $FLAKE_ATTR"
    fi

    # Use nix to run nix-darwin if darwin-rebuild isn't in path yet
    if ! command -v darwin-rebuild &> /dev/null; then
        echo -e "${BLUE}==>${NC} darwin-rebuild not found. Installing nix-darwin..."
        # We need to pass --impure because our flake uses builtins.getEnv
        nix run --impure nix-darwin -- switch --flake ".#$FLAKE_ATTR"
    else
        echo -e "${GREEN}==>${NC} darwin-rebuild found. Applying system configuration..."
        darwin-rebuild switch --flake ".#$FLAKE_ATTR" --impure
    fi

elif [ "$OS" == "Linux" ]; then
    # -- Linux Logic --
    # Detect if Kali
    if grep -q "Kali" /etc/os-release 2>/dev/null; then
         echo "Detected Kali Linux. Using flake: kali"
         FLAKE_ATTR="kali"
    else
         echo "Detected Generic Linux. Using flake: linux"
         FLAKE_ATTR="linux"
    fi

    echo -e "${BLUE}==>${NC} Running: nix run --impure .#homeConfigurations.$FLAKE_ATTR.activationPackage"
    nix run --impure ".#homeConfigurations.$FLAKE_ATTR.activationPackage"
else
    echo -e "${RED}Error:${NC} Unsupported OS: $OS"
    exit 1
fi

echo -e "${GREEN}==>${NC} Bootstrap Complete! Restart your shell to see changes."
