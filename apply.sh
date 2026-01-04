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
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

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

# Determine Flake Attribute based on OS/Arch
if [ "$OS" == "Darwin" ]; then
    [[ "$ARCH" == "arm64" ]] && FLAKE_ATTR="mac-arm" || FLAKE_ATTR="mac-intel"
elif [ "$OS" == "Linux" ]; then
    grep -q "Kali" /etc/os-release 2>/dev/null && FLAKE_ATTR="kali" || FLAKE_ATTR="linux"
else
    echo -e "${RED}Error:${NC} Unsupported OS: $OS"
    exit 1
fi

echo -e "${BLUE}==>${NC} Detected $OS ($ARCH). Applying User Configuration ($FLAKE_ATTR)..."

# Apply Configuration
# Apply Configuration
if [ "$OS" == "Darwin" ]; then
    DARWIN_REBUILD_CMD="darwin-rebuild"

    # Check for standard nix-darwin location (works best with sudo)
    if [ -x "/run/current-system/sw/bin/darwin-rebuild" ]; then
         DARWIN_REBUILD_CMD="/run/current-system/sw/bin/darwin-rebuild"
    elif ! command -v darwin-rebuild &> /dev/null; then
        echo -e "${BLUE}==>${NC} darwin-rebuild not found in PATH. Bootstrapping..."
        # Build darwin-rebuild from the nix-darwin flake
        DR_PATH=$(nix build --no-link --print-out-paths --extra-experimental-features "nix-command flakes" "github:LnL7/nix-darwin#darwin-rebuild")
        DARWIN_REBUILD_CMD="$DR_PATH/bin/darwin-rebuild"
        echo -e "${GREEN}==>${NC} Using bootstrapped darwin-rebuild at $DARWIN_REBUILD_CMD"
    fi

    echo "> Running darwin-rebuild switch as root..."
    # Execute directly - sudo allows absolute paths even with secure_path enabled
    sudo "$DARWIN_REBUILD_CMD" switch --flake ".#$FLAKE_ATTR"

else
    # Linux / Home Manager Standalone
    if command -v home-manager &> /dev/null; then
        home-manager switch --flake ".#$FLAKE_ATTR"
    else
        nix run home-manager -- switch --flake ".#$FLAKE_ATTR"
    fi
fi

echo -e "${GREEN}==>${NC} Configuration applied successfully!"
