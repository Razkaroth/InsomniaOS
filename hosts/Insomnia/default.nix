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
    ./kanata
    # Programs
    ./nvim.nix
    ./nixarr.nix
  ];
}
