#!/usr/bin/env bash
# Evaluate every flake configuration (no build) to catch Nix errors before commit.
set -euo pipefail
cd "$(dirname "$0")/.."

eval_all() { # <output> <attr suffix>
  local name
  for name in $(nix eval ".#$1" --apply builtins.attrNames --json | tr -d '[]"' | tr ',' ' '); do
    echo "eval $1.$name"
    nix eval --raw ".#$1.\"$name\".$2" >/dev/null
  done
}

eval_all homeConfigurations activationPackage.drvPath
eval_all nixosConfigurations config.system.build.toplevel.drvPath
eval_all darwinConfigurations system.drvPath
