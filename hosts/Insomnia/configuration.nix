{ pkgs, username, config, ... }: {
  # nix

  time.hardwareClockInLocalTime = true;
  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      # Nixpkgs-Wayland
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
      # Nix-community
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # Nixpkgs-Wayland
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # Nix-community
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5";
  };

  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "electron-29.4.6" ];

  # virtualisation
  # programs.virt-manager.enable = true;
  # virtualisation = {
  #   libvirtd.enable = true;
  # };

  # docker 
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services = {
    envfs.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    gvfs.enable = true;
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
    };
    udev.extraRules = ''
      SUBSYSTEM=="input", GROUP="input", MODE="0667"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="1ea7", ATTRS{idProduct}=="0907", MODE:="666", GROUP="plugdev"
      KERNEL=="hidraw*", ATTRS{idVendor}=="1ea7", ATTRS{idProduct}=="0907", MODE="0666", GROUP="plugdev"
    '';
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = { };
    # pam.services.swaylock-effects = {};
  };

  # dconf
  programs = {
    zsh.enable = true;
    fish.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      # Rocksmith extra setup
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.pkgsi686Linux.pipewire.jack ];
        extraPkgs = pkgs: [ pkgs.wineasio ];
      };
      gamescopeSession.enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
    firefox = {
      enable = true;
      nativeMessagingHosts.packages =
        [ pkgs.plasma5Packages.plasma-browser-integration ];
    };
    # Run dynamically linked stuff
    nix-ld = {
      enable = true;
      libraries = with pkgs;
        [
          # Add any missing dynamic libraries for unpackaged programs
          # here, NOT in environment.systemPackages
        ];
    };
  };
  # packages
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      lshw
      curl
      zsh
      fzf
      fish
      git
      gh
      # tailscale
      # home-manager
      wget
      nixpkgs-fmt
      nixfmt-classic
      ripgrep
      hyprcursor
      libimobiledevice
      # Gaming
      mangohud
      protontricks
      winetricks
      protonup
      # - launchers
      lutris
      heroic
    ];
  };

  # ZRAM
  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';
  # user
  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "media"
        "video"
        "input"
        "uinput"
        "libvirtd"
        "plugdev"
      ];
    };
  };

  # network
  networking = {
    hostName = "Insomnia";
    networkmanager.enable = true;
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf"
  ];
  services.blueman.enable = true;

  # Boot
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "btrfs" "ext4" "fat32" "ntfs" ];
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelPatches = [{
    #   name = "enable RT_FULL";
    #   patch = null;
    #   # TODO: add realtime patch: PREEMPT_RT y
    #   extraConfig = ''
    #     PREEMPT y
    #     PREEMPT_BUILD y
    #     PREEMPT_VOLUNTARY n
    #     PREEMPT_COUNT y
    #     PREEMPTION y
    #   '';
    # }];
    # extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    # kernelModules = [ "acpi_call" ];
    # make 3.5mm jack work
    # extraModprobeConfig = ''
    #   options snd_hda_intel model=headset-mode
    # '';
  };

  system.stateVersion = "23.11";
}
