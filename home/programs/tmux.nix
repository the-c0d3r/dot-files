{
  config,
  pkgs,
  lib,
  ...
}:

let
  nova = "${pkgs.tmuxPlugins.tmux-nova}/share/tmux-plugins/tmux-nova/nova.tmux";
  palettes = {
    # Everforest Light Soft
    light = {
      bg = "#EAE4CA";
      fg = "#5C6A72";
      base = "#F3EAD3";
      dim = "#E5DFC5";
      border = "#D3C6AA";
      green = "#8DA101";
      purple = "#DF69BA";
      blue = "#3A94C5";
    };
    # Everforest Dark Medium
    dark = {
      bg = "#343F44";
      fg = "#D3C6AA";
      base = "#2D353B";
      dim = "#3D484D";
      border = "#475258";
      green = "#A7C080";
      purple = "#D699B6";
      blue = "#7FBBB3";
    };
  };
  novaTheme =
    name:
    let
      p = palettes.${name};
    in
    pkgs.writeText "nova-${name}.conf" ''
      set -g @nova-status-style-bg "${p.bg}"
      set -g @nova-status-style-fg "${p.fg}"
      set -g @nova-status-style-active-bg "${p.green}"
      set -g @nova-status-style-active-fg "${p.base}"
      set -g @nova-segment-mode-colors "${p.purple} ${p.base}"
      set -g @nova-segment-whoami-colors "${p.blue} ${p.base}"
      set -g @nova-pane-border-style "${p.border}"
      set -g @nova-pane-active-border-style "${p.green}"
      set -g @nova-message-style-bg "${p.dim}"
      set -g @nova-message-style-fg "${p.fg}"
      set -g @nova-message-command-style-bg "${p.dim}"
      set -g @nova-message-command-style-fg "${p.fg}"
      set -g @nova-mode-style-bg "${p.blue}"
      set -g @nova-mode-style-fg "${p.base}"
    '';
  # palette for the current client's theme (no client yet at server start: light)
  pickNova = ''if -F "#{==:#{client_theme},dark}" "source-file ${novaTheme "dark"}" "source-file ${novaTheme "light"}"'';
in
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    baseIndex = 1; # start windows numbering at 1
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
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-processes 'ssh psql sqlite3'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.tmux-nova;
        extraConfig = ''
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 
          set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
          set -g @nova-segment-whoami "#(whoami)@#h"
          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "whoami"

          # Everforest colors following the terminal's light/dark report; nova only reads them when it runs
          set-hook -g client-light-theme 'source-file ${novaTheme "light"} ; run-shell ${nova}'
          set-hook -g client-dark-theme 'source-file ${novaTheme "dark"} ; run-shell ${nova}'
          set-hook -g client-attached '${pickNova} ; run-shell ${nova}'
          ${pickNova}
        '';
      }
    ];
    extraConfig = ''
      # Window numbering
      setw -g pane-base-index 1     # make pane numbering consistent with windows
      set -g renumber-windows on    # renumber windows when a window is closed

      # Status bar position
      set -g status-position bottom

      # Copy to OS clipboard
      set -g set-clipboard on

      # Refresh kitty's path on attach; the tmux server outlives kitty updates (new store path)
      set -ga update-environment "KITTY_INSTALLATION_DIR"

      # Pane navigation (unbind first to remove -r flag from defaults)
      unbind h
      unbind j
      unbind k
      unbind l
      bind h select-pane -L  # move left
      bind j select-pane -D  # move down
      bind k select-pane -U  # move up
      bind l select-pane -R  # move right
      bind C-c new-session
      bind > swap-pane -D       # swap current pane with the next one
      bind < swap-pane -U       # swap current pane with the previous one

      # split current window horizontally
      bind - split-window -v -c "#{pane_current_path}"
      # split current window vertically
      bind _ split-window -h -c "#{pane_current_path}"

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

      # Send prefix to inner tmux session (nested tmux)
      bind-key C-a send-prefix

      # copy mode
      bind Enter copy-mode                                # enter copy mode
      bind -T copy-mode-vi v send -X begin-selection      # start selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle   # toggle rectangle selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line
    '';
  };
}
