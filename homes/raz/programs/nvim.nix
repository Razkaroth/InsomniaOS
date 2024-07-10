{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = ps: [ ps.imagemagick ];
    # ... other config
  };
}
