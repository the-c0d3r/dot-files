#!/usr/bin/env bash

set -euo pipefail

GREEN='\033[0;32m'; BLUE='\033[0;34m'; RED='\033[0;31m'; NC='\033[0m'
info() { echo -e "${BLUE}==>${NC} $*"; }
ok()   { echo -e "${GREEN}==>${NC} $*"; }
die()  { echo -e "${RED}Error:${NC} $*"; exit 1; }

info "Applying Dotfiles Configuration..."

SERVER_MODE=false
VM_MODE=false
[ "${1:-}" = "--server" ] && SERVER_MODE=true
[ "${1:-}" = "--vm" ]     && VM_MODE=true

export USER="${USER:-$(whoami)}"
OS="$(uname -s)"
ARCH="$(uname -m)"

# --- Nix ---
if ! command -v nix &>/dev/null; then
    info "Nix not found. Installing..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' 2>/dev/null || \
    . "$HOME/.nix-profile/etc/profile.d/nix.sh" 2>/dev/null || true
fi

mkdir -p ~/.config/nix
grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null || \
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# --- Repo ---
REPO_URL="https://github.com/the-c0d3r/dot-files.git"
TARGET_DIR="$HOME/dot-files"
if [ -d "$TARGET_DIR/.git" ]; then
    ok "Repository already exists at $TARGET_DIR"
    cd "$TARGET_DIR"
elif [[ "${BASH_SOURCE[0]:-}" == *"apply.sh"* ]]; then
    cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    info "Cloning dotfiles to $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR" && cd "$TARGET_DIR"
fi

# --- vars.nix ---
ACTUAL_USER="${SUDO_USER:-$USER}"
info "Generating vars.nix for user: $ACTUAL_USER"
echo "{ username = \"$ACTUAL_USER\"; }" > vars.nix

# --- VM mode ---
if [ "$VM_MODE" = "true" ]; then
    [ "$OS" != "Linux" ] && die "--vm is only supported on Linux"
    info "Building VM..."
    nix build .#nixosConfigurations.vm.config.system.build.vm
    ok "VM built. Launching..."
    exec ./result/bin/run-*-vm
fi

# --- Detect target ---
NIXOS=false
if [ "$SERVER_MODE" = "true" ]; then
    [ "$OS" != "Linux" ] && die "--server is only supported on Linux"
    FLAKE_ATTR="server"
elif [ "$OS" = "Darwin" ]; then
    [ "$ARCH" = "arm64" ] && FLAKE_ATTR="mac-arm" || FLAKE_ATTR="mac-intel"
elif [ "$OS" = "Linux" ]; then
    if   grep -q "ID=nixos" /etc/os-release 2>/dev/null; then NIXOS=true; FLAKE_ATTR="$(hostname)"
    elif grep -q "Kali"     /etc/os-release 2>/dev/null; then FLAKE_ATTR="kali"
    else FLAKE_ATTR="linux"
    fi
else
    die "Unsupported OS: $OS"
fi

info "Detected $OS ($ARCH) → applying '$FLAKE_ATTR'"

# --- Apply ---
current_gen() {
    readlink -f /run/current-system 2>/dev/null || \
    readlink -f ~/.local/state/nix/profiles/home-manager 2>/dev/null || true
}

OLD_GEN="$(current_gen)"

if [ "$OS" = "Darwin" ]; then
    if   [ -x "/run/current-system/sw/bin/darwin-rebuild" ]; then DR="/run/current-system/sw/bin/darwin-rebuild"
    elif command -v darwin-rebuild &>/dev/null;               then DR="darwin-rebuild"
    else
        info "darwin-rebuild not found. Bootstrapping..."
        DR="$(nix build --no-link --print-out-paths \
            --extra-experimental-features "nix-command flakes" \
            "github:LnL7/nix-darwin#darwin-rebuild")/bin/darwin-rebuild"
    fi
    sudo "$DR" switch --flake ".#$FLAKE_ATTR"
elif [ "$NIXOS" = "true" ]; then
    sudo nixos-rebuild switch --flake ".#$FLAKE_ATTR"
else
    if command -v home-manager &>/dev/null
        then home-manager switch --flake ".#$FLAKE_ATTR"
        else nix run home-manager -- switch --flake ".#$FLAKE_ATTR"
    fi
fi

ok "Configuration applied successfully!"

# --- Diff ---
NEW_GEN="$(current_gen)"
if [ -n "$OLD_GEN" ] && [ "$OLD_GEN" != "$NEW_GEN" ]; then
    nvd diff "$OLD_GEN" "$NEW_GEN" 2>/dev/null || info "(nvd not available yet)"
else
    info "No changes (same generation)"
fi
