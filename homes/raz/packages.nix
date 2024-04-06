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
      icon-library
      dconf-editor
      qt5.qtimageformats
      vlc
      yad
      obsidian
      obs-studio
      docker
      discord
      spotify
      spicetify-cli
      signal-desktop

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
      gjs
      bun
      cargo
      go
      gcc
      typescript
      eslint
      # very important stuff
      uwuify
    ];
  };
}