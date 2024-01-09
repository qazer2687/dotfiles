{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.pipewire.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.pipewire.enable {
    sound.enable = true;
    security.rtkit.enable = true;
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
