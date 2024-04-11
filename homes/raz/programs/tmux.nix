{pkgs, ...}:
let
modern-tmux-theme = mkTmuxPlugin {
  pluginName = "modern-tmux-theme";
  version = "unstable-2023-01-06";
  src = fetchFromGitHub {
    owner = "Millrocious";
    repo = "modern-tmux-theme";
    rev = "29dad92c8a2486e5b6f116e42883906c00a1f0a2";
    sha256 = "sha256-ymmCI6VYvf94Ot7h2GAboTRBXPIREP+EB33+px5aaJk=";
  };
};
in {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    prefix = "M-s";

    plugins = with pkgs.tmuxPlugins [
      sensible
        vim-tmux-navigator
        yank
        power-theme
        prefix-highlight
        resurrect
        continuum
    ];

    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded..."

      # Theme
      set -g @tmux_power_theme 'default'
      # 'L' for left only, 'R' for right only and 'LR' for both
      set -g @tmux_power_prefix_highlight_pos 'LR'
      set -g @continuum-restore 'on' 
      # for vim
      set -g @resurrect-strategy-vim 'session'
      # for neovim
      set -g @resurrect-strategy-nvim 'session'
      
      # tmux-yank
      set-window-option -g mode-keys vi
      # key bindings
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle

      # open panes in current directory
      bind '"' split-window -c '#{pane_current_path}'
      bind % split-window -h -c '#{pane_current_path}'

      # window rezise with arrow keys
      bind -n M-Up resize-pane -U 5
      bind -n M-Down resize-pane -D 5
      bind -n M-Left resize-pane -L 5
      bind -n M-Right resize-pane -R 5


      # tmux-sensible
      set -g mouse on

      #### Key bindings
      # Window movement
      bind -n M-H previous-window
      bind -n M-L next-window
    ''
  };
}
