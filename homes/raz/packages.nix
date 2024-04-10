{ pkgs, ... }:
{

  home = {
    packages = with pkgs; with nodePackages_latest; with gnome; with libsForQt5; [
      i3 # gaming
      sway

      # gui
      blueberry
      bottles
      brave
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      chromium
      d-spy
      dolphin
      figma-linux
      kolourpaint
      github-desktop
      google-chrome
      gnome.nautilus
      gwenview
      icon-library
      dconf-editor
      qt5.qtimageformats
      vlc
      mongodb-compass
      yad
      obsidian
      obs-studio
      docker
      spotify
      spicetify-cli

      # Comms
      discord
      signal-desktop
      teams-for-linux


      # Music
      sunvox

      # k8s
      kubectl
      lens
      doctl
      kubernetes-helm


      # tools
      bat
      eza
      fd
      ripgrep
      fzf
      socat
      jq
      gojq
      acpi
      ffmpeg
      libnotify
      killall
      zip
      zoxide
      tmux
      unzip
      glib
      foot
      kitty
      starship
      showmethekey
      vscode
      ydotool
      lazygit
      btop
      nvidia-system-monitor-qt


      # theming tools
      gradience
      gnome-tweaks

      # hyprland
      brightnessctl
      cliphist
      fuzzel
      grim
      hyprpicker
      tesseract
      imagemagick
      pavucontrol
      playerctl
      swappy
      swaylock-effects
      swayidle
      slurp
      swww
      wayshot
      wlsunset
      wl-clipboard
      wf-recorder

      # langs
      nodejs
      corepack
      gjs
      bun
      cargo
      go
      gcc
      gnumake
      cmakeMinimal
      typescript
      eslint
      # very important stuff
      uwuify
      neofetch
    ];
  };
}
