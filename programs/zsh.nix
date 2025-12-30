{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 999999999;
      save = 999999999;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = false;
    };
    setOptions = [
      # ignore all the duplicated command consecutively
      "HIST_IGNORE_ALL_DUPS" 
      # Do not display a line previously found
      "HIST_FIND_NO_DUPS"    
      # Dont write duplicate entries in the history file
      "HIST_SAVE_NO_DUPS"    
    ];
    shellAliases = {
      # system aliases
      l = "ls -lah --color=auto";
      ll = "ls -l";
      ip = "ip --color=auto";

      # program aliases
      lg = "lazygit";

      # vim aliases
      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      # tmux aliases
      tmls = "tmux ls";
      tmat = "tmux attach -t";
      tmns = "tmux new -s";
      tmkl = "tmux kill-session -t";

      # git aliases
      gs = "git status";
      ga = "git add";
      gdh = "git diff HEAD";     # see what's the uncommited changes
      gdhp = "git diff HEAD^";   # see what's the previous commit changes
      gdm = "git diff master";
      gp = "git push";
      gcan = "git commit --amend --no-edit";
      gamd = "git commit --amend";
    };

    initContent = ''
      # === Extra files to be sourced
      source ~/.pythonrc
      # file_source ~/.secrets

      function wsyncd() {
          usage="Usage: wsyncd dirname sshpath"
          if [ -z "$1" ] && [ -z "$2" ]; then
              echo "$usage"
              return
          fi

          dirname="$1"
          sshpath="$2"

          fswatch -o "$dirname" | while read f; do rsync -av "$dirname/" "$sshpath/"; done;
      }

      function lineprof() {
          if [  -z "$1" ]; then
              echo "Usage: lineprof test.py"
          else
              kernprof -l "$1" && python -m line_profiler "$1.lprof"
          fi;
      }

      # Explicitly bind Ctrl-R to Atuin, in case vi-mode overwrites it
      bindkey '^r' atuin-search
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "sudo" "docker" "python" "vi-mode" "autojump" 
        "colored-man-pages"
      ];
      theme = "robbyrussell";
    };
  };
}
