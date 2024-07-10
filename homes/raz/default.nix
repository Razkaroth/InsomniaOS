let
  username = "raz";
  homeDirectory = "/home/raz";
in
{ pkgs, impurity, ... }: {
  imports = [
    # Cachix
    # ./cachix.nix
    ## Dotfiles (manual)
    ./dotfiles.nix
    # Stuff
    ./ags.nix
    ./anyrun.nix
    ./browser.nix
    ./dconf.nix
    ./hyprland.nix
    ./kitty.nix
    # ./mimelist.nix
    ./packages.nix
    # ./starship.nix
    ./sway.nix
    ./theme.nix
  ];

  home = {
    inherit username homeDirectory;
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      XCURSOR_SIZE = "24";
      # Other variables
      # NIX_BUILD_SHELL = "fish";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  xdg.userDirs = {
    createDirectories = true;
  };
  # xdg.mime.enable = true;

  gtk = {
    font = {
      name = "Rubik";
      package = pkgs.google-fonts.override { fonts = [ "Rubik" ]; };
      size = 11;
    };
    gtk3 = {
      bookmarks = [
        "file://${homeDirectory}/Downloads"
        "file://${homeDirectory}/Documents"
        "file://${homeDirectory}/Pictures"
        "file://${homeDirectory}/Music"
        "file://${homeDirectory}/Videos"
        "file://${homeDirectory}/.config"
        "file://${homeDirectory}/.config/ags"
        "file://${homeDirectory}/jale"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
  home.stateVersion = "23.11"; # this must be the version at which you have started using the program
}
