{ config, pkgs, ... }: {
  environment = {
    sessionVariables = {
      XCURSOR_SIZE = "24";
      NAUTILUS_EXTENSION_DIR =
        "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [ "/share/nautilus-python/extensions" ];

    systemPackages = with pkgs; [
      gnome-extension-manager
      nautilus-open-any-terminal
      morewaita-icon-theme
      bibata-cursors
      rubik
      lexend
      nautilus-python
      twitter-color-emoji
      seahorse
      gnome-keyring
    ];

    gnome.excludePackages = (with pkgs; [
      gedit # text editor
      gnome-photos
      gnome-tour
      gnome-connections
      snapshot
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      evince # document viewer
      # gnome-characters
      totem # video player
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
      gnome-shell-extensions
      gnome-maps
      gnome-music
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]) ++ (with pkgs.gnome;
      [
        # gnome-font-viewer
      ]);
  };
}
