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
    # KBD
    ./kanata.nix
    # Programs
    ./nvim.nix
  ];
}
