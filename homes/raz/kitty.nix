let
in {pkgs,  ...}:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    shellIntegration = {
      enableFishIntegration = true;
    };
    settings = {
      scrollback_lines = 10000;
      update_check_interval = 0;
      mouse_hide_wait = 3.0;
      detect_urls="yes";
      mouse_map="left click ungrabbed mouse_handle_click selection link prompt";
      notify_on_cmd_finish="unfocused";
      term="kitty";
    };
    font = {
      name = "FiraCode";
      size = 12;
    };
  };


}
