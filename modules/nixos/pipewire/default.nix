{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.pipewire.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pipewire.enable {
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    hardware.enableAllFirmware = true; # saw this somewhere, might help with stuff idk
    environment.systemPackages = with pkgs; [
      pulseaudio
      pavucontrol
      pamixer
      easyeffects
      calf
      libebur128
      zam-plugins
      zita-convolver
      rnnoise
      speexdsp
    ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
