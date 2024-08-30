{ pkgs, ... }:
let
  swww-pkgs = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
  }) { };

  swwwV0-9-1 = swww-pkgs.swww;

in {
  imports = [ ./programs ];
  home = {
    packages = with pkgs;
      with nodePackages_latest;
      with libsForQt5; [
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
        docker-compose
        dolphin
        figma-linux
        krita
        kolourpaint
        github-desktop
        google-chrome
        nautilus
        gwenview
        icon-library
        dconf-editor
        qt5.qtimageformats
        vlc
        yad
        pomodoro
        obsidian
        obs-studio
        docker
        # spotify is already handled by spicetify-nix
        typora
        transmission-gtk
        libreoffice

        # Comms
        discord
        signal-desktop
        # teams-for-linux
        whatsapp-for-linux
        zoom-us

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
        gifski
        libnotify
        killall
        quarto
        zip
        zoxide
        tmux
        unzip
        glib
        git-lfs
        foot
        devenv
        starship
        showmethekey
        vscode
        #qgis
        ydotool
        lazygit
        btop
        openssl
        nvidia-system-monitor-qt
        nix-output-monitor
        postman
        insomnia
        speedtest-cli

        #forensics

        #DB
        sqlite
        sqlitebrowser
        mongodb-compass

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
        # swwwV0-9-1
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
        thefuck
        #solaar
      ];
  };
}
