{ pkgs, ... }:
{
  # Audio

  environment.systemPackages = with pkgs; [
    helvum
    easyeffects
  ];

  # easyeffects systemd started service

  systemd.services.easyeffects = {
    description = "EasyEffects";
    after = [ "pulseaudio.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects";
      Restart = "always";
      RestartSec = 5;
      User = "raz";
      Group = "users";
      Environment = "XDG_RUNTIME_DIR=/run/user/1000";
    };
  };

  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
