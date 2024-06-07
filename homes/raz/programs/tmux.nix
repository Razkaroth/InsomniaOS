{ pkgs, ... }:
let

  # tmux-which-key = pkgs.tmuxPlugins.mkTmuxPlugin
  #   {
  #     pluginName = "tmux-which-key";
  #     version = "main-2024-05-09";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "alexwforsythe";
  #       repo = "tmux-which-key/";
  #       rev = "57220071739c723c3a318e9d529d3e5045f503b8";
  #       sha256 = "sha256-zpg7XJky7PRa5sC7sPRsU2ZOjj0wcepITLAelPjEkSI=";
  #     };
  #   };
  #
in
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;

    baseIndex = 1;
    prefix = "M-s";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = sensible;
        extraConfig = ''
        exec-once = tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"
          # tmux-sensible
          set -g mouse on
          # open panes in current directory
          bind '"' split-window -c '#{pane_current_path}'
          bind % split-window -h -c '#{pane_current_path}'

          # window rezise with arrow keys
          bind -n M-Up resize-pane -U 5
          bind -n M-Down resize-pane -D 5
          bind -n M-Left resize-pane -L 5
          bind -n M-Right resize-pane -R 5

          # bind a to create a new window and A to create a new session
          bind a new-window
          bind A new-session

        '';
      }
      vim-tmux-navigator
      {
        plugin = yank;
        extraConfig = ''
          # Copy to system clipboard
          set -g @yank_selection 'clipboard'
          set-window-option -g mode-keys vi
          # key bindings
          bind-key -T copy-mode-vi 'v' send -X begin-selection
          bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
          bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle
        '';
      }
      {
        plugin = power-theme;
        extraConfig = ''
          # Theme
          set -g @tmux_power_theme 'default'
          # 'L' for left only, 'R' for right only and 'LR' for both
          set -g @tmux_power_prefix_highlight_pos 'LR'
          # set -g status-right '𒀪: #{continuum_status}'
        '';
      }
      prefix-highlight
      {
        plugin = resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      # {
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-boot 'on'
      #     set -g @continuum-save-interval '1'
      #   '';
      # }
    ];

  };
}
