let
in
{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    shellIntegration = {
      enableFishIntegration = true;
    };
    extraConfig =
      ''
        include ~/.cache/wal/colors-kitty.conf

        # set background to black


        confirm_os_window_close 0
        font_family FiraCode
        font_size 12
        line_height 1.0
        window_padding_width 5
        detect_urls yes
        mouse_map shift+left click grabbed,ungrabbed mouse_handle_click selection link prompt
      '';
  };
}
