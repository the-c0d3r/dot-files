{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "the-c0d3r";
    settings.user.email = "4526565+the-c0d3r@users.noreply.github.com";
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
