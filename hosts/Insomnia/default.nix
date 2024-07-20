{
  imports = [
    ./audio.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./gnome.nix
    ./laptop.nix
    ./locale.nix
    ./overlays.nix
    ./tailscale.nix
    # Programs
    ./nvim.nix
    # ./sonarr.nix
  ];
}
