{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      ".idea"
      "**/.idea"
      "logs/*/"
      "logs/*.log"
      "logs/*.log.*"
      "__pycache__"
      "**/__pycache__"
      "env/"
      ".venv/"
      ".DS_Store"
      "**/.DS_Store"
    ];
  };
}
