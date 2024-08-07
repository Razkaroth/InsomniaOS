{ pkgs, ... }:
{
  # Audio

  environment.systemPackages = with pkgs; [
    helvum
    easyeffects
  ];



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
