{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Terminal colour names, so the prompt follows kitty's light/dark palette;
      # segment text is a fixed dark (Everforest dark bg): ANSI black is too light on the light theme
      format = lib.concatStrings [
        "[](red)"
        "$os"
        "$username"
        "[](bg:yellow fg:red)"
        "$directory"
        "[](bg:green fg:yellow)"
        "$git_branch"
        "$git_status"
        "[](fg:green bg:cyan)"
        "$c$rust$golang$nodejs$php$java$kotlin$haskell$python"
        "[](fg:cyan bg:blue)"
        "$conda"
        "[](fg:blue bg:purple)"
        "$time"
        "[ ](fg:purple)"
        "$line_break"
        "$character"
      ];

      os = {
        disabled = false;
        style = "bg:red fg:#2D353B";
        symbols = {
          Windows = "";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          NixOS = "󱄅";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:red fg:#2D353B";
        style_root = "bg:red fg:#2D353B";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:yellow fg:#2D353B";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol $branch ](fg:#2D353B bg:green)]($style)";
      };

      git_status = {
        style = "bg:green";
        format = "[[($all_status$ahead_behind )](fg:#2D353B bg:green)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version) ](fg:#2D353B bg:cyan)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:cyan";
        format = "[[ $symbol( $version)(\\($virtualenv\\)) ](fg:#2D353B bg:cyan)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol( $context) ](fg:#2D353B bg:blue)]($style)";
      };

      conda = {
        symbol = "  ";
        style = "fg:#2D353B bg:blue";
        format = "[$symbol$environment ]($style)";
        ignore_base = false;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:purple";
        format = "[[  $time ](fg:#2D353B bg:purple)]($style)";
      };

      line_break = {
        disabled = true;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:purple)";
        vimcmd_replace_symbol = "[❮](bold fg:purple)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };
    };
  };
}
