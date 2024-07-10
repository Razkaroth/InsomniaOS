{ pkgs,  ... }:
let
    swww-pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
    }) {};

    swwwV0-9-1 = swww-pkgs.swww;
in
{
  imports = [
    ./programs
  ];
  home = {
    packages = with pkgs; with nodePackages_latest; with gnome; with libsForQt5; [
      i3 # gaming
      sway

      # gui
      anydesk
      blueberry
      bottles
      brave
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      chromium
      calibre
      d-spy
      dolphin
      figma-linux
      krita
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
      # spotify it is already handled by spicetify-nix
      typora
      libreoffice

      # Comms
      discord
      signal-desktop
      teams-for-linux
      zoom

      # Music
      sunvox

      # k8s
      kubectl
      lens
      doctl
      kubernetes-helm


      # tools
      aria2
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
      git-lfs
      foot
      # kitty
      starship
      showmethekey
      vscode
      qgis
      ydotool
      lazygit
      btop
      openssl
      nvidia-system-monitor-qt
      nix-output-monitor


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
      swwwV0-9-1
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
      thefuck
    ];
  };
}
