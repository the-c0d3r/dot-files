{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.yank;
        extraConfig = ''
          # or 'copy-pipe-and-cancel' for the default
          set -g @yank_action 'copy-pipe'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.better-mouse-mode;
      }
      {
        plugin = pkgs.tmuxPlugins.tmux-nova;
        extraConfig = ''
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left
          set -g @nova-nerdfonts-right
          set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
          set -g @nova-segment-mode-colors "#50fa7b #282a36"
          set -g @nova-segment-whoami "#(whoami)@#h"
          set -g @nova-segment-whoami-colors "#50fa7b #282a36"
          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "whoami"
        '';
      }
    ];
    extraConfig = ''
      bind h select-pane -L  # move left
      bind j select-pane -D  # move down
      bind k select-pane -U  # move up
      bind l select-pane -R  # move right
      bind C-c new-session
      bind > swap-pane -D       # swap current pane with the next one
      bind < swap-pane -U       # swap current pane with the previous one

      # split current window horizontally
      bind - split-window -v
      # split current window vertically
      bind _ split-window -h

      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window # select previous window
      bind -r C-l next-window     # select next window
      bind Tab last-window        # move to last active window
    '';
  };
}
